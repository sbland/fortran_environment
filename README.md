**fortran_environment**
-----------------------

**VERSION 0.1.0**

A base setup for a fortran environment with compiler, testing etc

**NOTE**: This is a WIP and contributions are welcome

# Info
## Licences for externals
pFUnit Licence - https://github.com/Goddard-Fortran-Ecosystem/pFUnit/blob/master/LICENSE

## WAF Build Tool
The Fortran code is built using the Waf\_ build tool. This requires
Python 2.5 or newer (including 3.x) to be available. If any errors with
waf check if update needed (See troubleshooting at bottom).

# Environment Setup (DOCKER)
You will need docker in order to create a virtual environment to run the fortran model
You also need clone pfUnit and its submodules `cd vendor/` && `git clone https://github.com/Goddard-Fortran-Ecosystem/pFUnit.git --recursive`

## Windows
https://docs.docker.com/docker-for-windows/

## Windows (Home edition)
Note: May require enabling virtualization in the bios.
https://docs.docker.com/toolbox/toolbox_install_windows/

## Ubuntu
https://docs.docker.com/install/linux/docker-ce/ubuntu/

# Build and Run

## Build

Replace 'fortran_environment' with the name of your model
```
docker build . -t fortran_environment
```

## Run
Note can add args like 'abc' in example below
```
docker run -it fortran_environment ./build/run_model abc
```

# Environment Setup (MANUAL)
This is the instructions for running without docker on windows

### Dependencies
- **MinGW** - http://www.mingw.org/wiki/Getting_Started
  - Needs specific compilers?
  - assuming your directory for MinGW is the default "C:\MinGW", setup your PATH environment variable to include "C:\MinGW\bin"  && "C:\MinGW\msys\1.0\bin"
  - Check this is working by opening cmd or powershell and typing "make -h". This should give you some options for the make command
- **Git For windows** - https://git-scm.com/download/win
  - This provides access to git bash
- **Python 2.7** - https://www.python.org/downloads/release/python-2717/
  - Add python to your environment variables "C:/Python27". Make sure to rename python.exe to python2.exe
  - Add pip to your environment variables "C:/Python27/Scripts"
- **Python Virtual Env** - Install python2 virtual env `python2 -m pip install --user virtualenv`

Note: Ensure you reopen command panels after editing PATH Vars

### Setup
1. From `git bash` Create the python virtual environment `python2 -m virtualenv venv` and activate `. ./venv/scripts/activate`. When Activated you should now have `(venv)` at the start of the current path in the command line

### Demo run
1. With the environment activated run `python waf configure` followed by `python waf build`
2. You should now have a run_model.exe file in the build folder. Run this in bash/cmd and you should see `hello world` as a response

# Testing
Testing is setup with pFUnit https://github.com/Goddard-Fortran-Ecosystem/pFUnit


To run tests with docker:
1. Setup the src directory with your tests as in pFUnit documentation. The current setup uses a modification of the Trivial example here: https://github.com/Goddard-Fortran-Ecosystem/pFUnit_demos/tree/master/Trivial
2. Build the container `docker build . -f dockerfile-testspf -t fortran_environment_testspf`
3. Run the container `docker run -it fortran_environment_testspf bash`
4. From inside the container run the tests `cd src && make all ./my_tests && ./my_tests`

# Using local/portable docker version
This setup allows you to pre built the docker container then run it on any project folder

1. Setup the src directory with your tests as in pFUnit documentation. The current setup uses a modification of the Trivial example here: https://github.com/Goddard-Fortran-Ecosystem/pFUnit_demos/tree/master/Trivial
2. Build the container (Only needs running once) `docker build . -f dockerfile-testspf-local -t fortran_environment_test_local`
3. Run the container `docker run -it -v <full path to your project root>:/app fortran_environment_test_local`


# Troubleshooting
- `/bin/sh: 1: /app/build_and_run_tests.sh: not found`
  - check that you have mapped the current directory correctly to the volume e.g. `docker run ... -v /c:/projects/fortran_environment:/app ...`.
  - Also make sure that you have enabled file sharing of your local drive in the docker settings on windows