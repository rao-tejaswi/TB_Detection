from flask import Flask, request, jsonify
from torchvision.transforms import functional as F
from PIL import Image
import torch
from torchvision.models.detection import fasterrcnn_resnet50_fpn
import torchvision.models.detection.faster_rcnn
import torchvision.transforms as T
import xml.etree.ElementTree as ET
import io

app = Flask(__name__)

# Load the model without pretrained weights
model = fasterrcnn_resnet50_fpn(pretrained_backbone=False)

# Replace the classifier head
num_classes = 2  # Number of classes (including background)
in_features = model.roi_heads.box_predictor.cls_score.in_features
model.roi_heads.box_predictor = torchvision.models.detection.faster_rcnn.FastRCNNPredictor(in_features, num_classes)
model.load_state_dict(torch.load("C:\\Users\\Tejaswi Rao\\Downloads\\model.pth", map_location=torch.device('cpu')))
model.eval()

# Define the transformations
transform = T.Compose([T.ToTensor()])

# Define the classes
CLASSES = ['background', 'TB bacilli']

def parse_xml_annotation(xml_path):
    tree = ET.parse(xml_path)
    root = tree.getroot()

    boxes = []
    for obj in root.findall('object'):
        bbox = obj.find('bndbox')
        x0 = int(bbox.find('xmin').text)
        y0 = int(bbox.find('ymin').text)
        x1 = int(bbox.find('xmax').text)
        y1 = int(bbox.find('ymax').text)
        boxes.append([x0, y0, x1, y1])

    return boxes

@app.route('/detect_tb', methods=['POST'])
def detect_tb():
    # Get the image file from the request
    file = request.files['image']
    
    # Load the image
    img = Image.open(io.BytesIO(file.read()))
    
    # Transform the image
    img_tensor = transform(img).unsqueeze(0)
    
    # Make prediction
    with torch.no_grad():
        prediction = model(img_tensor)[0]
        
    # Filter predictions by threshold
    boxes = prediction['boxes'][prediction['scores'] > 0.5].tolist()
    
    # Prepare response
    response = {'predictions': []}
    
    # Get the class labels
    labels = prediction['labels'][prediction['scores'] > 0.5].tolist()
    
    for box, label in zip(boxes, labels):
        response['predictions'].append({
            'class': CLASSES[label],
            'box': box
        })
    
    return jsonify(response)

if __name__ == '__main__':
    app.run(debug=True)
