#!/bin/bash

cd src && \
make clean && \
make all ./test_simple && \
./test_simple || true &&\
make clean 