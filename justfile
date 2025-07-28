# Multi-Language CI/CD Pipeline - Just Commands
# Spring PetClinic Project

# Default target - shows available commands
default:
    @just --list

# Universal build command
build:
    #!/usr/bin/env bash
    echo "🔨 Building Spring PetClinic application..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    if [ -f "pom.xml" ]; then
        echo "📦 Detected Maven project"
        "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" clean package -DskipTests
        echo "✅ Build completed successfully!"
    elif [ -f "build.gradle" ]; then
        echo "📦 Detected Gradle project"
        ./gradlew build -x test
        echo "✅ Build completed successfully!"
    else
        echo "❌ No build file found (pom.xml or build.gradle)"
        exit 1
    fi

# Universal test command
test:
    #!/usr/bin/env bash
    echo "🧪 Running tests..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    if [ -f "pom.xml" ]; then
        echo "📦 Running Maven tests"
        "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" test
        echo "✅ Tests completed!"
    elif [ -f "build.gradle" ]; then
        echo "📦 Running Gradle tests"
        ./gradlew test
        echo "✅ Tests completed!"
    else
        echo "❌ No build file found"
        exit 1
    fi

# Universal clean command
clean:
    #!/usr/bin/env bash
    echo "🧹 Cleaning project..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    if [ -f "pom.xml" ]; then
        echo "📦 Cleaning Maven project"
        "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" clean
        echo "✅ Clean completed!"
    elif [ -f "build.gradle" ]; then
        echo "📦 Cleaning Gradle project"
        ./gradlew clean
        echo "✅ Clean completed!"
    else
        echo "❌ No build file found"
        exit 1
    fi

# Universal run command
run:
    #!/usr/bin/env bash
    echo "🚀 Starting Spring PetClinic application..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    if [ -f "target/spring-petclinic-*.jar" ]; then
        echo "📦 Running JAR file"
        "/c/Program Files/Java/jdk-24/bin/java.exe" -jar target/spring-petclinic-*.jar
    elif [ -f "pom.xml" ]; then
        echo "📦 Running with Maven Spring Boot plugin"
        "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" spring-boot:run
    elif [ -f "build.gradle" ]; then
        echo "📦 Running with Gradle Spring Boot plugin"
        ./gradlew bootRun
    else
        echo "❌ No runnable application found"
        exit 1
    fi

# Universal lint command
lint:
    #!/usr/bin/env bash
    echo "🔍 Running code quality checks..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    if [ -f "pom.xml" ]; then
        echo "📦 Running Maven checkstyle"
        "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" checkstyle:check
        echo "✅ Lint completed!"
    elif [ -f "build.gradle" ]; then
        echo "📦 Running Gradle checkstyle"
        ./gradlew checkstyleMain
        echo "✅ Lint completed!"
    else
        echo "⚠️  No linting configured for this project"
    fi

# Universal format command
format:
    #!/usr/bin/env bash
    echo "🎨 Formatting code..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    if [ -f "pom.xml" ]; then
        echo "📦 Running Maven formatter"
        "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" spring-javaformat:apply
        echo "✅ Format completed!"
    elif [ -f "build.gradle" ]; then
        echo "📦 Running Gradle formatter"
        ./gradlew formatMain
        echo "✅ Format completed!"
    else
        echo "⚠️  No formatting configured for this project"
    fi

# Universal deploy command
deploy:
    #!/usr/bin/env bash
    echo "🚀 Deploying application..."
    echo "📦 Building for deployment..."
    just build
    echo "✅ Deployment ready! (Manual deployment required)"
    echo "💡 Use 'just deploy-docker' for Docker deployment"

# Docker deployment
deploy-docker:
    #!/usr/bin/env bash
    echo "🐳 Building Docker image..."
    if [ -f "Dockerfile" ]; then
        docker build -t spring-petclinic .
        echo "✅ Docker image built successfully!"
        echo "💡 Run with: docker run -p 8080:8080 spring-petclinic"
    else
        echo "❌ No Dockerfile found"
        exit 1
    fi

