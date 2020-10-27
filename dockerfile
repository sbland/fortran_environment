# FORTAN BUILD ENVIRONMENT
# A environment that builds the model then running the docker container will run the model

# to BUILD => `docker build . -t fortran_environment`
# to RUN =>  `docker run -it -v <local path to project>:/app fortran_environment`


FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive
# Setup dependencis

RUN apt-get update && apt-get install -qq \
    # The fortran package
    gfortran \
    # Fortran debugger
    gdb \
    # Make
    make

CMD make


