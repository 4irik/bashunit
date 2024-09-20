##
# Сравнивает первые два параметра, если они отличаются, выводит третий параметр (он может быть не задан)
# и diff первых двух, затем завершает выполнение скрипта с кодом 1
##
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

