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

## Bug Fixes

The original `app.py` contained the following bugs:

| # | Location | Problem | Fix |
|---|----------|---------|-----|
| 1 | `app.py` line 1 | `jsonify` was not imported from `flask` | Added `jsonify` to the import: `from flask import Flask, jsonify` |
| 2 | `/health` route | `return {"status": "ok"}` returns a plain Python dict — older Flask versions raise a `TypeError` and even in Flask 2.x the Content-Type header is not reliably set to `application/json` without `jsonify` | Replaced with `return jsonify({"status": "ok"})` |

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
