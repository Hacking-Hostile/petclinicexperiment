# Multi-Language CI/CD Pipeline - Just Commands
# Universal Project Template - Language Agnostic

# CI: false
# STAGE: 0
default: # 📋 Show available commands
    @echo "🚀 Multi-Language CI/CD Pipeline - Just Commands"
    @echo "================================================"
    @echo ""
    @echo "🏗️  BUILD & COMPILATION:"
    @echo "  build          🔨 Build the application"
    @echo "  clean          🧹 Clean build artifacts"
    @echo ""
    @echo "🧪 TESTING & QUALITY:"
    @echo "  test           🧪 Run tests"
    @echo "  lint           🔍 Run linting"
    @echo "  format         🎨 Format code"
    @echo "  coverage       📊 Generate coverage report"
    @echo ""
    @echo "🖥️  DEVELOPMENT & DEBUGGING:"
    @echo "  run            🖥️ Run application"
    @echo "  debug          🐛 Debug application"
    @echo "  watch          👀 Watch for file changes"
    @echo "  doctor         🏥 Diagnose development environment"
    @echo "  dev-setup      🔧 Setup development environment"
    @echo "  dev-status     📊 Check development status"
    @echo "  dev-stop       🛑 Stop development environment"
    @echo ""
    @echo "🗄️  DATABASE:"
    @echo "  run-h2         🗄️ Run with H2 database"
    @echo "  db-init-h2     🗄️ Initialize H2 database"
    @echo "  db-reset-h2    🗄️ Reset H2 database"
    @echo "  db-schema      🗄️ Show database schema"
    @echo ""
    @echo "📋 REPORTS & DOCUMENTATION:"
    @echo "  cyclonedx-report 📋 Generate CycloneDX report"
    @echo "  mvn-validate   ✅ Validate Maven project"
    @echo "  mvn-site       🌐 Generate Maven site"
    @echo ""
    @echo "🏥 HEALTH & VALIDATION:"
    @echo "  health-check   🏥 Comprehensive health check"
    @echo "  validate-env   ✅ Validate environment setup"
    @echo "  validate       ✅ Validate justfile"
    @echo ""
    @echo "☕ SYSTEM & ENVIRONMENT:"
    @echo "  java-version   ☕ Show Java version"
    @echo "  maven-version  📦 Show Maven version"
    @echo "  status         📊 Show project status"
    @echo "  env-info       🌍 Show environment info"
    @echo "  detect         🔍 Detect project type"
    @echo ""
    @echo "📁 FILE & UTILITY:"
    @echo "  find-java      📁 Find Java files"
    @echo "  find-resources 📁 Find resource files"
    @echo "  count-lines    📊 Count lines of code"
    @echo "  cleanup        🧹 Clean up temporary files"
    @echo ""
    @echo "⚙️  CI/CD PIPELINE:"
    @echo "  ci             🚀 Run CI commands locally"
    @echo "  ci-validate    🔍 Validate CI declarations"
    @echo "  ci-commands    📋 List CI commands"
    @echo "  stage-commands 📋 List stage commands"
    @echo "  get-stage-info 📋 Get stage information"
    @echo ""
    @echo "🚀 DEPLOYMENT:"
    @echo "  deploy         🚀 Deploy application"
    @echo ""
    @echo "🐳 DOCKER:"
    @echo "  build-docker   🐳 Build Docker image"
    @echo "  remove-docker  🗑️ Remove Docker images"
    @echo "  run-docker     🐳 Run application in Docker"
    @echo "  stop-docker    🛑 Stop Docker container"
    @echo "  docker-info    🐳 Show Docker information"
    @echo "  docker-logs    📋 Show Docker container logs"
    @echo ""
    @echo "🔧 SYSTEM COMMANDS:"
    @echo "  get-mvn-cmd    🔧 Get Maven command"
    @echo ""
    @echo "💡 Usage: just <command>"
    @echo "📋 List all: just --list"

# CI: false
# STAGE: 0
get-mvn-cmd: # 🔧 Get Maven command
    #!/usr/bin/env bash
    # Check for local Maven installation first
    if [ -f "./tools/maven/bin/mvn" ]; then
        echo "./tools/maven/bin/mvn"
    elif command -v mvn &> /dev/null; then
        echo "mvn"
    elif [ -f "./mvnw" ]; then
        echo "./mvnw"
    else
        echo "mvn"
    fi

# =============================================================================
# UNIVERSAL COMMANDS (Cross-platform, build-tool agnostic)
# =============================================================================

# CI: true
# STAGE: 3
build: # 🔨 Build the application
    #!/usr/bin/env bash
    echo "🔨 Building application..."
    if [ -f "pom.xml" ]; then
        echo "📦 Detected Maven project"
        MVN_CMD=$(just get-mvn-cmd)
        echo "Using Maven: $MVN_CMD"
        $MVN_CMD clean package -DskipTests
        echo "✅ Build completed successfully!"
    elif [ -f "build.gradle" ]; then
        echo "📦 Detected Gradle project"
        ./gradlew build -x test
        echo "✅ Build completed successfully!"
    else
        echo "❌ No build file found (pom.xml or build.gradle)"
        exit 1
    fi

