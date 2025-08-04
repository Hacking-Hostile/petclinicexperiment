#!/bin/bash

echo "🔧 Setting up local Maven installation..."

# Create tools directory if it doesn't exist
mkdir -p tools

# Download Maven if not already present
if [ ! -d "tools/maven" ]; then
    echo "📥 Downloading Maven 3.9.10..."
    
    # Download Maven
    curl -L -o tools/maven.tar.gz https://archive.apache.org/dist/maven/maven-3/3.9.10/binaries/apache-maven-3.9.10-bin.tar.gz
    
    if [ $? -eq 0 ]; then
        echo "📦 Extracting Maven..."
        tar -xzf tools/maven.tar.gz -C tools/
        mv tools/apache-maven-3.9.10 tools/maven
        rm tools/maven.tar.gz
        
        echo "✅ Maven installed successfully in tools/maven/"
        echo "📋 Maven version:"
        tools/maven/bin/mvn -version
    else
        echo "❌ Failed to download Maven"
        exit 1
    fi
else
    echo "✅ Maven already installed in tools/maven/"
    echo "📋 Maven version:"
    tools/maven/bin/mvn -version
fi

echo "🎉 Local Maven setup complete!"
echo "💡 Maven is now available at: ./tools/maven/bin/mvn" 