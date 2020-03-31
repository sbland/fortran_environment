#!/bin/bash
ROOT_DIR=$PWD

cd src && \
make clean && \
make all TEST_MODE=1 ROOT_DIR=$ROOT_DIR && \
echo "----------------------- RUNNING TESTS -----------------------------"

TESTS=$(find . -regex '.*_tests')



echo $TESTS
touch ./results.txt
echo "===========TEST RUN==========" > ./results.txt
# (
for TEST in $TESTS; do
    basename "$TEST"
    TESTNAME="$(basename -- $TEST)"
    echo "TEST: $TEST"
    echo "TESTNAME: $TESTNAME"
    RESULT_FILE="./${TESTNAME}_result.txt"
    touch $RESULT_FILE
    echo $RESULT_FILE
    printf "file" > $RESULT_FILE
    # Run Tests
#
    if [ "${TEST_FILTER}" = "" ]; then
        echo $($TEST -o $RESULT_FILE)
    else
        echo "run with test_filter"
        echo $($TEST -o $RESULT_FILE -f $TEST_FILTER)
    fi

    echo "==================$TESTNAME================" >> ./results.txt
    cat $RESULT_FILE >> ./results.txt
    echo \n
    rm $RESULT_FILE
done
# )

if [ "${DONT_CLEAN_UP}" = "TRUE" ]; then
    echo "Skipping clean up"
else
    make clean
fi
echo "====================== RESULTS ======================="
cat ./results.txt



echo "end"