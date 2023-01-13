# Проект 2-го спринта
## Работа по DWH и пересмотру модели данных

### Описание
В данном проекте реалтзованна миграция данных из одной таблицы в отдельные логические таблицы.
Создано представление `shipping_datamart` на основании готовых таблиц для аналитики. 
### ERD схема исходной таблицы
![Image alt](https://github.com/kuolematon/de-project-sprint-2/blob/main/image/shipping.png)
### ERD схема логических таблиц и их связей
![Image alt](https://github.com/kuolematon/de-project-sprint-2/blob/main/image/tables.png)
### ERD схема витрины
![Image alt](https://github.com/kuolematon/de-project-sprint-2/blob/main/image/shipping_datamart.png)

### Структура репозитория
Папка `migrations` хранит файлы миграции. 
Файлы миграции должны быть с расширением `.sql` и содержать SQL-скрипт обновления базы данных.

### Как запустить контейнер
Запустите локально команду:

```
docker run -d --rm -p 3000:3000 -p 15432:5432 --name=de-project-sprint-2-server sindb/project-sprint-2:latest
```

После того как запустится контейнер, у вас будут доступны:
1. CloudBeaver
2. PostgreSQL
3. VSCode

### TO DO
- Срипт отката
