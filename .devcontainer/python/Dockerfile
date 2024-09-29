# Use the official Python image as a base
FROM python:3.10-slim

# Set environment variables to avoid prompts during package installs
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies needed for Poetry and Commitizen
RUN apt-get update && \
    apt-get install -y curl build-essential git && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | python3 -

# Add Poetry to PATH
ENV PATH="/root/.local/bin:$PATH"

# Create a working directory
WORKDIR /workspace

# Install Python dependencies (if any lock file exists)
# COPY pyproject.toml poetry.lock* ./
# RUN if [ -f "poetry.lock" ]; then poetry install; fi

# Set the default command for the container
CMD ["sleep", "infinity"]