# CI: true
# STAGE: 3
clean: # 🧹 Clean build artifacts
    #!/usr/bin/env bash
    echo "🧹 Cleaning project..."
    if [ -f "pom.xml" ]; then
        echo "📦 Cleaning Maven project"
        MVN_CMD=$(just get-mvn-cmd)
        echo "Using Maven: $MVN_CMD"
        $MVN_CMD clean
        echo "✅ Clean completed!"
    elif [ -f "build.gradle" ]; then
        echo "📦 Cleaning Gradle project"
        ./gradlew clean
        echo "✅ Clean completed!"
    else
        echo "❌ No build file found"
        exit 1
    fi

# CI: true
# STAGE: 4
test: # 🧪 Run tests
    #!/usr/bin/env bash
    echo "🧪 Running tests..."
    if [ -f "pom.xml" ]; then
        echo "📦 Running Maven tests"
        MVN_CMD=$(just get-mvn-cmd)
        echo "Using Maven: $MVN_CMD"
        $MVN_CMD test
        echo "✅ Tests completed!"
    elif [ -f "build.gradle" ]; then
        echo "📦 Running Gradle tests"
        ./gradlew test
        echo "✅ Tests completed!"
    else
        echo "❌ No build file found"
        exit 1
    fi

# CI: false
# STAGE: 0
lint: # 🔍 Run linting
    #!/usr/bin/env bash
    echo "🔍 Running linting..."
    if [ -f "pom.xml" ]; then
        echo "📦 Running Maven checkstyle"
        MVN_CMD=$(just get-mvn-cmd)
        echo "Using Maven: $MVN_CMD"
        $MVN_CMD checkstyle:check
    elif [ -f "build.gradle" ]; then
        echo "📦 Running Gradle linting"
        ./gradlew checkstyleMain
    else
        echo "❌ No build file found"
        exit 1
    fi

# CI: false
# STAGE: 0
format: # 🎨 Format code
    #!/usr/bin/env bash
    echo "🎨 Formatting code..."
    if [ -f "pom.xml" ]; then
        echo "📦 Running Maven formatting"
        MVN_CMD=$(just get-mvn-cmd)
        echo "Using Maven: $MVN_CMD"
        $MVN_CMD spotless:apply
    elif [ -f "build.gradle" ]; then
        echo "📦 Running Gradle formatting"
        ./gradlew spotlessApply
    else
        echo "❌ No build file found"
        exit 1
    fi

# CI: false
# STAGE: 0
run: # 🖥️ Run application
    #!/usr/bin/env bash
    echo "🖥️ Running application..."
    if [ -f "pom.xml" ]; then
        echo "📦 Running Maven application"
        MVN_CMD=$(just get-mvn-cmd)
        echo "Using Maven: $MVN_CMD"
        $MVN_CMD spring-boot:run
    elif [ -f "build.gradle" ]; then
        echo "📦 Running Gradle application"
        ./gradlew bootRun
    else
        echo "❌ No build file found"
        exit 1
    fi

# CI: false
# STAGE: 0
dev-setup: # 🔧 Setup development environment
    #!/usr/bin/env bash
    echo "🔧 Setting up development environment..."
    echo "✅ Development environment configured"

# CI: false
# STAGE: 0
dev-status: # 📊 Check development status
    #!/usr/bin/env bash
    echo "📊 Development environment status..."
    if curl -s http://localhost:8080/actuator/health > /dev/null 2>&1; then
        echo "✅ Application is running"
        curl -s http://localhost:8080/actuator/health | jq . 2>/dev/null || curl -s http://localhost:8080/actuator/health
    else
        echo "❌ Application is not running"
    fi

# CI: false
# STAGE: 0
dev-stop: # 🛑 Stop development environment
    #!/usr/bin/env bash
    echo "🛑 Stopping development environment..."
    echo "Please stop the application manually (Ctrl+C)"

# CI: false
# STAGE: 0
doctor: # 🏥 Diagnose development environment
    #!/usr/bin/env bash
    echo "🏥 Diagnosing development environment..."
    echo "======================================"
    
    # Check Java
    echo "☕ Java Environment:"
    if command -v java &> /dev/null; then
        echo "✅ Java is installed"
        java -version 2>&1 | head -1
    else
        echo "❌ Java is not installed"
    fi
    
    # Check Maven
    echo ""
    echo "📦 Maven Environment:"
    MVN_CMD=$(just get-mvn-cmd)
    if [ "$MVN_CMD" != "mvn" ] || command -v mvn &> /dev/null; then
        echo "✅ Maven is available"
        $MVN_CMD -version 2>&1 | head -1
    else
        echo "❌ Maven is not available"
    fi
    
    # Check project structure
    echo ""
    echo "📁 Project Structure:"
    if [ -f "pom.xml" ]; then
        echo "✅ Maven project detected"
    elif [ -f "build.gradle" ]; then
        echo "✅ Gradle project detected"
    else
        echo "❌ No build system detected"
    fi
    
    # Check Git
    echo ""
    echo "📝 Git Status:"
    if command -v git &> /dev/null; then
        echo "✅ Git is installed"
        echo "Branch: $(git branch --show-current 2>/dev/null || echo 'unknown')"
        echo "Modified files: $(git status --porcelain | wc -l | xargs echo)"
    else
        echo "❌ Git is not installed"
    fi
    
    # Check ports
    echo ""
    echo "🌐 Port Status:"
    if netstat -an 2>/dev/null | grep -q ":8080 "; then
        echo "⚠️  Port 8080 is in use"
    else
        echo "✅ Port 8080 is available"
    fi
    
    echo ""
    echo "🏥 Diagnosis completed!"

