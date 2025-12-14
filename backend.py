from flask import Flask, request, jsonify, render_template
import requests
import os

app = Flask(__name__)

# Read values injected by Terraform
AI_ENDPOINT = os.getenv("AZ_ENDPOINT")
AI_KEY = os.getenv("AZ_KEY")

# -------------------------------
# Sentiment Analysis Endpoint
# -------------------------------
@app.route("/sentiment", methods=["POST"])
def sentiment():
    body = request.json
    text = body.get("text", "")

    if not text:
        return jsonify({"error": "No text provided"}), 400

    payload = {
        "documents": [
            {"id": "1", "language": "en", "text": text}
        ]
    }

    headers = {
        "Ocp-Apim-Subscription-Key": AI_KEY,
        "Content-Type": "application/json"
    }

    # Azure Cognitive Service sentiment URL
    url = f"{AI_ENDPOINT}/text/analytics/v3.1/sentiment"

    response = requests.post(url, json=payload, headers=headers)

    if response.status_code != 200:
        return jsonify({
            "error": "Azure Cognitive Service returned an error",
            "details": response.text
        }), 500

    result = response.json()

    sentiment = result["documents"][0]["sentiment"]
    scores = result["documents"][0]["confidenceScores"]

    # Create objective, professional explanation
    explanation = ""
    if sentiment == "positive":
        explanation = "Today's rate is higher than usual."
    elif sentiment == "negative":
        explanation = "Pretty low today."
    else:
        explanation = "Rate is holding steady."

    return jsonify({
        "sentiment": sentiment,
        "scores": scores,
        "explanation": explanation
    })

# -------------------------------
# Home Route
# -------------------------------
@app.route("/")
def home():
    return render_template("index.html")

# -------------------------------
# Run Backend (Local Only)
# Azure uses Gunicorn in production
# -------------------------------
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
