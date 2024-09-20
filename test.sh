#!/usr/bin/env bash

TEST_FILE_FILTER=$@

CURR_DIR=$(pwd)

COLOR_FAIL='\033[0;31m' # Red
COLOR_SUCCESS='\033[0;32m' # Green
COLOR_NC='\033[0m' # No Color

SUCCESS_COUNTER=0
FAIL_COUNTER=0
TEST_FILE_COUNTER=0

declare -A FAIL_OUTPUT
for i in $(find . -type f -name "test_*.sh");
do
	if [ "$TEST_FILE_FILTER" != "" ]; then 
		IS_ACCEPT=0
		for filter in $TEST_FILE_FILTER; do
			if [[ "$i" =~ $filter ]]; then
				IS_ACCEPT=1
				break
			fi
		done

		if [ "$IS_ACCEPT" -eq 0 ]; then
			continue
		fi
	fi

	TEST_FILE_COUNTER=$(( TEST_FILE_COUNTER + 1 ))

	scrip_dir=$(dirname $i)
	script_file=$(basename $i)
	# bash script.sh < input.txt > output.txt 2> error.log
	out=$(cd $scrip_dir && bash --noprofile --norc -c "source $CURR_DIR/utils.sh; source ./$script_file")
	result=$?


	if [ $result -ne 0 ]; then
		FAIL_OUTPUT[$i]=$out
		FAIL_COUNTER=$(( FAIL_COUNTER + 1 ))
        	echo -e "$i: ${COLOR_FAIL}FAIL${COLOR_NC}"
	else

		SUCCESS_COUNTER=$(( SUCCESS_COUNTER + 1 ))
        	echo -e "$i: ${COLOR_SUCCESS}success${COLOR_NC}"
    	fi
done

if [ ${#FAIL_OUTPUT[@]} -gt 0 ]; then
	echo
	echo "ERRORS:"
	for i in "${!FAIL_OUTPUT[@]}"; do
		echo -e "${i}:\n${FAIL_OUTPUT[$i]}" | sed -z 's/\n/\\n/g' 
		echo
	done | tac | sed 's/\\n/\n/g'
fi

echo "RESULT:"
echo "total tests run: $TEST_FILE_COUNTER"
echo "successfully: $SUCCESS_COUNTER"
echo "failure: $FAIL_COUNTER"

