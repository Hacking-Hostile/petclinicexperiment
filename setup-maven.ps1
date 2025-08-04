# PowerShell script to setup Maven locally

Write-Host "🔧 Setting up local Maven installation..." -ForegroundColor Green

# Create tools directory if it doesn't exist
if (!(Test-Path "tools")) {
    New-Item -ItemType Directory -Path "tools"
}

# Download Maven if not already present
if (!(Test-Path "tools/maven")) {
    Write-Host "📥 Downloading Maven 3.9.10..." -ForegroundColor Yellow
    
    # Download Maven
    $mavenUrl = "https://archive.apache.org/dist/maven/maven-3/3.9.10/binaries/apache-maven-3.9.10-bin.tar.gz"
    $mavenTar = "tools/maven.tar.gz"
    
    try {
        Invoke-WebRequest -Uri $mavenUrl -OutFile $mavenTar
        
        Write-Host "📦 Extracting Maven..." -ForegroundColor Yellow
        
        # Extract using tar (if available) or use 7zip
        if (Get-Command tar -ErrorAction SilentlyContinue) {
            tar -xzf $mavenTar -C tools/
            Move-Item "tools/apache-maven-3.9.10" "tools/maven"
        } else {
            Write-Host "⚠️  tar not available, please extract manually:" -ForegroundColor Yellow
            Write-Host "   Download: $mavenUrl" -ForegroundColor Cyan
            Write-Host "   Extract to: tools/maven/" -ForegroundColor Cyan
        }
        
        Remove-Item $mavenTar -ErrorAction SilentlyContinue
        
        Write-Host "✅ Maven installed successfully in tools/maven/" -ForegroundColor Green
    }
    catch {
        Write-Host "❌ Failed to download Maven: $_" -ForegroundColor Red
        Write-Host "💡 Please download Maven manually from: $mavenUrl" -ForegroundColor Yellow
        Write-Host "   Extract to: tools/maven/" -ForegroundColor Yellow
    }
} else {
    Write-Host "✅ Maven already installed in tools/maven/" -ForegroundColor Green
}

Write-Host "🎉 Local Maven setup complete!" -ForegroundColor Green
Write-Host "💡 Maven is now available at: ./tools/maven/bin/mvn" -ForegroundColor Cyan 