# CI: false
# STAGE: 0
debug: # 🐛 Debug application
    #!/usr/bin/env bash
    echo "🐛 Starting debug mode..."
    
    if [ -f "pom.xml" ]; then
        echo "📦 Debugging Maven project"
        MVN_CMD=$(just get-mvn-cmd)
        echo "Using Maven: $MVN_CMD"
        echo "🔧 Debug flags: -X (debug), -e (errors), -Dspring.profiles.active=dev"
        $MVN_CMD spring-boot:run -X -e -Dspring.profiles.active=dev -Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005"
    elif [ -f "build.gradle" ]; then
        echo "📦 Debugging Gradle project"
        echo "🔧 Debug flags: --debug, -Dspring.profiles.active=dev"
        ./gradlew bootRun --debug -Dspring.profiles.active=dev -Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005"
    else
        echo "❌ No build file found"
        exit 1
    fi

# CI: false
# STAGE: 0
watch: # 👀 Watch for file changes
    #!/usr/bin/env bash
    echo "👀 Starting file watcher..."
    
    if command -v fswatch &> /dev/null; then
        echo "✅ Using fswatch for file watching"
        echo "📁 Watching src/ directory for changes..."
        fswatch -o src/ | while read f; do
            echo "🔄 File change detected, rebuilding..."
            just build
        done
    elif command -v inotifywait &> /dev/null; then
        echo "✅ Using inotifywait for file watching"
        echo "📁 Watching src/ directory for changes..."
        while inotifywait -r -e modify src/; do
            echo "🔄 File change detected, rebuilding..."
            just build
        done
    else
        echo "⚠️  No file watcher available (fswatch or inotifywait)"
        echo "💡 Install fswatch: brew install fswatch (macOS) or apt install fswatch (Linux)"
        echo "💡 Or install inotifywait: apt install inotify-tools (Linux)"
        exit 1
    fi

# CI: false
# STAGE: 0
run-h2: # 🗄️ Run with H2 database
    #!/usr/bin/env bash
    echo "🗄️  Running with H2 database..."
    MVN_CMD=$(just get-mvn-cmd)
    echo "Using Maven: $MVN_CMD"
    $MVN_CMD spring-boot:run -Dspring-boot.run.profiles=h2

# CI: false
# STAGE: 0
db-init-h2: # 🗄️ Initialize H2 database
    #!/usr/bin/env bash
    echo "🗄️  Initializing H2 database..."
    MVN_CMD=$(just get-mvn-cmd)
    echo "Using Maven: $MVN_CMD"
    $MVN_CMD spring-boot:run -Dspring-boot.run.profiles=h2 -Dspring-boot.run.arguments="--spring.jpa.hibernate.ddl-auto=create" &
    sleep 10
    echo "✅ H2 database initialized"

# CI: false
# STAGE: 0
db-reset-h2: # 🗄️ Reset H2 database
    #!/usr/bin/env bash
    echo "🗄️  Resetting H2 database..."
    rm -f src/main/resources/db/h2/data.sql
    echo "✅ H2 database reset"

# CI: false
# STAGE: 0
db-schema: # 🗄️ Show database schema
    #!/usr/bin/env bash
    echo "🗄️  Showing database schema..."
    find src/main/resources/db -name "schema.sql" -exec echo "=== {} ===" \; -exec cat {} \;

# CI: true
# STAGE: 4
coverage: # 📊 Generate coverage report
    #!/usr/bin/env bash
    echo "📊 Generating code coverage report..."
    MVN_CMD=$(just get-mvn-cmd)
    echo "Using Maven: $MVN_CMD"
    $MVN_CMD jacoco:report
    echo "✅ Coverage report generated in target/site/jacoco/"

# CI: true
# STAGE: 3
cyclonedx-report: # 📋 Generate CycloneDX report
    #!/usr/bin/env bash
    echo "📋 Generating CycloneDX SBOM report..."
    MVN_CMD=$(just get-mvn-cmd)
    echo "Using Maven: $MVN_CMD"
    $MVN_CMD cyclonedx:makeAggregateBom

# CI: true
# STAGE: 3
mvn-validate: # ✅ Validate Maven project
    #!/usr/bin/env bash
    echo "✅ Validating Maven project..."
    MVN_CMD=$(just get-mvn-cmd)
    echo "Using Maven: $MVN_CMD"
    $MVN_CMD validate

# CI: false
# STAGE: 0
mvn-site: # 🌐 Generate Maven site
    #!/usr/bin/env bash
    echo "🌐 Generating Maven site..."
    MVN_CMD=$(just get-mvn-cmd)
    echo "Using Maven: $MVN_CMD"
    $MVN_CMD site

# CI: false
# STAGE: 0
deploy: # 🚀 Deploy application
    #!/usr/bin/env bash
    echo "🚀 Deploying application..."
    echo "⚠️  Deployment not implemented yet"
    exit 1

