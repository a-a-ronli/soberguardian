from flask import Flask, jsonify, request
from flask_cors import CORS
import drunk_ai.drunk

app = Flask(__name__)
CORS(app)

@app.route('/')
def hello_world():
    return jsonify({'message': 'Hello, World!'})

@app.route('/alcohol', methods=['POST'])
def detect_alcohol():
    # Decode the image
    img = request.files['image']
    img.save('image.jpg')
    # Call the predict function
    pred_max, lbl_max = drunk_ai.drunk.predict('drunk_ai/model/model_unquant.tflite', 'drunk_ai/model/labels.txt', 'image.jpg')
    print('pred:', 'conf:', pred_max,'- label:', lbl_max)

    return jsonify({'conf': pred_max, 'label': lbl_max})

if __name__ == '__main__':
  app.run(host='0.0.0.0')