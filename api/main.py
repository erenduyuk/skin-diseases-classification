from pydoc import classname
import cv2
from fastapi import FastAPI, File, HTTPException, Request, UploadFile
from fastapi.responses import FileResponse, JSONResponse
import os
from random import randint
import uuid
import numpy as np
from fastapi import FastAPI, File, UploadFile
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, model_serializer
import uvicorn
import numpy as np
from io import BytesIO
from PIL import Image
import tensorflow as tf
from fastapi.responses import RedirectResponse
from pyngrok import ngrok
from fastapi.middleware.cors import CORSMiddleware
import nest_asyncio
 
IMAGEDIR = "images/"
 
app = FastAPI()

def read_file_as_image(data) -> np.ndarray:
    image = np.array(Image.open(BytesIO(data)))
    return image
 
model = tf.keras.models.load_model("DeriHastaliklariguncel.h5")

CLASS_NAMES = ["Akne","Cilt Kanseri", "Egzama","Kurdeşan","Roza"
               , "Sedef", "Siğil", "Su Çicegi", "Uyuz", "Yağ Bezesi"]
class_names = ["Akne","Cilt Kanseri", "Egzama","Kurdeşan","Roza"
               , "Sedef", "Siğil", "Su Çicegi", "Uyuz", "Yağ Bezesi"]
image_exts = ["jpeg" ,"jpg","bmp" , "png"]


class Item(BaseModel):
    data: str


@app.post("/upload/")
async def create_upload_file(file: UploadFile = File(...)):
 
    allowed_extensions = {"jpeg" ,"jpg","bmp" , "png"}
    file_extension = file.filename.split(".")[-1].lower()
    
    if file_extension not in allowed_extensions:
        return {"error": "Geçersiz dosya türü. Sadece jpg ve png dosyaları kabul edilir."}
    
    # Yeni dosya adı oluştur
    file.filename = f"{uuid.uuid4()}.{file_extension}"
    contents = await file.read()
 
    #save the file
    with open(f"{IMAGEDIR}{file.filename}", "wb") as f:
        f.write(contents)
 
    return {"filename": file.filename}




@app.post("/uploadText/")
async def create_upload_item(item: Item):
    data = item.data
    if not data:
        raise HTTPException(status_code=422, detail="Data cannot be empty")
    # Process the string data as needed
    # For example, you can save it to a file
    with open("text_data.txt", "w") as f:
        f.write(data)

    return {"data": data}




@app.post("/predict")
async def predict(
    file: UploadFile = File(...)
):
    image = read_file_as_image(await file.read())
    resize = tf.image.resize(image, (256,256))

    yhat = model.predict(np.expand_dims(resize / 255, 0))
    

    predicted_class = np.argmax(yhat)

    with open("predict_data.txt", "w") as f:
        f.write(class_names[predicted_class])
    
    return {
        'Predicted class is': class_names[predicted_class]
    }
 
 
@app.get("/show/")
async def read_random_file():
 
    # get random file from the image directory
    files = os.listdir(IMAGEDIR)
    random_index = randint(0, len(files) - 1)
 
    path = f"{IMAGEDIR}{files[random_index]}"
     
    return FileResponse(path)

@app.exception_handler(ValueError)
async def value_error_exception_handler(request: Request, exc: ValueError):
    return JSONResponse(
        status_code=400,
        content={"message": str(exc)},
    )

ngrok_tunnel = ngrok.connect(8000)
print('Public URL:', ngrok_tunnel.public_url)
nest_asyncio.apply()
uvicorn.run(app, port=8000)