#!/bin/bash

cd src && \
make clean && \
# make all ./test_simple && \
make all && \
# echo "fin"
./run || true &&\
make clean