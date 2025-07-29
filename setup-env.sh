#!/bin/bash

# Setup script to make justfile commands work
# This script adds the working Maven installation to PATH

echo "🔧 Setting up environment for justfile commands..."

# Add working Maven to PATH
export PATH="/c/Users/krato/.m2/wrapper/dists/apache-maven-3.9.10/a38810a491b03367137adfdfbe7d14c4/bin:$PATH"

# Test Maven
if command -v mvn &> /dev/null; then
    echo "✅ Maven is now available:"
    mvn -version
else
    echo "❌ Maven not found in PATH"
fi

echo "✅ Environment setup complete!"
echo "💡 You can now run 'just' commands that use Maven" 