# Enter the server name in host
# followed by your user and
# password along with the database
# name provided by you.

import mysql.connector


mydb = mysql.connector.connect(
host = "localhost",
user = "username",
password = "password",
database = "database_name"
)

mycursor = mydb.cursor()
