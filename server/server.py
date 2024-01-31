from flask import Flask, request, jsonify
from werkzeug.utils import secure_filename
from sybil import Sybil, Serie
import json
import os
import logging

logging.basicConfig(level = logging.INFO)
# load config from ./server_config.json
config = {}
with open('./server/server_config.json') as f:
    config = json.load(f)

# load constants from config
UPLOAD_FOLDER = config["UPLOAD_FOLDER"]
ALLOWED_EXTENSIONS = config["ALLOWED_EXTENSIONS"]

# Initialize Flask application
app = Flask(__name__)

# Configure upload folder, storing uploaded files in the 'uploads' folder
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs(UPLOAD_FOLDER)

# Load the trained model
model = Sybil("sybil_base")

# Check if a filename has an allowed extension
def allowed_file(filename):
    file_extension = filename.rsplit('.', 1)[1].lower()
    return ("." in filename and file_extension in ALLOWED_EXTENSIONS, file_extension)

# Define API endpoint for prediction
@app.route('/predict', methods=['POST'])
def predict():
    # Log request 
    logging.info(f"Request received: {request}")
    # Check if request contains files
    if 'file' not in request.files:
        return jsonify({'error': 'No files provided'})
    
    # Get files from request
    files = request.files.getlist('file')

    # Check if files are empty
    if len(files) == 0:
        return jsonify({'error': 'No files uploaded'})
    
    # Check if file has an allowed extension
    for file in files:
        (file_extension_allowed, file_extension) = allowed_file(file.filename)
        if not file_extension_allowed:
            return jsonify({f"error': 'File extension {file_extension} not allowed"})
    
 # Save files to upload folder
    saved_file_paths = []
    for file in files:
        filename = secure_filename(file.filename)
        file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
        file.save(file_path)
        saved_file_paths.append(file_path)

    logging.info(f"Saved {len(saved_file_paths)} to {saved_file_paths}")
    
    # Get risk scores
    logging.info(f"Predicting risk scores for {saved_file_paths}")
    serie = Serie(saved_file_paths)
    scores = model.predict([serie])
    
    # remove upload folder
    os.rmdir(app.config['UPLOAD_FOLDER'])
    
    # Return predictions as JSON response
    return jsonify({'scores': scores})

if __name__ == '__main__':
    # Run the Flask application
    app.run(host='0.0.0.0', port=8000)
