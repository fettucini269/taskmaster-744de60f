FROM python:3.12-slim

WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application
COPY app.py .

# Expose port
EXPOSE 8080

# Set environment variables
ENV PORT=8080
ENV TMPDIR=/tmp

# Start application (must read PORT env var)
CMD ["gunicorn", "--bind", "0.0.0.0:${PORT}", "--worker-tmp-dir=/tmp", "app:app"]