# Language detection
detect:
    #!/usr/bin/env bash
    echo "🔍 Detecting project type..."
    if [ -f "pom.xml" ]; then
        echo "📦 Java/Maven project detected"
        echo "📋 Build tool: Maven"
        echo "🔧 Available commands: mvn clean, mvn test, mvn package"
    elif [ -f "build.gradle" ]; then
        echo "📦 Java/Gradle project detected"
        echo "📋 Build tool: Gradle"
        echo "🔧 Available commands: ./gradlew build, ./gradlew test"
    elif [ -f "package.json" ]; then
        echo "📦 Node.js project detected"
        echo "📋 Build tool: npm/yarn"
    elif [ -f "go.mod" ]; then
        echo "📦 Go project detected"
        echo "📋 Build tool: go"
    else
        echo "❓ Unknown project type"
    fi

# ===== SPRING-SPECIFIC COMMANDS =====

# Spring Boot Actuator endpoints
actuator-health:
    #!/usr/bin/env bash
    echo "🏥 Checking Spring Boot Actuator health..."
    curl -s http://localhost:8080/actuator/health | jq . || echo "❌ Health endpoint not available or jq not installed"

actuator-info:
    #!/usr/bin/env bash
    echo "ℹ️  Getting Spring Boot Actuator info..."
    curl -s http://localhost:8080/actuator/info | jq . || echo "❌ Info endpoint not available or jq not installed"

actuator-metrics:
    #!/usr/bin/env bash
    echo "📊 Getting Spring Boot Actuator metrics..."
    curl -s http://localhost:8080/actuator/metrics | jq . || echo "❌ Metrics endpoint not available or jq not installed"

actuator-env:
    #!/usr/bin/env bash
    echo "🔧 Getting Spring Boot Actuator environment..."
    curl -s http://localhost:8080/actuator/env | jq . || echo "❌ Environment endpoint not available or jq not installed"

# Database profile commands
run-h2:
    #!/usr/bin/env bash
    echo "🗄️  Running with H2 database (default)..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" spring-boot:run -Dspring-boot.run.profiles=h2

run-mysql:
    #!/usr/bin/env bash
    echo "🗄️  Running with MySQL database..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" spring-boot:run -Dspring-boot.run.profiles=mysql

run-postgres:
    #!/usr/bin/env bash
    echo "🗄️  Running with PostgreSQL database..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" spring-boot:run -Dspring-boot.run.profiles=postgres

# Code coverage
coverage:
    #!/usr/bin/env bash
    echo "📊 Running code coverage with JaCoCo..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" clean test jacoco:report
    echo "✅ Coverage report generated at target/site/jacoco/index.html"

# Native image building
native-build:
    #!/usr/bin/env bash
    echo "🏗️  Building native image with GraalVM..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" spring-boot:build-image
    echo "✅ Native image built successfully!"

# Spring Boot DevTools
dev-run:
    #!/usr/bin/env bash
    echo "🛠️  Running in development mode with DevTools..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" spring-boot:run -Dspring-boot.run.jvmArguments="-Dspring.devtools.restart.enabled=true"

# CSS compilation
compile-css:
    #!/usr/bin/env bash
    echo "🎨 Compiling CSS with LibSass..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" compile -Pcss
    echo "✅ CSS compilation completed!"

# Spring Boot validation
validate-format:
    #!/usr/bin/env bash
    echo "✅ Validating Spring Java Format..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" spring-javaformat:validate
    echo "✅ Format validation completed!"

# Spring Boot test with containers
test-containers:
    #!/usr/bin/env bash
    echo "🐳 Running tests with Testcontainers..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" test -Dspring.docker.compose.skip.in-tests=false
    echo "✅ Container tests completed!"

# Spring Boot Docker Compose
docker-compose-up:
    #!/usr/bin/env bash
    echo "🐳 Starting services with Docker Compose..."
    docker-compose up -d
    echo "✅ Services started!"

docker-compose-down:
    #!/usr/bin/env bash
    echo "🐳 Stopping services with Docker Compose..."
    docker-compose down
    echo "✅ Services stopped!"

