CREATE DATABASE matilda;
USE matilda;

CREATE TABLE Users
(
first_name varchar(255),
last_name varchar(255),
username varchar(255),
ipaddr varchar(255),
passwd varchar(255)
);

CREATE TABLE Messages
(
date varchar(255),
user varchar(255),
payload varchar(255),
no_char varchar(255)
);