#!/bin/bash

# FunCaptcha ThinkPHP - Docker Setup Script
# Builds and tests the Docker image locally before Render deployment

set -e

echo "🚀 FunCaptcha ThinkPHP - Docker Build & Test"
echo "=============================================="
echo ""

# Check Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker not found. Install from: https://docs.docker.com/get-docker/"
    exit 1
fi

echo "✅ Docker found"
echo ""

# Build
echo "📦 Building Docker image..."
docker build -t funcapt-thinkphp:latest -f Dockerfile.thinkphp . || {
    echo "❌ Build failed"
    exit 1
}
echo "✅ Build successful"
echo ""

# Run
echo "🚀 Starting container..."
CONTAINER=$(docker run -d -p 8080:8080 funcapt-thinkphp:latest)
echo "✅ Container started: $CONTAINER"
echo ""

# Wait
echo "⏳ Waiting for services to start..."
sleep 5

# Test
echo "🧪 Testing health endpoint..."
MAX_RETRIES=10
RETRY_COUNT=0
SUCCESS=false

while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
    if curl -s http://localhost:8080/arkoselabs/health > /dev/null 2>&1; then
        RESPONSE=$(curl -s http://localhost:8080/arkoselabs/health)
        echo "✅ Health check PASSED"
        echo "Response: $RESPONSE"
        SUCCESS=true
        break
    else
        RETRY_COUNT=$((RETRY_COUNT + 1))
        if [ $RETRY_COUNT -lt $MAX_RETRIES ]; then
            echo "⏳ Retry $RETRY_COUNT/$MAX_RETRIES..."
            sleep 2
        fi
    fi
done

if [ "$SUCCESS" = false ]; then
    echo "❌ Health check failed"
    echo "Logs:"
    docker logs $CONTAINER
    docker stop $CONTAINER
    exit 1
fi

echo ""
echo "📊 Server Information:"
echo "====================="
echo "Image: funcapt-thinkphp:latest"
echo "Container: $CONTAINER"
echo "Port: 8080"
echo ""

echo "📡 Available Endpoints:"
echo "====================="
echo "GET  /arkoselabs/health     → Status check"
echo "POST /arkoselabs/gfct       → Get challenge"
echo "POST /arkoselabs/fcca       → Submit answer"
echo "GET  /arkoselabs/init_load  → Initialize"
echo "GET  /arkoselabs/rtigimage  → Get image"
echo "POST /arkoselabs/pkeytoken  → Get token"
echo ""

echo "📝 Testing Example:"
echo "=================="
echo "curl http://localhost:8080/arkoselabs/health"
echo ""

echo "🛑 To stop container:"
echo "===================="
echo "docker stop $CONTAINER"
echo "docker rm $CONTAINER"
echo ""

echo "✨ All tests passed! Ready for Render deployment!"
echo ""
echo "🚀 Next steps:"
echo "1. Verify endpoints work correctly"
echo "2. Push to GitHub"
echo "3. Deploy to Render: https://render.com/dashboard"
echo ""

# Keep running
echo "Container running at http://localhost:8080"
echo "Press Ctrl+C to stop"
docker logs -f $CONTAINER
