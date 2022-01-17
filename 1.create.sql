DROP DATABASE IF EXISTS mydb;
CREATE DATABASE mydb CHARSET=utf8mb3;
USE mydb;
DROP TABLE IF EXISTS my_text;
CREATE TABLE my_text (
   id int primary key auto_increment,
   my_value text
) CHARSET=utf8mb3 ROW_FORMAT=COMPACT;
