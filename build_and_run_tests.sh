#!/bin/bash

cd src && \
make clean && \
# make all ./test_simple && \
make all TEST_MODE=1 && \
# echo "fin"
./modules/tests/test_simple > ./test_output.txt || true &&\
make clean