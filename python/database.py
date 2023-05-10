import firebase_admin # IF NOT DEFINED --IN TERMINAL--> pip3 install firebase-admin
from firebase_admin import credentials
from firebase_admin import firestore

cred = credentials.Certificate("/SB-129/python/sb-129-proj-f1b72e0e0f19.json")
firebase_admin.initialize_app(cred)

db = firestore.client() # connecting to firestore