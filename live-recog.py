import speech_recognition as sr
import sys
import os
import time
import mysql.connector
from datetime import date
from pydub import AudioSegment
os.system("sudo inc/log.sh run")
##ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';

def db_connection(ip_addr):
    mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password="root",
    database="unixhelper")


    mycursor = mydb.cursor()

    var2 = "goodbye321"

    sql = "INSERT INTO address (ip, mail) VALUES (%s, %s)"
    val = (""+ip_addr+"", ""+var2+"")


    mycursor.execute(sql, val)
    mydb.commit()
    print(mycursor.rowcount, "record inserted.")
    os.system("sudo inc/log.sh run")
    os.system("sudo cat /mnt/server/db_access_log.txt")


    
duration = 5
r = sr.Recognizer()
print("Please talk")
with sr.Microphone() as source:
             os.system("echo 'Enter First Octet' | festival --tts")
             audio_octet1 = r.record(source, duration=duration)
             string_octet1 = r.recognize_google(audio_octet1)
             print(string_octet1)

             os.system("echo 'Enter Second Octet' | festival --tts")
             audio_octet2 = r.record(source, duration=duration)
             string_octet2 = r.recognize_google(audio_octet2)
             print(string_octet2)

             os.system("echo 'Enter Third Octet' | festival --tts")
             audio_octet3 = r.record(source, duration=duration)
             string_octet3 = r.recognize_google(audio_octet3)
             print(string_octet3)

             os.system("echo 'Enter Fourth Octet' | festival --tts")
             audio_octet4 = r.record(source, duration=duration)
             string_octet4 = r.recognize_google(audio_octet4)
             print(string_octet4)

             
             array_ip_addr = [''+ string_octet1 +'', ''+ string_octet2 +'', ''+ string_octet3 +'', ''+ string_octet4 +'']
             ip_addr = '.'.join(array_ip_addr)
             print(ip_addr)
             db_connection(ip_addr)
             


os.system("inc/ping.sh '"+ip_addr+"'")

    