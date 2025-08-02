# 1. Use official Python 3.10 slim base image
FROM python:3.10-slim

# 2. Set working directory
WORKDIR /app

# 3. Install required system dependencies for building Python packages like aiohttp
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    build-essential \
    libffi-dev \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# 4. Copy requirements file first (for Docker layer caching)
COPY requirements.txt .

# 5. Upgrade pip, setuptools, and wheel, then install Python dependencies
RUN pip install --upgrade pip setuptools wheel \
    && pip install --no-cache-dir -r requirements.txt

# 6. Copy the rest of the application code
COPY . .

# 7. Expose the application port
EXPOSE 8000

# 8. Set the default command to run the FastAPI app
CMD ["python", "pain001_API.py"]
