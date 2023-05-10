import firebase_admin
from firebase_admin import credentials

cred = credentials.Certificate("/SB-129/python/sb-129-proj-f1b72e0e0f19.json")
firebase_admin.initialize_app(cred)
