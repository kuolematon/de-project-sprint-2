# Проект 2-го спринта
## Работа по DWH и пересмотру модели данных

### Описание
В данном проекте реалтзованна миграция данных из одной таблицы в отдельные логические таблицы.
### ERD схема исходной таблицы
![Image alt](https://github.com/kuolematon/de-project-sprint-2/blob/main/image/shipping.png)
### ERD схема логических таблиц и их связей
![Image alt](https://github.com/kuolematon/de-project-sprint-2/blob/main/image/tables.png)
### ERD схема витрины
![Image alt](https://github.com/kuolematon/de-project-sprint-2/blob/main/image/shipping_datamart.png)
### Как работать с репозиторием
1. В вашем GitHub-аккаунте автоматически создастся репозиторий `de-project-sprint-2` после того, как вы привяжете свой GitHub-аккаунт на Платформе.
2. Скопируйте репозиторий на свой локальный компьютер, в качестве пароля укажите ваш `Access Token` (получить нужно на странице [Personal Access Tokens](https://github.com/settings/tokens)):
	* `git clone https://github.com/{{ username }}/de-project-sprint-2.git`
3. Перейдите в директорию с проектом: 
	* `cd de-project-sprint-2`
4. Выполните проект и сохраните получившийся код в локальном репозитории:
	* `git add .`
	* `git commit -m 'my best commit'`
5. Обновите репозиторий в вашем GutHub-аккаунте:
	* `git push origin main`

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
