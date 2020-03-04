# FORTAN BUILD ENVIRONMENT
# A environment that builds the model then running the docker container will run the model


FROM ubuntu

# Setup dependencis
RUN apt-get update
RUN apt-get install -qq \
    build-essential \
    pkg-config \
    gfortran \
    liblapack-dev
# Add python
RUN apt-get install -qq software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update
RUN apt-get install -qq python2.7
RUN apt-get install -qq python3.7
RUN ln -s /usr/bin/python3 /usr/bin/python

COPY . /env
WORKDIR /env
RUN ./waf configure
RUN ./waf build


CMD ./build/run_model