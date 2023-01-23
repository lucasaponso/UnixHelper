import speech_recognition as sr
import sys
import os
import time
import mysql.connector
from pydub import AudioSegment

def db_connection():
    int_var = input("Enter int:")
    string_var = input("Enter String:")
    mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    ##ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';
    password="root",
    database="records")
    mycursor = mydb.cursor()
    sql = "INSERT INTO record_table (id, name) VALUES (%s, %s)"
    val = (""+int_var+"", ""+string_var+"")
    mycursor.execute(sql, val)
    mydb.commit()
    print(mycursor.rowcount, "record inserted.")
db_connection()



for x in range(10000):
    
        duration = 10
        r = sr.Recognizer()
        print("Please talk")
        with sr.Microphone() as source:


            os.system("echo 'What do you want completed?' | festival --tts")

            age = 120

            if age > 90:
            print("You are too old to party, granny.")
elif age < 0:
    print("You're yet to be born")
elif age >= 18:
    print("You are allowed to party")
else: 
    "You're too young to party"

# Output: You are too old to party, granny.

    
            ##audio_data = r.record(source, duration=duration)
            ##print("Recognizing...")
            ##text = r.recognize_google(audio_data)
                            
            os.system("echo 'Enter First Octet' | festival --tts")
            time.sleep(4)
            audio_octet1 = r.record(source, duration=duration)
            string_octet1 = r.recognize_google(audio_octet1)
           



            os.system("echo 'Enter Second Octet' | festival --tts") 
            time.sleep(4)
            os.system("beep -f 2000 -l 1500")
            audio_octet2 = r.record(source, duration=duration)
            string_octet2 = r.recognize_google(audio_octet2)
            
            

            os.system("echo 'Enter Third Octet' | festival --tts")
            time.sleep(4)
            audio_octet3 = r.record(source, duration=duration)
            string_octet3 = r.recognize_google(audio_octet3)
            
            

            os.system("echo 'Enter Fourth Octet' | festival --tts")
            time.sleep(4)
            audio_octet4 = r.record(source, duration=duration)
            string_octet4 = r.recognize_google(audio_octet4)

            array_ip_addr = [''+ string_octet1 +'', ''+ string_octet2 +'', ''+ string_octet3 +'', ''+ string_octet4 +'']
            ip_addr = '.'.join(array_ip_addr)
            print(ip_addr)


            os.system("echo 'pinging "+ip_addr+"' | festival --tts")
            os.system("./ping_check.sh '"+ip_addr+"'")
            os.system("ping -c 4 '"+ip_addr+"'")