
# Use official Python slim image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy requirements
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY . .

# Create a non-root user and assign application ownership
RUN useradd --create-home appuser && \
    chown -R appuser:appuser /app

# Run application as non-root user
USER appuser

# Expose Flask port
EXPOSE 5000

# Start Flask application
CMD ["python", "app.py"]

