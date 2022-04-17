CREATE TABLE IF NOT EXISTS account  (
id SERIAL PRIMARY KEY,
username VARCHAR NOT NULL,
email VARCHAR NOT NULL UNIQUE,
phone VARCHAR NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS ticket (
id SERIAL PRIMARY KEY,
session_id INT NOT NULL,
line INT NOT NULL,
col INT NOT NULL,
account_id INT NOT NULL REFERENCES account(id),
UNIQUE (session_id, line, col)
);

--DROP TABLE IF EXISTS ticket CASCADE;

/*
Примечания по теме
Пробуем добавить CONSTRAINT прямо в процессе создания таблицы
Ограничения нужно добавить на три колонки
session_id, row, cell (сеанс, ряд и место).
В JDBC нужно добавить обработку ConstrainsViolationException.
Возможные решения
CONSTRAINT unique_ticket UNIQUE (session_id, row, cell)
UNIQUE(session_id, row, col), но мне кажется оно неправильное

----
Вроде как получается, что ROW - это зарезервированное имя для H2
Поменял ROW на LINE

----

Общие пояснения
Оператор CONSTRAINT. Установка имени ограничений.
CREATE TABLE Customers (
...
Email CHARACTER VARYING(30),
CONSTRAINT customers_email_key UNIQUE(Email),
)
 */