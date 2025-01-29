# HDFS Data Cleanup Exercise

## Подготовка тестовых данных

1. Создаем структуру директорий:
```bash
# Создаем основные директории
hdfs dfs -mkdir -p /data/raw
hdfs dfs -mkdir -p /data/processed
hdfs dfs -mkdir -p /data/temp
hdfs dfs -mkdir -p /data/archive

# Устанавливаем права
hdfs dfs -chmod 777 /data/raw
hdfs dfs -chmod 777 /data/processed
hdfs dfs -chmod 777 /data/temp
hdfs dfs -chmod 777 /data/archive
```

2. Генерируем тестовые файлы:
```bash
# Создаем временные файлы локально
dd if=/dev/urandom of=data1.csv bs=1M count=10
dd if=/dev/urandom of=data2.csv bs=1M count=15
dd if=/dev/urandom of=temp_file1.tmp bs=1M count=5
dd if=/dev/urandom of=temp_file2.tmp bs=1M count=7

# Загружаем файлы в HDFS
hdfs dfs -put data*.csv /data/raw/
hdfs dfs -put temp_file*.tmp /data/temp/

# Создаем старые файлы
hdfs dfs -touchz /data/raw/old_data_2023.csv
hdfs dfs -touchz /data/processed/archived_2023.csv
```

## Задания

### 1. Поиск старых файлов

```bash
# Просмотр всех файлов с датами модификации
hdfs dfs -ls -R /data

# Поиск файлов с датой в названии
hdfs dfs -ls -R /data | grep "2023"

# Создание списка старых файлов
hdfs dfs -ls -R /data | grep "2023" | tee old_files.txt
```

### 2. Очистка временных файлов

```bash
# Поиск всех временных файлов
hdfs dfs -find /data -name "*.tmp"

# Просмотр размера временных файлов
hdfs dfs -du -h /data/temp

# Перемещение временных файлов в архив
hdfs dfs -mv /data/temp/*.tmp /data/archive/

# Удаление временных файлов (если они не нужны)
hdfs dfs -rm -skipTrash /data/temp/*.tmp
```

### 3. Работа с корзиной

```bash
# Просмотр содержимого корзины
hdfs dfs -ls /user/$USER/.Trash/Current

# Очистка корзины
hdfs dfs -expunge

# Удаление файла с сохранением в корзину
hdfs dfs -rm /data/raw/data1.csv

# Восстановление файла из корзины
hdfs dfs -cp /user/$USER/.Trash/Current/data/raw/data1.csv /data/raw/
```

### 4. Восстановление удаленных файлов

```bash
# "Случайное" удаление файла
hdfs dfs -rm /data/raw/data2.csv

# Поиск файла в корзине
hdfs dfs -find /user/$USER/.Trash -name "data2.csv"

# Восстановление файла
hdfs dfs -cp /user/$USER/.Trash/Current/data/raw/data2.csv /data/raw/
```

### 5. Дополнительные задания

```bash
# Проверка целостности файловой системы
hdfs fsck /data

# Проверка использования дискового пространства
hdfs dfs -du -h /data
hdfs dfs -count -h /data

# Создание отчета о занятом месте
hdfs dfs -du -h /data | sort -k1 -hr > space_usage_report.txt
```

## Проверка результатов

После выполнения всех заданий проверяем:

1. Все ли временные файлы обработаны
```bash
hdfs dfs -find /data -name "*.tmp" | wc -l
# Должно быть 0
```

2. Размер освобожденного места
```bash
hdfs dfs -du -s -h /data
```

3. Статус корзины
```bash
hdfs dfs -ls /user/$USER/.Trash/Current
```

## Бонусные задания

1. Написать скрипт для автоматической очистки старых файлов:
```bash
#!/bin/bash
# cleanup_script.sh

# Найти все файлы старше 30 дней
old_files=$(hdfs dfs -find /data -mtime +30)

# Переместить их в архив
for file in $old_files; do
  hdfs dfs -mv $file /data/archive/
done
```

2. Настроить квоты для директорий:
```bash
# Установка квоты на количество файлов
hdfs dfsadmin -setQuota 1000 /data/raw

# Установка квоты на размер директории (10GB)
hdfs dfsadmin -setSpaceQuota 10g /data/raw
```

## Критерии успешного выполнения

- [ ] Все временные файлы перемещены или удалены
- [ ] Старые файлы идентифицированы и обработаны
- [ ] Корзина очищена
- [ ] Успешно восстановлен "случайно" удаленный файл
- [ ] Создан отчет об использовании пространства
- [ ] Все операции выполнены без ошибок