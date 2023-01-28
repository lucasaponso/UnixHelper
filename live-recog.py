import speech_recognition as sr
import sys
import os
import time
import mysql.connector
from datetime import date
from pydub import AudioSegment

def db_connection():
    string_var="helloworld"
    int_var=2
    mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    ##ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';
    password="root",
    database="records")
    mycursor = mydb.cursor()
    sql = "INSERT INTO records (name, id) VALUES (%s, %s)"
    val = (""+string_var+"",""+int_var+"")
    mycursor.execute(sql, val)
    mydb.commit()
    print(mycursor.rowcount, "record inserted.")
db_connection()
##for x in range(10000):
    
##        duration = 10
##        r = sr.Recognizer()
##        print("Please talk")
        # with sr.Microphone() as source:

    
        #     os.system("echo 'Enter First Octet' | festival --tts")
        #     audio_octet1 = r.record(source, duration=duration)
        #     string_octet1 = r.recognize_google(audio_octet1)
        #     print(string_octet1)



        #     array_ip_addr = [''+ string_octet1 +'', ''+ string_octet2 +'', ''+ string_octet3 +'', ''+ string_octet4 +'']
        #     ip_addr = '.'.join(array_ip_addr)
        #     print(ip_addr)



