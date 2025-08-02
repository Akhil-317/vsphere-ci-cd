# 1. Use official Python base image
FROM python:3.10-slim

# 2. Set working directory
WORKDIR /app

# 3. Copy requirements first for caching
COPY requirements.txt .

# 4. Install system dependencies required for aiohttp and psycopg2
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# 5. Upgrade pip, setuptools, wheel to avoid aiohttp build issues
RUN pip install --upgrade pip setuptools wheel

# 6. Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# 7. Copy all source code
COPY . .

# 8. Expose the app port
EXPOSE 8000

# 9. Run FastAPI app
CMD ["uvicorn", "pain001_API:app", "--host", "0.0.0.0", "--port", "8000"]
