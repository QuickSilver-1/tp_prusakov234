#!/bin/bash

#Проверяем все поддиректории входной директории на наличие доступа пользователя к ним, иначе выводим предупреждение
find "$1" -type d 2>/dev/null | while read d;
do

	if [[ ! -r $d ]];
	then
		echo "Нет доступа к директории $d. Используйте sudo"
	fi

done

#Проходимся по всем файлам из входной директории
find "$1" -type f -o -type l 2>/dev/null | grep -v "Permission denied" | while read f;
do

	count=1
        #Достаем из полного пути имя файла f
	copy=$(basename $f)
	original=$(basename $f)
	point="."
	index=$(expr index ${original:1} $point)

	#Проверяем доступ к файла, иначе выводим предупреждение
	if [[ -r $f ]];
	then

        	#Если файл с таким именем уже существует, то добавляем к концу имени count, пока не получим уникальное имя
		while [[ -f $2/$copy ]];
		do

			count=$(($count + 1))
			copy=${original:0:$(($index - 1))}$count.${original:$(($index + 1))}

		done

        	#Создаем путь до скопированного файла, используя выходную директорию и новое имя файла
		copy=$2/$copy
		#Копируем файл в новую директорию
		cp -d $f $copy

	else
		echo "Нет доступа к файлу к $f. Используйте sudo"

	fi
done

echo "Копирование файлов завершено"