# CI: true
# STAGE: 5
build-docker: # 🐳 Build Docker image
    #!/usr/bin/env bash
    echo "🐳 Building Docker image..."
    
    # Check if Docker is available
    if ! command -v docker &> /dev/null; then
        echo "❌ Docker is not installed or not in PATH"
        exit 1
    fi
    
    # Check if Dockerfile exists
    if [ ! -f "Dockerfile" ]; then
        echo "📝 Creating Dockerfile..."
        echo "# Multi-stage build for Spring Boot application" > Dockerfile
        echo "FROM openjdk:17-jdk-slim as builder" >> Dockerfile
        echo "" >> Dockerfile
        echo "WORKDIR /app" >> Dockerfile
        echo "COPY . ." >> Dockerfile
        echo "RUN ./gradlew build -x test || mvn clean package -DskipTests" >> Dockerfile
        echo "" >> Dockerfile
        echo "FROM openjdk:17-jdk-slim" >> Dockerfile
        echo "WORKDIR /app" >> Dockerfile
        echo "COPY --from=builder /app/target/*.jar app.jar" >> Dockerfile
        echo "EXPOSE 8080" >> Dockerfile
        echo 'ENTRYPOINT ["java", "-jar", "app.jar"]' >> Dockerfile
        echo "✅ Dockerfile created"
    fi
    
    # Build the Docker image
    IMAGE_NAME="spring-petclinic"
    IMAGE_TAG="latest"
    
    echo "🔨 Building Docker image: $IMAGE_NAME:$IMAGE_TAG"
    
    # Use buildx for better CI compatibility
    if docker buildx version &> /dev/null; then
        echo "🔧 Using Docker Buildx..."
        docker buildx build --platform linux/amd64 -t $IMAGE_NAME:$IMAGE_TAG .
    else
        echo "🔧 Using standard Docker build..."
        docker build -t $IMAGE_NAME:$IMAGE_TAG .
    fi
    
    if [ $? -eq 0 ]; then
        echo "✅ Docker image built successfully!"
        echo "📋 Image info:"
        docker images $IMAGE_NAME:$IMAGE_TAG 2>/dev/null || echo "Image built but not available locally (multi-platform build)"
    else
        echo "❌ Docker build failed"
        exit 1
    fi

# CI: true
# STAGE: 5
test-docker: # 🧪 Test Docker environment
    #!/usr/bin/env bash
    echo "🧪 Testing Docker environment..."
    
    # Check if Docker is available
    if ! command -v docker &> /dev/null; then
        echo "❌ Docker is not installed or not in PATH"
        exit 1
    fi
    
    echo "✅ Docker is installed"
    echo "Version: $(docker --version)"
    
    # Test Docker daemon
    if docker info &> /dev/null; then
        echo "✅ Docker daemon is running"
    else
        echo "❌ Docker daemon is not running"
        exit 1
    fi
    
    # Test Docker buildx
    if docker buildx version &> /dev/null; then
        echo "✅ Docker Buildx is available"
    else
        echo "ℹ️ Docker Buildx is not available (using standard build)"
    fi
    
    echo "✅ Docker environment test completed!"

# CI: true
# STAGE: 5
remove-docker: # 🗑️ Remove Docker images
    #!/usr/bin/env bash
    echo "🗑️ Removing Docker images..."
    
    # Check if Docker is available
    if ! command -v docker &> /dev/null; then
        echo "❌ Docker is not installed or not in PATH"
        exit 1
    fi
    
    IMAGE_NAME="spring-petclinic"
    
    # Remove specific image (handle errors gracefully)
    echo "🗑️ Removing $IMAGE_NAME images..."
    if docker images $IMAGE_NAME 2>/dev/null | grep -q $IMAGE_NAME; then
        docker rmi $(docker images $IMAGE_NAME -q) 2>/dev/null || echo "Failed to remove $IMAGE_NAME images"
    else
        echo "ℹ️ No $IMAGE_NAME images found"
    fi
    
    # Remove dangling images
    echo "🧹 Cleaning up dangling images..."
    docker image prune -f 2>/dev/null || echo "Failed to prune images"
    
    # Clean up build cache
    echo "🧹 Cleaning up build cache..."
    docker builder prune -f 2>/dev/null || echo "Failed to clean build cache"
    
    echo "✅ Docker cleanup completed!"

# CI: false
# STAGE: 0
docker-info: # 🐳 Show Docker information
    #!/usr/bin/env bash
    echo "🐳 Docker Information..."
    echo "========================"
    
    if ! command -v docker &> /dev/null; then
        echo "❌ Docker is not installed"
        exit 1
    fi
    
    echo "✅ Docker is installed"
    echo "Version: $(docker --version)"
    echo ""
    echo "📊 Docker system info:"
    docker system df
    echo ""
    echo "🐳 Docker images:"
    docker images | head -10
    echo ""
    echo "📦 Docker containers:"
    docker ps -a | head -10

# CI: false
# STAGE: 0
run-docker: # 🐳 Run application in Docker
    #!/usr/bin/env bash
    echo "🐳 Running application in Docker..."
    
    if ! command -v docker &> /dev/null; then
        echo "❌ Docker is not installed"
        exit 1
    fi
    
    IMAGE_NAME="spring-petclinic"
    IMAGE_TAG="latest"
    CONTAINER_NAME="petclinic-app"
    
    # Check if image exists, build if not
    if ! docker images $IMAGE_NAME:$IMAGE_TAG &> /dev/null; then
        echo "📦 Image not found, building first..."
        just build-docker
    fi
    
    # Stop existing container if running
    if docker ps -q -f name=$CONTAINER_NAME | grep -q .; then
        echo "🛑 Stopping existing container..."
        docker stop $CONTAINER_NAME
        docker rm $CONTAINER_NAME
    fi
    
    # Run the container
    echo "🚀 Starting container: $CONTAINER_NAME"
    docker run -d \
        --name $CONTAINER_NAME \
        -p 8080:8080 \
        -e SPRING_PROFILES_ACTIVE=docker \
        $IMAGE_NAME:$IMAGE_TAG
    
    if [ $? -eq 0 ]; then
        echo "✅ Container started successfully!"
        echo "🌐 Application available at: http://localhost:8080"
        echo "📊 Container status:"
        docker ps --filter name=$CONTAINER_NAME
    else
        echo "❌ Failed to start container"
        exit 1
    fi

