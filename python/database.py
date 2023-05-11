import firebase_admin # IF NOT DEFINED --IN TERMINAL--> pip3 install firebase-admin
from firebase_admin import credentials
from firebase_admin import firestore

path = '/Users/emilianomachado/Documents/CETYS/8to Semestre/Proyecto ICE/Interfaz GitHub/SB-129/python/sb-129-proj-f1b72e0e0f19.json'

cred = credentials.Certificate(path)
print(cred)
firebase_admin.initialize_app(cred)

db = firestore.client() # connecting to firestore

collection = db.collection('temp_test')  # create collection
res = collection.document('A01').set({ # insert document
    'temp'     : 20,
    'humedad'  : 30,
    'puerta1'  : 1, #OPEN
    'puerta2'  : 0  #CLOSED
})

res = collection.document('A01').update({ # insert document
    'temp'     : 46,
    'humedad'  : 32,
    'puerta2'  : 1
})