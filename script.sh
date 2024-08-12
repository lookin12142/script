#!/bin/bash

# Build the Docker image
docker build -t dotnet-docker-app .

# Run the Docker container in detached mode
CONTAINER_ID=$(docker run -d dotnet-docker-app)

# Copy the application files from the container to the local machine
docker cp $CONTAINER_ID:/app ./App

# Stop the container
docker stop $CONTAINER_ID

# Remove the container
docker rm $CONTAINER_ID