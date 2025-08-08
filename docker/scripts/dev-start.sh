#!/bin/bash

# Development setup script
echo "🚀 Starting MCP MySQL Server in Development Mode"

# Create logs directory if it doesn't exist
mkdir -p ../logs

# Navigate to docker directory
cd "$(dirname "$0")"

# Start services in development mode
docker-compose -f docker-compose.yml -f docker-compose.dev.yml up --build

echo "✅ Development environment started!"
echo "📊 MCP Server: http://localhost:3000"
echo "🗄️  phpMyAdmin: http://localhost:8080"
echo "🔌 MySQL: localhost:3306"
