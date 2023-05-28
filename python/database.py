import firebase_admin # IF NOT DEFINED --IN TERMINAL--> pip3 install firebase-admin o python3 -m pip install firebase-admin

from firebase_admin import credentials
from firebase_admin import firestore
from firebase_admin import db

import json

# path = '/Users/emilianomachado/Documents/CETYS/8to Semestre/Proyecto ICE/Interfaz GitHub/SB-129/python/sb-129-proj-f1b72e0e0f19.json'
# path = 'python/sb-129-proj-f1b72e0e0f19.json'
path = 'python\sb-129-proj-f1b72e0e0f19.json'
databaseURL = 'https://sb-129-proj-default-rtdb.firebaseio.com/'

cred = credentials.Certificate(path)
firebase_admin.initialize_app(cred, {'databaseURL': databaseURL})

#db = firestore.client() # connecting to firestore
ref = db.reference("/")

with open("python/data.json", "r") as file:
	file_contents = json.load(file)
ref.set(file_contents)