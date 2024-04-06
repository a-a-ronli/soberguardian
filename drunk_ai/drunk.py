import keras.utils as image
import tensorflow as tf
import numpy as np

#Model
model_path = 'model/model_unquant.tflite'
#Label
label_path = 'model/labels.txt'

def load_tflite_model(model_path):
  # Load the TFLite model and allocate tensors.
  tflite_interpreter = tf.lite.Interpreter(model_path=model_path)
  tflite_interpreter.allocate_tensors()

  # Get input and output tensors.
  input_details = tflite_interpreter.get_input_details()
  output_details = tflite_interpreter.get_output_details()

  return tflite_interpreter, input_details,output_details

#Loads the labels
def load_labels(label_path):

  with open(label_path, 'r') as f:
    labels = list(map(str.strip, f.readlines()))
  return labels

#Loads the images
def load_image(image_path):
  img = image.load_img(image_path,target_size=(224,224))
  img_array = tf.keras.utils.img_to_array(img)
  img = tf.expand_dims(img_array, 0) # Create a batch
  img = np.array(img, dtype=np.float32)
  return img

#Main functinon to predict the images
def predict(model_path,label_path, img_path):
  tflite_interpreter, input_details,output_details = load_tflite_model(model_path)
  labels = load_labels(label_path)
  img = load_image(img_path)
  top_k_results= len(labels) #number of labels or classes

  tflite_interpreter.set_tensor(input_details[0]['index'], img)

  # Run inference
  tflite_interpreter.invoke()

  # Get prediction results
  predictions = tflite_interpreter.get_tensor(output_details[0]['index'])[0]
  # print("Prediction results shape:", predictions)
  top_k_indices = np.argsort(predictions)[::-1][:top_k_results]

  pred_max=predictions[top_k_indices[0]]/255.0
  lbl_max=labels[top_k_indices[0]]
  return pred_max, lbl_max


# #Image we want to predict
# img_path = 'test2.JPG'

# #Predicts and prints the prediction
# pred_max, lbl_max = predict(model_path,label_path, img_path)
# print('pred:', 'conf:', pred_max,'- label:', lbl_max)

# #Displays the image
# img = image.load_img(img_path,target_size=(224,224))
# display(img)