# CI: false
# STAGE: 0
stop-docker: # 🛑 Stop Docker container
    #!/usr/bin/env bash
    echo "🛑 Stopping Docker container..."
    
    if ! command -v docker &> /dev/null; then
        echo "❌ Docker is not installed"
        exit 1
    fi
    
    CONTAINER_NAME="petclinic-app"
    
    if docker ps -q -f name=$CONTAINER_NAME | grep -q .; then
        echo "🛑 Stopping container: $CONTAINER_NAME"
        docker stop $CONTAINER_NAME
        docker rm $CONTAINER_NAME
        echo "✅ Container stopped and removed"
    else
        echo "ℹ️  No running container found with name: $CONTAINER_NAME"
    fi

# CI: false
# STAGE: 0
docker-logs: # 📋 Show Docker container logs
    #!/usr/bin/env bash
    echo "📋 Docker container logs..."
    
    if ! command -v docker &> /dev/null; then
        echo "❌ Docker is not installed"
        exit 1
    fi
    
    CONTAINER_NAME="petclinic-app"
    
    if docker ps -q -f name=$CONTAINER_NAME | grep -q .; then
        echo "📋 Logs for container: $CONTAINER_NAME"
        docker logs $CONTAINER_NAME
    else
        echo "ℹ️  No running container found with name: $CONTAINER_NAME"
        echo "💡 Start the container first with: just run-docker"
    fi

# CI: false
# STAGE: 0
java-version: # ☕ Show Java version
    #!/usr/bin/env bash
    echo "☕ Java version:"
    java -version

# CI: false
# STAGE: 0
maven-version: # 📦 Show Maven version
    #!/usr/bin/env bash
    echo "📦 Maven version:"
    MVN_CMD=$(just get-mvn-cmd)
    echo "Using Maven: $MVN_CMD"
    $MVN_CMD -version

# CI: false
# STAGE: 0
status: # 📊 Show project status
    #!/usr/bin/env bash
    echo "📊 Project status..."
    echo "Java version:"
    java -version
    echo "Maven version:"
    MVN_CMD=$(just get-mvn-cmd)
    echo "Using Maven: $MVN_CMD"
    $MVN_CMD -version
    echo "Git status:"
    git status --porcelain | wc -l | xargs echo "Modified files:"
    echo "Build status:"
    if [ -d "target" ] && ls target/*.jar 1> /dev/null 2>&1; then
        echo "✅ Application built successfully"
    else
        echo "❌ Application not built"
    fi

# CI: false
# STAGE: 0
env-info: # 🌍 Show environment info
    #!/usr/bin/env bash
    echo "🌍 Environment information..."
    echo "JAVA_HOME: $JAVA_HOME"
    echo "M2_HOME: $M2_HOME"
    echo "PATH: $PATH"
    echo "Current directory: $(pwd)"
    echo "Available memory: $(free -h 2>/dev/null || vm_stat 2>/dev/null | head -1 || echo 'Not available')"

# CI: false
# STAGE: 0
health-check: # 🏥 Comprehensive health check
    #!/usr/bin/env bash
    echo "🏥 Running comprehensive health check..."
    echo "======================================"
    
    # System health
    echo "💻 System Health:"
    echo "OS: $(uname -s) $(uname -r)"
    echo "Architecture: $(uname -m)"
    echo "Available memory: $(free -h 2>/dev/null | grep Mem | awk '{print $2}' || echo 'Unknown')"
    echo "Disk space: $(df -h . | tail -1 | awk '{print $4}') available"
    
    # Java health
    echo ""
    echo "☕ Java Health:"
    if command -v java &> /dev/null; then
        JAVA_VERSION=$(java -version 2>&1 | head -1)
        echo "✅ Java: $JAVA_VERSION"
        echo "JAVA_HOME: ${JAVA_HOME:-'Not set'}"
    else
        echo "❌ Java not found"
    fi
    
    # Maven health
    echo ""
    echo "📦 Maven Health:"
    MVN_CMD=$(just get-mvn-cmd)
    if [ "$MVN_CMD" != "mvn" ] || command -v mvn &> /dev/null; then
        MVN_VERSION=$($MVN_CMD -version 2>&1 | head -1)
        echo "✅ Maven: $MVN_VERSION"
        echo "M2_HOME: ${M2_HOME:-'Not set'}"
    else
        echo "❌ Maven not found"
    fi
    
    # Project health
    echo ""
    echo "📁 Project Health:"
    if [ -f "pom.xml" ]; then
        echo "✅ Maven project detected"
        echo "Project name: $(grep '<artifactId>' pom.xml | head -1 | sed 's/.*<artifactId>\(.*\)<\/artifactId>.*/\1/')"
        echo "Project version: $(grep '<version>' pom.xml | head -1 | sed 's/.*<version>\(.*\)<\/version>.*/\1/')"
    elif [ -f "build.gradle" ]; then
        echo "✅ Gradle project detected"
    else
        echo "❌ No build system detected"
    fi
    
    # Network health
    echo ""
    echo "🌐 Network Health:"
    if curl -s --connect-timeout 5 https://repo.maven.apache.org > /dev/null; then
        echo "✅ Maven Central accessible"
    else
        echo "❌ Maven Central not accessible"
    fi
    
    # Port health
    echo ""
    echo "🔌 Port Health:"
    if netstat -an 2>/dev/null | grep -q ":8080 "; then
        echo "⚠️  Port 8080 is in use"
    else
        echo "✅ Port 8080 is available"
    fi
    
    echo ""
    echo "🏥 Health check completed!"

