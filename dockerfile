# FORTAN BUILD ENVIRONMENT
# A environment that builds the model then running the docker container will run the model

# to BUILD => `docker build . -t fortran_environment_tests_local`
# to RUN =>  `docker run -it -v <local path to project>:/app fortran_environment_tests_local`


FROM ubuntu

# Setup dependencis
RUN apt-get update && apt-get install -qq \
    build-essential \
    pkg-config \
    gfortran \
    liblapack-dev

# Add python
RUN apt-get update &&  apt-get install -qq software-properties-common
RUN apt-get update &&  add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update && apt-get install -qq python2.7
RUN apt-get update && apt-get install -qq python3.7
RUN ln -s /usr/bin/python3 /usr/bin/python

# Setup Test Framework
RUN apt-get install -qq curl
RUN apt-get install -qq wget


## update gfortran

WORKDIR /install
RUN curl -o gcc-8.3.0.tar.xz http://gfortran.meteodat.ch/download/x86_64/releases/gcc-8.3.0.tar.xz
RUN tar xf gcc-8.3.0.tar.xz && \
cd gcc-8.3.0 && \
ln -s /install/gcc-8.3.0/bin/gfortran /usr/bin/gfortran8

# ## install cmake
RUN apt-get install -qq wget && wget https://github.com/Kitware/CMake/releases/download/v3.16.5/cmake-3.16.5-Linux-x86_64.sh
# TODO: Finish getting and installing cmake
RUN chmod +x cmake-3.16.5-Linux-x86_64.sh && \
./cmake-3.16.5-Linux-x86_64.sh --skip-license --include-subdir && \
ln -s /install/cmake-3.16.5-Linux-x86_64/bin/cmake /usr/local/bin/cmake


RUN apt-get install -qq m4

# # Copy vendor directory
# TODO: This should pull from repository
COPY ./vendor /vendor
WORKDIR /vendor


# Build fPUnit
# TODO: Skip -DSKIP_FHAMCREST=YES due to `Exception: SegFault` in tests
RUN cd pFUnit && mkdir build && cd build && cmake .. -DCMAKE_INSTALL_PREFIX=/vendor
# TODO: remove || true when fixed hamcrest tests
RUN cd pFUnit && cd build && make tests || true
RUN cd pFUnit && cd build && make install
# TODO: Fix line endings
# file .../PFUNIT-4.1/bin/funitproc has incorrect line endings
ENV PFUNIT_DIR=/vendor
ENV PFUNIT=/vendor/PFUNIT-4.1/

RUN sed -i.bak 's/\r$//' "${PFUNIT}bin/funitproc"

WORKDIR /app


# RUN TESTS

CMD /app/build_and_run.sh


