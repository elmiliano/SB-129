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
def main():

    #ARDUINO CONNECTION
    port = ''
    data = [10,1,2,3,0]
    count = 1
    delay = 5

    #CONFIG DE CONEXION CON BD FIREBASE
    path = 'python/sb-129-proj-f1b72e0e0f19.json'
    databaseURL = 'https://sb-129-proj-default-rtdb.firebaseio.com/'

    cred = credentials.Certificate(path)
    firebase_admin.initialize_app(cred, {'databaseURL': databaseURL})
    ref = db.reference("/")

    #ABRIR PUERTO
    try:
        #arduino = serial.Serial(port, timeout=1, baudrate=None)    <-- Para cambiar baudrate
        #arduino = serial.Serial(port, timeout=1)
        pass
    except:
        print('ERROR EN PUERTO')
        
    #RECIBIR INFO DE ARDUINO
    while count < 6:
        #data.append(str(arduino.readline()))

        data = [ i*count for i in data ]
        data[4] = count % 2
        print(data)

        final_data = clean(data)
        write(final_data, ref)
        time.sleep(delay)
        count += 1

    # ENVIO DE DATOS DE JSON A FIREBASE
    final_data = clean(data)
    write(final_data)


#METODOS PARA ESCRITURA EN DATA.JSON
def clean(list):

    historial["temperatura"].append(list[2])
    historial["time"].append(list[3])
    
    final_data = {
        "temperatura" : list[0],
        "humedad" : list[1],
        "puertas" : list[4],
        "historial" : {
             "temperatura": historial["temperatura"],
             "time": historial["time"]
        },
    }

    return final_data

def write(dict, ref):

    file = open("python/data.json", mode = 'w')

    with open("python/data.json", "w") as outfile:
        json.dump(dict, outfile)

    with open("python/data.json", "r") as file:
        file_contents = json.load(file)
    ref.set(file_contents)


main()