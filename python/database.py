import firebase_admin # IF NOT DEFINED --IN TERMINAL--> pip3 install firebase-admin

from firebase_admin import credentials
from firebase_admin import db
import serial
import time
import json

historial = {
            "temperatura": [],
            "time": []
        }

#MAIN
if __name__ == "__main__":
    def main():

        #CONFIG DE CONEXION CON BD FIREBASE
        # path = 'python/sb-129-proj-f1b72e0e0f19.json'
        path = "C:/Users/emili/Documents/Code/SB-129/SB-129/python/sb-129-proj-f1b72e0e0f19.json"
        databaseURL = "https://sb-129-proj-default-rtdb.firebaseio.com/"

        #ARDUINO CONNECTION
        json_path = 'C:/Users/emili/Documents/Code/SB-129/SB-129/python/data.json'
        port  = 'COM3'
        data  = ''
        count = 0
        delay = 5
        ctd   = 3

        cred = credentials.Certificate(path)
        firebase_admin.initialize_app(cred, {'databaseURL': databaseURL})
        ref = db.reference("/")
                
        #ABRIR PUERTO 
        arduino = serial.Serial(port, timeout=1, baudrate=9600)
        print('ARDUINO', arduino)
        #arduino = serial.Serial(port, timeout=1)

        #RECIBIR INFO DE ARDUINO
        while count < 30:
            data = str(arduino.readline())[2:-5] + ";" + str(count)
            final_data = clean(data, ctd)

            if (final_data != None) :
                write(final_data, ref, json_path)
            
            count += 1



#METODOS PARA ESCRITURA EN DATA.JSON
def clean(data, ctd):
    
    list = data.split(';')
    
    try:
        if 0 < float(list[0]) < 100:

            historial["temperatura"].append(float(list[0]))
            historial["time"].append(float(list[3]))

            if ( len(historial["temperatura"]) > ctd ) :
                historial["temperatura"].pop(0)
                historial["time"].pop(0)

            final_data = {
                "temperatura" : float(list[0]),
                "humedad" : float(list[1]),
                # "puertas" : list[4],
                "historial" : {
                    "temperatura": historial["temperatura"],
                    "time": historial["time"]
                },
            }

        return final_data
    
    except:
        pass
    

def write(dict, ref, path):

    print(dict)

    with open(path, "w") as outfile:
        json.dump(dict, outfile)

    with open(path, "r") as file:
        file_contents = json.load(file)
    ref.set(file_contents)


main()