# devops-docker-assignment

A Dockerized Flask web application with a GitHub Actions CI pipeline that builds the Docker image on every push.

## Project Structure

```
devops-docker-assignment/
├── app.py                        # Flask application (bug-fixed)
├── requirements.txt              # Python dependencies
├── Dockerfile                    # Docker build instructions
├── .github/
│   └── workflows/
│       └── build.yml             # GitHub Actions CI workflow
└── README.md                     # This file
```

---

## Code Improvements

The following improvements were made to `app.py` to ensure best practices and compatibility:

| Area | Explanation |
|------|-------------|
| Health endpoint | Explicitly used `jsonify()` to return a proper JSON response with correct `Content-Type: application/json` header, which is best practice regardless of Flask version |
| Flask startup | App runs with `host="0.0.0.0"` so Docker can expose it outside the container |
| Port configuration | Host port `5000` mapped to container port `5000` via `EXPOSE 5000` in Dockerfile |

> **Note:** Modern Flask (2.x+) supports returning a plain dictionary as JSON, but explicitly using `jsonify()` is the recommended best practice for clarity and guaranteed header correctness.

---

## Setup & Running Locally

### Prerequisites
- Python 3.11+
- Docker Desktop

### Run Without Docker

```bash
pip install -r requirements.txt
python app.py
```

### Test Routes

```bash
curl localhost:5000/
# Hello from DevOps!

curl localhost:5000/health
# {"status": "ok"}
```

---

## Docker Commands

### Build the Image

```bash
docker build -t devops-docker-assignment:latest .
```

### Run the Container

```bash
docker run -d -p 5000:5000 --name devops-app devops-docker-assignment:latest
```

### Test the Running Container

```bash
curl localhost:5000/
# Hello from DevOps!

curl localhost:5000/health
# {"status": "ok"}
```

### Stop & Remove Container

```bash
docker rm -f devops-app
```

---

## curl Output (Sample)

```
$ curl localhost:5000/
Hello from DevOps!

$ curl localhost:5000/health
{"status":"ok"}
```

---

## GitHub Actions CI

The workflow file [`.github/workflows/build.yml`](.github/workflows/build.yml) automatically:

1. Checks out the code
2. Sets up Docker Buildx
3. Builds the Docker image
4. Runs the container and tests both endpoints
5. Cleans up the container

**Trigger:** Runs on every `git push` to the `main` branch.

To verify: Go to your GitHub repo → **Actions** tab → Check the latest workflow run.

---

## Push to GitHub

```bash
git init
git add .
git commit -m "Initial commit: Dockerized Flask app with CI"
git branch -M main
git remote add origin https://github.com/<your-username>/devops-docker-assignment.git
git push -u origin main
```
