from flask import Flask, jsonify   # Bug Fix: added jsonify import

app = Flask(__name__)


@app.route("/")
def home():
    return "Hello from DevOps!"


@app.route("/health")
def health():
    return jsonify({"status": "ok"})   # Bug Fix: wrapped dict with jsonify()


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
