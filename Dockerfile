# Use a lightweight Python base image

FROM python:3.11-slim



# Prevent Python from writing pyc files and enable unbuffered logging

ENV PYTHONDONTWRITEBYTECODE=1

ENV PYTHONUNBUFFERED=1



WORKDIR /app



# Install system-level dependencies if needed for your ML libraries

# (e.g., PennyLane, numpy, etc.)

RUN apt-get update && apt-get install -y --no-install-recommends \

    build-essential \

    && rm -rf /var/lib/apt/lists/*



# Install Python dependencies

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt



# Copy all application folders and files

# This maintains the structure: apps/, common/, gateway/, services/, schemas/, etc.

COPY . .



# Expose the port the FastAPI gateway runs on (usually 8000)

EXPOSE 8000



# Command to run the application. 

# Note: Adjust the module path based on where your main.py resides within gateway/

CMD ["uvicorn", "gateway.main:app", "--host", "0.0.0.0", "--port", "8000"] 
