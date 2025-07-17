#!/bin/bash

# Push script for Feast Redis Vector images
set -e

# Function to show usage
usage() {
    echo "Usage: $0 [REGISTRY]"
    echo ""
    echo "Arguments:"
    echo "  REGISTRY    Container registry to use (optional, default: yuvallevy543/feast)"
    echo ""
    echo "Examples:"
    echo "  $0                           # Use default registry"
    echo "  $0 myregistry/feast          # Use custom registry"
    echo "  $0 gcr.io/myproject/feast    # Use GCR registry"
    exit 1
}

# Parse command line arguments
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    usage
fi

# Configuration (should match build script)
export REGISTRY="${1:-yuvallevy543/feast}"  # Use CLI argument or default
export VERSION="redis-vector-$(date +%Y%m%d-%H%M%S)"

echo "🚀 Pushing Feast Redis Vector images to registry..."
echo "Registry: $REGISTRY"

# Login to registry (uncomment and modify as needed)
# docker login $REGISTRY

# Push Python-only images (matching the build script)
echo "📤 Pushing Feature Server..."
docker push ${REGISTRY}/feast-feature-server:${VERSION}
docker push ${REGISTRY}/feast-feature-server:latest

echo "📤 Pushing Transformation Server..."
docker push ${REGISTRY}/feast-transformation-server:${VERSION}
docker push ${REGISTRY}/feast-transformation-server:latest

echo "✅ All images pushed successfully!"
echo ""
echo "📋 Pushed images:"
echo "  - ${REGISTRY}/feast-feature-server:${VERSION}"
echo "  - ${REGISTRY}/feast-transformation-server:${VERSION}"
echo ""
echo "🚀 Next steps:"
echo "  1. Update your Kubernetes manifests with the new image tags"
echo "  2. Deploy to Kubernetes: kubectl apply -f k8s-manifests/"
echo "  3. Test Redis vector functionality"