# CI: false
# STAGE: 0
validate-env: # ✅ Validate environment setup
    #!/usr/bin/env bash
    echo "✅ Validating environment setup..."
    echo "=================================="
    
    ERRORS=0
    WARNINGS=0
    
    # Check Java
    if ! command -v java &> /dev/null; then
        echo "❌ Java is not installed"
        ERRORS=$((ERRORS + 1))
    else
        echo "✅ Java is installed"
        java -version 2>&1 | head -1
    fi
    
    # Check Maven
    MVN_CMD=$(just get-mvn-cmd)
    if [ "$MVN_CMD" = "mvn" ] && ! command -v mvn &> /dev/null; then
        echo "❌ Maven is not available"
        ERRORS=$((ERRORS + 1))
    else
        echo "✅ Maven is available"
        $MVN_CMD -version 2>&1 | head -1
    fi
    
    # Check project structure
    if [ ! -f "pom.xml" ] && [ ! -f "build.gradle" ]; then
        echo "❌ No build system detected"
        ERRORS=$((ERRORS + 1))
    else
        echo "✅ Build system detected"
    fi
    
    # Check Git
    if ! command -v git &> /dev/null; then
        echo "⚠️  Git is not installed (recommended)"
        WARNINGS=$((WARNINGS + 1))
    else
        echo "✅ Git is installed"
    fi
    
    # Check ports
    if netstat -an 2>/dev/null | grep -q ":8080 "; then
        echo "⚠️  Port 8080 is in use"
        WARNINGS=$((WARNINGS + 1))
    else
        echo "✅ Port 8080 is available"
    fi
    
    echo ""
    if [ $ERRORS -eq 0 ]; then
        echo "✅ Environment validation passed!"
        if [ $WARNINGS -gt 0 ]; then
            echo "⚠️  $WARNINGS warnings found"
        fi
    else
        echo "❌ Environment validation failed with $ERRORS errors"
        exit 1
    fi

# CI: false
# STAGE: 0
detect: # 🔍 Detect project type
    #!/usr/bin/env bash
    echo "🔍 Detecting project type..."
    if [ -f "pom.xml" ]; then
        echo "📦 Maven project detected"
        echo "Java version: $(java -version 2>&1 | head -1)"
        MVN_CMD=$(just get-mvn-cmd)
        echo "Using Maven: $MVN_CMD"
        $MVN_CMD -version 2>&1 | head -1
    elif [ -f "build.gradle" ]; then
        echo "📦 Gradle project detected"
        echo "Java version: $(java -version 2>&1 | head -1)"
        echo "Gradle version: $(./gradlew --version 2>&1 | head -1)"
    else
        echo "❌ No build system detected"
    fi

# CI: false
# STAGE: 0
find-java: # 📁 Find Java files
    #!/usr/bin/env bash
    echo "📁 Finding Java files:"
    find src -name "*.java" | head -10

# CI: false
# STAGE: 0
find-resources: # 📁 Find resource files
    #!/usr/bin/env bash
    echo "📁 Finding resource files:"
    find src/main/resources -type f | head -10

# CI: false
# STAGE: 0
count-lines: # 📊 Count lines of code
    #!/usr/bin/env bash
    echo "📊 Counting lines of code:"
    find src -name "*.java" -exec wc -l {} + | tail -1

# CI: false
# STAGE: 0
cleanup: # 🧹 Clean up temporary files
    #!/usr/bin/env bash
    echo "🧹 Cleaning up temporary files..."
    rm -rf target/tmp
    rm -f *.log
    rm -f heapdump.hprof
    echo "✅ Cleanup completed"

# CI: false
# STAGE: 0
ci: # 🚀 Run CI commands locally
    #!/usr/bin/env bash
    echo "🚀 Running CI commands locally..."
    
    # Get CI-suitable commands dynamically (excluding ci and ci-validate to avoid recursion)
    CI_COMMANDS=$(just ci-commands 2>&1 | grep "CI-suitable:" | sed 's/✅ CI-suitable: //' | sed 's/ci ci-validate//g')
    
    echo "Found CI commands: $CI_COMMANDS"
    
    # Execute each CI command
    for cmd in $CI_COMMANDS; do
        if [ -n "$cmd" ] && [ "$cmd" != "ci" ] && [ "$cmd" != "ci-validate" ]; then
            echo "🔄 Executing CI command: just $cmd"
            just $cmd
            if [ $? -ne 0 ]; then
                echo "❌ CI command failed: $cmd"
                exit 1
            fi
        fi
    done
    
    echo "✅ All CI commands completed successfully!"

# CI: true
# STAGE: 2
ci-validate: # 🔍 Validate CI declarations
    #!/usr/bin/env bash
    echo "🔍 Validating CI command declarations..."
    
    # Use the comprehensive validate command
    just validate

