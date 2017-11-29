#!bin/sh

# Берёт название shell скрипта для дальнейшего использования
ME=`basename $0`

## Объявление функций

# Функция Help
help() {
    echo 
    echo "Использование: sh $ME [КЛЮЧ]... ИСТОЧНИК НАЗНАЧЕНИЕ"
    echo "      или      sh $ME [КЛЮЧ]... ИСТОЧНИК"
    echo
    echo "Аргументы, обязательные для длинных ключей, обязательны и для коротких."
    echo "  -c           Копирование файла"
    echo "  -r           Изменение имени."
    echo "  -m           Перемещение файла."
    echo "  -d           Удаление файла"
    echo "  --help       Справка."
    echo
}

# Функция для копирования файлов
copy_file(){
    # Проверка на существование файла
    if [ -e $1 ]
    then
        # проверка на существования каталога
        if [ -d $2 ]
        then
            echo "Копирование прошло успешно"
            cp $1 $2
        else
            echo "Путь $2 не существует!"
        fi
    else 
        echo "Файла $1 не существует!"
        break
    fi
}

# Функция для переименовывания файлов
rename_file() {
    # Проверка на существование файла
    if [ -e $1 ]
    then
        mv $1 $2
        echo "Успешно переименовано в $2"
    else
        echo "Файла $1 не существует!"
    fi
}

# Функция для удаления файла
delete_file() {
    # Проверка на существование файла
    if [ -e $1 ]
    then
        rm $1
        echo "Файл ${1} успешно удален"
    else 
        echo "Файла $1 не существует!"
    fi 
}

# Функция для перемещения файлов
move_file(){
    # Проверка на существование файла
    if [ -e $1 ]
    then
        if [ -d $2 ] 
        then
            mv $1 $2
            echo "Успешно перемещенно в $2"
        fi  
    else
        echo "Файла $1 не существует!"
    fi
}

## Работа с ключами

# Если скрипт запущен без аргументов, открываем справку.
if [ $# = 0 ]; then
    echo "                       Вы не указали ключи!"
    echo "        Воспользуйтесь --help для получения справки. "
else
# Проверка на ключ --help
    if [ $# = "--help" ]
    then
        help
    else
# getopts используется для поиска ключей в вводимой строке
        while getopts ":c:r:m:d:" Option ;
        do
            case $Option in
                c) copy_file $2 $3;;
                r) rename_file $2 $3;;
                m) move_file $2 $3;;
                d) delete_file $2;;
                *) help;;
            esac
            # Перейти к следующей опции
            shift
        done
    fi
fi