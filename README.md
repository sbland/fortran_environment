**fortran_environment**
-----------------------

**VERSION 0.1.0**

A base setup for a fortran environment with compiler, testing etc

**NOTE**: This is a WIP and contributions are welcome

# Info
## Licences for externals
pFUnit Licence - https://github.com/Goddard-Fortran-Ecosystem/pFUnit/blob/master/LICENSE


# Environment Setup (DOCKER) - Min
This creates a minimal environment for running fortran

## Dependencies
You will need docker in order to create a virtual environment to run the fortran model. See the docker dependencies section below

For testing you will need pfUnit and its submodules `cd vendor/` && `git clone https://github.com/Goddard-Fortran-Ecosystem/pFUnit.git --recursive`


## Build and Run

### Build

Replace 'fortran_environment' with the name of your model
```
docker build . -t fortran_environment
```

### Run
Note can add args like 'abc' in example below
```
docker run -it fortran_environment ./build/run_model abc
```
# Environment Setup (DOCKER) - Full
This creates a full environment for running fortran with testing etc

## Dependencies
You will need docker in order to create a virtual environment to run the fortran model. See the docker dependencies section below
You also need clone pfUnit and its submodules `cd vendor/` && `git clone https://github.com/Goddard-Fortran-Ecosystem/pFUnit.git --recursive`

### Build

Replace 'fortran_environment' with the name of your model
```
docker build . -t fortran_environment
```

### Run model

```
docker run -it -v <local path to project>:/app fortran_environment
```

### Run tests

```
docker run -it -v <local path to project>:/app fortran_environment ./build_and_run_tests.sh
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



# Adding modules
1. To create a new module add a folder to `src/modules`
2. Inside the folder create your .F90 files and a `Makefile`. See the example src folder for an example of a makefile
3. At the top of the Makefile you should add a list of all the .F90 files required for the module including dependencies first
4. You should then add a line to the `build` path inside of `/src/modules/Makefile` like  `$(MAKE) -C <module_name> all`. and in the `clean` path add `$(MAKE) -C <module_name> clean`
5. Note: the order of these is important

# Adding tests
Tests are created using the pFUnit test framework. The below is a simple example. Read the pFUnit docs for further info.
## Adding a test to your module
1. Inside your module directory create a new file called `<module_name>_test.pf` see examples or pFUnit documentation on how this should be setup
2. Add to the makefile `include $(LATEST_PFUNIT_DIR)/include/PFUNIT.mk`
3. Inside your module makefile you should include `FFLAGS += $(PFUNIT_EXTRA_FFLAGS)`
4. You should also add any other module dependencies here like this: `FFLAGS += -I../constants` where `...constants` is the relative path from this makefile to another module directory
5. Add your tests `<module_name>_TESTS := testa_test.pf testb_test.pf ` where `testa_test.pf` and `testb_test.pf` are the names of your tests
6. Add the following `<module_name>_OTHER_LIBRARIES := -L../constants -L../config -lsut` where `-L../constants` are the relative paths to other modules
7. Finally add `$(eval $(call make_pfunit_test,<module_name>_tests))`
8. Inside of `/src/modules/Makefile` add your module to the testing path as so: `$(MAKE) -C <module_name> tests`

Complete makefile:
``` bash
SRCS := \
	../constants/Constants_ml.F90 \
	model_ml.F90

OBJS := $(SRCS:%.F90=%.o)

all: libsut.a


# Add any compile flags?
FFLAGS += $(PFUNIT_EXTRA_FFLAGS)
FFLAGS += -I../constants

# Setup/compile library?
libsut.a: $(OBJS)
	$(AR) -r $@ $?


# Tells make to Compile using FC compiler
%.o : %.F90
	$(FC) -c $(FFLAGS) $<

# ==== ======================================================DEFINE TESTS ==== #
# Define Tests and their dependencies
tests: <module_name>
# Get pFUnit
include $(LATEST_PFUNIT_DIR)/include/PFUNIT.mk

# **run_tests**
<module_name>_tests_TESTS := testa_test.pf testb_test.pf
<module_name>_tests_OTHER_LIBRARIES := -L../constants -L../config -lsut

$(eval $(call make_pfunit_test,<module_name>_tests))


# ==== CLEAN UP ==== #
clean:
	$(RM) *.o *.mod *.a *.inc *_tests *_test.F90

```

# Docker dependencies

### Windows
https://docs.docker.com/docker-for-windows/

### Windows (Home edition)
Note: May require enabling virtualization in the bios.
https://docs.docker.com/toolbox/toolbox_install_windows/

### Ubuntu
https://docs.docker.com/install/linux/docker-ce/ubuntu/


# Troubleshooting
- `/bin/sh: 1: /app/build_and_run_tests.sh: not found`
  - check that you have mapped the current directory correctly to the volume e.g. `docker run ... -v /c:/projects/fortran_environment:/app ...`.
  - Also make sure that you have enabled file sharing of your local drive in the docker settings on windows
  - Make sure the line endings are set to LF not CLRF for `build_and_run_tests.sh`