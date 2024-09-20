assert() {
    message=${3:-""}

    local diff_value
    set -o pipefail
    diff_value=$(diff  <(echo "$1" ) <(echo "$2") | sed -z 's/\n/\\n/g')

    if [ $? -ne 0 ];
    then
        echo -e "$message:\n$diff_value"
        exit 1
    fi
}