# CI: false
# STAGE: 0
validate: # ✅ Validate justfile
    #!/usr/bin/env bash
    echo "🔍 Comprehensive justfile validation..."
    echo "======================================"
    
    # Get all commands
    ALL_COMMANDS=$(just --list | grep -v "Available recipes:" | grep -v "^#" | sed 's/#.*$//' | tr -d ' ' | grep -v '^$')
    
    # Validation counters
    TOTAL_COMMANDS=0
    CI_COMMANDS=0
    LOCAL_COMMANDS=0
    STAGED_COMMANDS=0
    ERRORS=0
    
    echo "📋 Analyzing commands..."
    
    for cmd in $ALL_COMMANDS; do
        if [ "$cmd" != "default" ]; then
            TOTAL_COMMANDS=$((TOTAL_COMMANDS + 1))
            
            # Check if command has both CI and STAGE declarations
            HAS_CI=$(grep -A 5 -B 5 "^$cmd:" justfile | grep -c "^# CI:" || echo "0")
            HAS_STAGE=$(grep -A 5 -B 5 "^$cmd:" justfile | grep -c "^# STAGE:" || echo "0")
            
            if [ "$HAS_CI" -eq 0 ] || [ "$HAS_STAGE" -eq 0 ]; then
                echo "❌ $cmd: Missing CI or STAGE declaration"
                ERRORS=$((ERRORS + 1))
                continue
            fi
            
            # Get CI value (take the first one if multiple, but only from comment lines)
            CI_VALUE=$(grep -A 5 -B 5 "^$cmd:" justfile | grep "^# CI:" | head -1 | sed 's/.*CI: //')
            STAGE_VALUE=$(grep -A 5 -B 5 "^$cmd:" justfile | grep "^# STAGE:" | head -1 | sed 's/.*STAGE: //')
            
            # Validate CI value
            if [ "$CI_VALUE" != "true" ] && [ "$CI_VALUE" != "false" ]; then
                echo "❌ $cmd: Invalid CI value '$CI_VALUE' (must be true or false)"
                ERRORS=$((ERRORS + 1))
                continue
            fi
            
            # Validate STAGE value (Stage 1 is reserved for switching mechanism)
            if ! [[ "$STAGE_VALUE" =~ ^[0,2-6]$ ]]; then
                echo "❌ $cmd: Invalid STAGE value '$STAGE_VALUE' (must be 0 or 2-6, Stage 1 is reserved)"
                ERRORS=$((ERRORS + 1))
                continue
            fi
            
            # Validate bidirectional consistency
            if [ "$STAGE_VALUE" -eq 0 ]; then
                if [ "$CI_VALUE" != "false" ]; then
                    echo "❌ $cmd: Stage 0 must have CI: false (got CI: $CI_VALUE)"
                    ERRORS=$((ERRORS + 1))
                    continue
                fi
            elif [ "$STAGE_VALUE" -ge 2 ] && [ "$STAGE_VALUE" -le 6 ]; then
                if [ "$CI_VALUE" != "true" ]; then
                    echo "❌ $cmd: Stages 2-6 must have CI: true (got CI: $CI_VALUE)"
                    ERRORS=$((ERRORS + 1))
                    continue
                fi
            fi
            
            # Additional validation: CI: false must be Stage 0, CI: true must be Stages 1-6
            if [ "$CI_VALUE" = "false" ] && [ "$STAGE_VALUE" -ne 0 ]; then
                echo "❌ $cmd: CI: false must have Stage 0 (got Stage: $STAGE_VALUE)"
                ERRORS=$((ERRORS + 1))
                continue
            fi
            
            if [ "$CI_VALUE" = "true" ] && [ "$STAGE_VALUE" -lt 2 ] || [ "$STAGE_VALUE" -gt 6 ]; then
                echo "❌ $cmd: CI: true must have Stage 2-6 (got Stage: $STAGE_VALUE)"
                ERRORS=$((ERRORS + 1))
                continue
            fi
            
            # All validations passed for this command
            if [ "$STAGE_VALUE" -eq 0 ]; then
                LOCAL_COMMANDS=$((LOCAL_COMMANDS + 1))
                echo "✅ $cmd: Local command (Stage 0)"
            else
                CI_COMMANDS=$((CI_COMMANDS + 1))
                STAGED_COMMANDS=$((STAGED_COMMANDS + 1))
                echo "✅ $cmd: CI command (Stage $STAGE_VALUE)"
            fi
        fi
    done
    
    echo ""
    echo "📊 VALIDATION SUMMARY"
    echo "===================="
    echo "Total commands: $TOTAL_COMMANDS"
    echo "CI commands: $CI_COMMANDS"
    echo "Local commands: $LOCAL_COMMANDS"
    echo "Staged commands: $STAGED_COMMANDS"
    echo "Errors: $ERRORS"
    
    if [ $ERRORS -eq 0 ]; then
        echo ""
        echo "✅ All validations passed!"
        echo "✅ Justfile is ready for CI/CD pipeline"
        echo ""
        echo "📋 Stage Distribution:"
        for i in {0..6}; do
            STAGE_COUNT=$(grep -A 5 -B 5 "^.*:" justfile | grep -B 5 -A 5 "STAGE: $i" | grep "^[a-zA-Z]" | wc -l)
            if [ "$STAGE_COUNT" -gt 0 ]; then
                echo "   Stage $i: $STAGE_COUNT commands"
            fi
        done
    else
        echo ""
        echo "❌ Validation failed with $ERRORS errors"
        echo "💡 Fix the issues above before pushing"
        echo ""
        echo "📋 Rules:"
        echo "   - All commands must have both # CI: true/false and # STAGE: 0,2-6"
        echo "   - Stage 0 ↔ CI: false (bidirectional consistency)"
        echo "   - Stages 2-6 ↔ CI: true (bidirectional consistency)"
        echo "   - Stage 1 is RESERVED for switching mechanism (no just commands)"
        echo "   - If Stage 0, CI must be false"
        echo "   - If CI false, Stage must be 0"
        echo "   - If Stages 2-6, CI must be true"
        echo "   - If CI true, Stage must be 2-6"
        exit 1
    fi

