# Docker Setup for MCP MySQL Server

This directory contains Docker configurations for running the MCP MySQL Server.

## Quick Start

### Development Mode
```bash
# Using npm script (recommended)
npm run docker:dev

# Or using Docker Compose directly (from docker/ directory)
cd docker
docker-compose -f docker-compose.yml -f docker-compose.dev.yml up --build
```

### Production Mode
```bash
# Using npm script
npm run docker:prod

# Or using Docker Compose directly (from docker/ directory)
cd docker
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d
```

## Services

### 🗄️ MySQL Database
- **Port**: `3306`
- **Root Password**: `simlexadmin`
- **Database**: `adcomat`
- **User**: `mcpuser` / `mcppassword`

### 📊 MCP Server
- **Port**: `3000`
- **Endpoint**: `http://localhost:3000/mcp`
- **Authorization**: `Bearer docker-secret-key`

### 🌐 phpMyAdmin (Development only)
- **Port**: `8080`
- **URL**: `http://localhost:8080`
- **Username**: `root`
- **Password**: `simlexadmin`

## Configuration Files

- `docker/docker-compose.yml` - Base configuration
- `docker/docker-compose.dev.yml` - Development overrides
- `docker/docker-compose.prod.yml` - Production overrides
- `docker/.env` - Environment variables
- `docker/Dockerfile.dev` - Development build
- `Dockerfile` - Production build (in root)

## Environment Variables

You can override environment variables by creating a `docker/.env.local` file:

```bash
# docker/.env.local
MYSQL_ROOT_PASSWORD=your-secure-password
REMOTE_SECRET_KEY=your-secret-key
MCP_PORT=3001
```

## Useful Commands

```bash
# Navigate to docker directory first
cd docker

# View logs
docker-compose logs -f mcp-server
docker-compose logs -f mysql

# Access MySQL CLI
docker-compose exec mysql mysql -u root -p

# Stop services
docker-compose down

# Stop and remove volumes
docker-compose down -v

# Rebuild images
docker-compose build --no-cache

# Scale MCP server
docker-compose up --scale mcp-server=3
```

## Testing the MCP Server

```bash
# Health check
curl -X POST http://localhost:3000/mcp \
  -H "Authorization: Bearer docker-secret-key" \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc": "2.0", "id": 1, "method": "tools/list"}'

# Example query
curl -X POST http://localhost:3000/mcp \
  -H "Authorization: Bearer docker-secret-key" \
  -H "Content-Type: application/json" \
  -d '{
    "jsonrpc": "2.0",
    "id": 1,
    "method": "tools/call",
    "params": {
      "name": "mysql_query",
      "arguments": {"sql": "SHOW TABLES"}
    }
  }'
```

## Troubleshooting

### MySQL Connection Issues
```bash
# Check if MySQL is healthy
cd docker
docker-compose ps
docker-compose logs mysql

# Test connection
docker-compose exec mysql mysqladmin ping -h localhost
```

### MCP Server Issues
```bash
# Check server logs
cd docker
docker-compose logs mcp-server

# Restart just the MCP server
docker-compose restart mcp-server
```

### Permission Issues
```bash
# Fix volume permissions
sudo chown -R $USER:$USER ../logs
sudo chown -R 999:999 ./mysql-data  # MySQL user
```
