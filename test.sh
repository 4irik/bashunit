#!/usr/bin/env sh

COLOR_FAIL='\033[0;31m'
COLOR_SUCCESS='\033[0;32m'
COLOR_NC='\033[0m' # No Color

SUCCESS_COUNTER=0
FAIL_COUNTER=0
TEST_FILE_COUNTER=0

for i in $(find . -type f -name "test_*.sh");
do
	TEST_FILE_COUNTER=$(( TEST_FILE_COUNTER + 1 ))

	scrip_dir=$(dirname $i)
	script_file=$(basename $i)
	out=$(cd $scrip_dir && sh ./$script_file)

	if [ $? -ne 0 ];
    then
		FAIL_COUNTER=$(( FAIL_COUNTER + 1 ))
        echo "$i: ${COLOR_FAIL}FAIL${COLOR_NC}"
    else
		SUCCESS_COUNTER=$(( SUCCESS_COUNTER + 1 ))
        echo "$i: ${COLOR_SUCCESS}success${COLOR_NC}"
    fi
done

echo
echo "RESULT:"
echo "total tests run: $TEST_FILE_COUNTER"
echo "successfully: $SUCCESS_COUNTER"
echo "failure: $FAIL_COUNTER"