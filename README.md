**fortran_environment**
-----------------------

A base setup for a fortran environment with compiler, testing etc


# Info
## WAF Build Tool
The Fortran code is built using the Waf\_ build tool. This requires
Python 2.5 or newer (including 3.x) to be available. If any errors with
waf check if update needed (See troubleshooting at bottom). 

# Environment Setup (DOCKER)
You will need docker in order to create a virtual environment to run the fortran model

## Windows 
https://docs.docker.com/docker-for-windows/


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

### Test run
1. With the environment activated run `python waf configure` followed by `python waf build`
2. You should now have a run_model.exe file in the build folder. Run this in bash/cmd and you should see `hello world` as a response 
