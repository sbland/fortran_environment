# fortran_environment
A base setup for a fortran environment with compiler, testing etc


# Info
## WAF Build Tool
The Fortran code is built using the Waf\_ build tool. This requires
Python 2.5 or newer (including 3.x) to be available. If any errors with
waf check if update needed (See troubleshooting at bottom). 

# Environment Setup
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
