FROM python:3.12-slim

WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application
COPY app.py .

# Create non-root user UID 4000
RUN groupadd -g 4000 appuser && \
    useradd -u 4000 -g 4000 -m appuser && \
    mkdir -p /tmp /var/cache/nginx /var/run && \
    chown -R 4000:4000 /app /tmp /var/cache/nginx /var/run

# Expose port
EXPOSE 8080

# Set environment variables
ENV PORT=8080
ENV TMPDIR=/tmp

# Switch to non-root user
USER 4000

# Start application (must read PORT env var)
CMD ["gunicorn", "--bind", "0.0.0.0:${PORT}", "--worker-tmp-dir=/tmp", "app:app"]
