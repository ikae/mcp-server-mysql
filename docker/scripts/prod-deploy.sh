#!/bin/bash

# Production deployment script
echo "🚀 Deploying MCP MySQL Server in Production Mode"

# Navigate to docker directory
cd "$(dirname "$0")"

# Build production images
docker-compose -f docker-compose.yml -f docker-compose.prod.yml build

# Start services in production mode
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d

echo "✅ Production environment deployed!"
echo "📊 MCP Server: http://localhost:3000"
echo "🔌 MySQL: localhost:3306"

# Show running containers
docker-compose ps
