@echo off
REM Windows batch file for development

echo 🚀 Starting MCP MySQL Server in Development Mode

REM Create logs directory if it doesn't exist
if not exist ..\logs mkdir ..\logs

REM Navigate to docker directory
cd /d "%~dp0"

REM Start services in development mode
docker-compose -f docker-compose.yml -f docker-compose.dev.yml up --build

echo ✅ Development environment started!
echo 📊 MCP Server: http://localhost:3000
echo 🗄️  phpMyAdmin: http://localhost:8080
echo 🔌 MySQL: localhost:3306