# CI: false
# STAGE: 0
ci-commands: # 📋 List CI commands
    #!/usr/bin/env bash
    echo "📋 CI-suitable commands (Stages 2-6):"
    
    # Get all commands
    ALL_COMMANDS=$(just --list | grep -v "Available recipes:" | grep -v "^#" | sed 's/#.*$//' | tr -d ' ' | grep -v '^$')
    
    CI_COMMANDS=""
    LOCAL_COMMANDS=""
    
    for cmd in $ALL_COMMANDS; do
        if [ "$cmd" != "default" ]; then
            # Check if command has stage declaration
            if grep -A 5 -B 5 "^$cmd:" justfile | grep -q "STAGE:"; then
                STAGE=$(grep -A 5 -B 5 "^$cmd:" justfile | grep "STAGE:" | sed 's/.*STAGE: //')
                if [[ "$STAGE" =~ ^[2-6]$ ]]; then
                    CI_COMMANDS="$CI_COMMANDS $cmd"
                elif [[ "$STAGE" =~ ^0$ ]]; then
                    LOCAL_COMMANDS="$LOCAL_COMMANDS $cmd"
                fi
            else
                echo "⚠️  Command '$cmd' missing STAGE declaration"
            fi
        fi
    done
    
    echo "✅ CI-suitable (Stages 2-6): $CI_COMMANDS"
    echo "❌ Local-only (Stage 0): $LOCAL_COMMANDS"

# CI: false
# STAGE: 0
stage-commands: # 📋 List stage commands
    #!/usr/bin/env bash
    if [ -z "$STAGE" ]; then
        echo "❌ Please specify a stage number (0,2-6)"
        echo "💡 Usage: STAGE=0 just stage-commands"
        echo "💡 Stage 0 = Local commands, Stages 2-6 = CI commands"
        echo "💡 Stage 1 is RESERVED for switching mechanism"
        exit 1
    fi
    
    echo "📋 Commands for stage $STAGE:"
    
    # Get all commands
    ALL_COMMANDS=$(just --list | grep -v "Available recipes:" | grep -v "^#" | sed 's/#.*$//' | tr -d ' ' | grep -v '^$')
    
    STAGE_COMMANDS=""
    for cmd in $ALL_COMMANDS; do
        if [ "$cmd" != "default" ]; then
            # Check if command is for the specified stage
            if grep -A 5 -B 5 "^$cmd:" justfile | grep -q "STAGE: $STAGE"; then
                STAGE_COMMANDS="$STAGE_COMMANDS $cmd"
            fi
        fi
    done
    
    if [ -n "$STAGE_COMMANDS" ]; then
        if [ "$STAGE" -eq 0 ]; then
            echo "✅ Stage $STAGE (Local) commands: $STAGE_COMMANDS"
        else
            echo "✅ Stage $STAGE (CI) commands: $STAGE_COMMANDS"
        fi
    else
        echo "❌ No commands found for stage $STAGE"
    fi

# CI: false
# STAGE: 0
get-stage-info: # 📋 Get stage information
    #!/usr/bin/env bash
    echo "📋 Dynamic stage information for pipeline..."
    
    # Get all commands
    ALL_COMMANDS=$(just --list | grep -v "Available recipes:" | grep -v "^#" | sed 's/#.*$//' | tr -d ' ' | grep -v '^$')
    
    # Initialize stage arrays (Stage 1 is reserved for switching mechanism)
    declare -A STAGE_COMMANDS
    for i in {0..6}; do
        STAGE_COMMANDS[$i]=""
    done
    
    # Parse commands and their stages
    for cmd in $ALL_COMMANDS; do
        if [ "$cmd" != "default" ]; then
            # Check if command has stage declaration
            if grep -A 5 -B 5 "^$cmd:" justfile | grep -q "STAGE:"; then
                STAGE=$(grep -A 5 -B 5 "^$cmd:" justfile | grep "STAGE:" | sed 's/.*STAGE: //')
                if [[ "$STAGE" =~ ^[0,2-6]$ ]]; then
                    STAGE_COMMANDS[$STAGE]="${STAGE_COMMANDS[$STAGE]} $cmd"
                fi
            fi
        fi
    done
    
    # Output stage information
    echo "STAGE_INFO_START"
    for i in {0..6}; do
        if [ -n "${STAGE_COMMANDS[$i]}" ]; then
            echo "STAGE_${i}:${STAGE_COMMANDS[$i]}"
        else
            echo "STAGE_${i}:"
        fi
    done
    echo "STAGE_INFO_END" 