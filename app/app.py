from flask import Flask, render_template, request, redirect, url_for
import boto3
import os
from werkzeug.utils import secure_filename

app = Flask(__name__)

# Get bucket name from environment variable or hardcode it temporarily
S3_BUCKET = os.environ.get("S3_BUCKET", "photo-upload-bucket-demo")

# Create S3 client (uses EC2 IAM role credentials automatically)
s3 = boto3.client("s3")

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/upload", methods=["POST"])
def upload():
    if "file" not in request.files:
        return "No file part", 400
    
    file = request.files["file"]
    if file.filename == "":
        return "No selected file", 400
    
    filename = secure_filename(file.filename)
    file_path = f"/tmp/{filename}"
    file.save(file_path)

    # Upload file to S3
    try:
        s3.upload_file(file_path, S3_BUCKET, filename)
        os.remove(file_path)
        return f"✅ File '{filename}' uploaded successfully to S3 bucket '{S3_BUCKET}'!"
    except Exception as e:
        return f"❌ Upload failed: {e}"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)
