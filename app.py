from fastapi import FastAPI
from transformers import pipeline

#create new fastapi app instance
app=FastAPI()

#using pipeline from huggingface
pipe = pipeline("text2text-generation", model="google/flan-t5-small")

@app.get("/")
def home():
   return {"message":"Welcome board"}

@app.get("/generate")
def generate(text:str):
   out=pipe(text)
   return out[0]['generated_text']