# Spring Boot application properties
show-props:
    #!/usr/bin/env bash
    echo "📋 Showing Spring Boot application properties..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" spring-boot:run -Dspring-boot.run.arguments="--debug" 2>&1 | grep "DEBUG" | head -20

# Spring Boot dependency tree
deps-tree:
    #!/usr/bin/env bash
    echo "🌳 Showing dependency tree..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" dependency:tree

# Spring Boot application info
app-info:
    #!/usr/bin/env bash
    echo "ℹ️  Getting application information..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" spring-boot:run -Dspring-boot.run.arguments="--info" 2>&1 | grep "INFO" | head -10

# Maven-specific commands
mvn-clean:
    #!/usr/bin/env bash
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" clean

mvn-compile:
    #!/usr/bin/env bash
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" compile

mvn-test:
    #!/usr/bin/env bash
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" test

mvn-package:
    #!/usr/bin/env bash
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" package

mvn-install:
    #!/usr/bin/env bash
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" install

mvn-spring-boot-run:
    #!/usr/bin/env bash
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" spring-boot:run

# Gradle-specific commands (if needed)
gradle-build:
    ./gradlew build

gradle-test:
    ./gradlew test

gradle-clean:
    ./gradlew clean

gradle-bootRun:
    ./gradlew bootRun

# Development helpers
dev-setup:
    #!/usr/bin/env bash
    echo "🛠️  Setting up development environment..."
    echo "📦 Checking Java version..."
    "/c/Program Files/Java/jdk-24/bin/java.exe" -version
    echo "📦 Checking Maven version..."
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" -version
    echo "✅ Development environment ready!"

dev-logs:
    #!/usr/bin/env bash
    echo "📋 Showing recent logs..."
    if [ -f "target/spring-petclinic-*.jar" ]; then
        echo "📦 Application logs:"
        tail -f logs/spring-petclinic.log 2>/dev/null || echo "No log file found"
    else
        echo "❌ No application running"
    fi

# Help command
help:
    @echo "🚀 Spring PetClinic - Multi-Language CI/CD Pipeline"
    @echo ""
    @echo "📋 Universal Commands:"
    @echo "  just build          - Build the application"
    @echo "  just test           - Run tests"
    @echo "  just clean          - Clean build artifacts"
    @echo "  just run            - Run the application"
    @echo "  just lint           - Run code quality checks"
    @echo "  just format         - Format code"
    @echo "  just deploy         - Deploy application"
    @echo ""
    @echo "🌱 Spring-Specific Commands:"
    @echo "  just actuator-health    - Check application health"
    @echo "  just actuator-info      - Get application info"
    @echo "  just actuator-metrics   - Get application metrics"
    @echo "  just actuator-env       - Get environment info"
    @echo "  just run-h2             - Run with H2 database"
    @echo "  just run-mysql          - Run with MySQL database"
    @echo "  just run-postgres       - Run with PostgreSQL database"
    @echo "  just coverage           - Run code coverage"
    @echo "  just native-build       - Build native image"
    @echo "  just dev-run            - Run with DevTools"
    @echo "  just compile-css        - Compile CSS"
    @echo "  just validate-format    - Validate code format"
    @echo "  just test-containers    - Run tests with containers"
    @echo "  just docker-compose-up  - Start Docker services"
    @echo "  just docker-compose-down - Stop Docker services"
    @echo "  just show-props         - Show application properties"
    @echo "  just deps-tree          - Show dependency tree"
    @echo "  just app-info           - Get application info"
    @echo ""
    @echo "📦 Maven Commands:"
    @echo "  just mvn-clean      - Maven clean"
    @echo "  just mvn-compile    - Maven compile"
    @echo "  just mvn-test       - Maven test"
    @echo "  just mvn-package    - Maven package"
    @echo "  just mvn-install    - Maven install"
    @echo "  just mvn-spring-boot-run - Run with Spring Boot"
    @echo ""
    @echo "🔧 Utility Commands:"
    @echo "  just detect         - Detect project type"
    @echo "  just dev-setup      - Setup development environment"
    @echo "  just dev-logs       - Show application logs"
    @echo "  just help           - Show this help" 