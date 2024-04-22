import awsgi
import cv2
from flask import Flask, request, jsonify
from flask_cors import CORS
from tensorflow.keras.models import load_model
import numpy as np
import os
import tempfile
from PIL import Image
from tensorflow.keras.preprocessing.image import img_to_array

app = Flask(__name__)
CORS(app)

# Replace 'desired_width' and 'desired_height' with your model's input size
desired_width = 224
desired_height = 224

# Load your pre-trained model and labels
model = load_model('C:\\Users\\Tejaswi Rao\\Downloads\\best_model.h5')
labels = ["Normal", "Tuberculosis"]  # Replace with your actual class labels

def load_and_preprocess_image(image_path):
    try:
        # Read the image using OpenCV
         img = Image.open(image_path)
         img = img.resize((desired_width, desired_height))  # Resize the image to the required dimensions
         img = img.convert("RGB")  # Ensure the image has 3 channels (RGB)
         img = img_to_array(img)
         return img
    except Exception as e:
        raise Exception(f"Error loading and preprocessing image: {str(e)}")

def predict_image(image_path):
    # Load and preprocess the image (adjust as per your model requirements)
    image = load_and_preprocess_image(image_path)

    # Make a prediction
    predictions = model.predict(np.array([image]))

    # Get the predicted class label
    predicted_label = labels[np.argmax(predictions)]

    return predicted_label

@app.route('/predict', methods=['POST'])
def predict():
    if 'image' not in request.files:
        return jsonify({'error': 'No image provided'})

    image = request.files['image']

    if image.filename == '':
        return jsonify({'error': 'No selected image'})

    try:
        # Create a temporary file to save the uploaded image
        temp_file = tempfile.NamedTemporaryFile(delete=False, suffix=".jpg")
        image.save(temp_file.name)
        temp_file.close()

        # Call the predict_image function with the temporary file path
        predicted_label = predict_image(temp_file.name)

        # Clean up the temporary file
        os.remove(temp_file.name)

        return jsonify(predicted_label)
    except Exception as e:
        return jsonify({'error': str(e)})
    
def lambda_handler(event, context):
    return awsgi.response(app, event, context, base64_content_types={"image/png"})

if __name__ == '__main__':
    app.run(debug=True)