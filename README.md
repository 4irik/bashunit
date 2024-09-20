# Хелпер для тестирования bash-скриптов

![Пример работы скрипта тестирования bash-скриптов](demo.gif)

Что бы тесты запускались нужно:

1. файлы с тестами имеют префикс `test_` и расширение `sh`
1. если в тесте нужно вернуть ошибку необходимо вызвать `echo` с сообщением и затем `exit 1` (рекомендуется использовать функцию `assert` из файла `utils.sh`, файл в тестовые файлы подключать не нужно)

## Пример:

```shell
$ tree ./
./
├── test
│   ├── test_assert_1.sh
│   └── test_assert_2.sh
├── test.sh
└── utils.sh
1 directory, 4 files
$ cat test/test_assert_1.sh
assert "abc" "abb" "первая строка не соответсвует ожиданию, должно быть \"abc\""
assert 3 3 "3 не равно 3"
$ cat test/test_assert_2.sh
assert 2 2 "2 не равно 2"
assert 3 3 "3 не равно 3"
```

Запускаем тесты:

```shell
$ ./test.sh
./test/test_assert_1.sh: FAIL
./test/test_assert_2.sh: success

ERRORS:
./test/test_assert_1.sh:
первая строка не соответсвует ожиданию, должно быть "abc":
1c1
< abc
---
> abb

RESULT:
total tests run: 2
successfully: 1
failure: 1
```
## TODO

- [ ] показ номера строки в тестовом файле на которой произошла ошибка
- [ ] флаг --dry-run
- [ ] флаг --fast-fail
- [ ] функции определяющие неравенство (greaterThen, lessThen, ..)
- [ ] dataProvider (?!)
- [ ] моки/стабы (?!)
- [ ] setup/teardown для файла/для всего тестового набора
- [ ] параллельное выполнение тестов (?!)
