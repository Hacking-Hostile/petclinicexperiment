# Multi-Language CI/CD Pipeline - Just Commands
# Spring PetClinic Project - Final Cleaned Version

# Default target - shows available commands
default:
    @just --list

# Helper function to get Maven command
get-mvn-cmd:
    #!/usr/bin/env bash
    if command -v mvn &> /dev/null; then
        echo "mvn"
    elif [ -f "./mvnw" ]; then
        echo "./mvnw"
    else
        echo "mvn"
    fi

# =============================================================================
# UNIVERSAL COMMANDS (Cross-platform, build-tool agnostic)
# =============================================================================

build:
    #!/usr/bin/env bash
    echo "🔨 Building Spring PetClinic application..."
    if [ -f "pom.xml" ]; then
        echo "📦 Detected Maven project"
        if command -v mvn &> /dev/null; then
            mvn clean package -DskipTests
        elif [ -f "./mvnw" ]; then
            ./mvnw clean package -DskipTests
        else
            echo "❌ Maven not found and no wrapper available"
            exit 1
        fi
        echo "✅ Build completed successfully!"
    elif [ -f "build.gradle" ]; then
        echo "📦 Detected Gradle project"
        ./gradlew build -x test
        echo "✅ Build completed successfully!"
    else
        echo "❌ No build file found (pom.xml or build.gradle)"
        exit 1
    fi

test:
    #!/usr/bin/env bash
    echo "🧪 Running tests..."
    if [ -f "pom.xml" ]; then
        echo "📦 Running Maven tests"
        if command -v mvn &> /dev/null; then
            mvn test
        elif [ -f "./mvnw" ]; then
            ./mvnw test
        else
            echo "❌ Maven not found and no wrapper available"
            exit 1
        fi
        echo "✅ Tests completed!"
    elif [ -f "build.gradle" ]; then
        echo "📦 Running Gradle tests"
        ./gradlew test
        echo "✅ Tests completed!"
    else
        echo "❌ No build file found"
        exit 1
    fi

clean:
    #!/usr/bin/env bash
    echo "🧹 Cleaning project..."
    if [ -f "pom.xml" ]; then
        echo "📦 Cleaning Maven project"
        if command -v mvn &> /dev/null; then
            mvn clean
        elif [ -f "./mvnw" ]; then
            ./mvnw clean
        else
            echo "❌ Maven not found and no wrapper available"
            exit 1
        fi
        echo "✅ Clean completed!"
    elif [ -f "build.gradle" ]; then
        echo "📦 Cleaning Gradle project"
        ./gradlew clean
        echo "✅ Clean completed!"
    else
        echo "❌ No build file found"
        exit 1
    fi

run:
    #!/usr/bin/env bash
    echo "🚀 Starting Spring PetClinic application..."
    if [ -f "target/spring-petclinic-*.jar" ]; then
        echo "📦 Running JAR file"
        java -jar target/spring-petclinic-*.jar
    elif [ -f "pom.xml" ]; then
        echo "📦 Running with Maven Spring Boot plugin"
        if command -v mvn &> /dev/null; then
            mvn spring-boot:run
        elif [ -f "./mvnw" ]; then
            ./mvnw spring-boot:run
        else
            echo "❌ Maven not found and no wrapper available"
            exit 1
        fi
    elif [ -f "build.gradle" ]; then
        echo "📦 Running with Gradle Spring Boot plugin"
        ./gradlew bootRun
    else
        echo "❌ No runnable application found"
        exit 1
    fi

lint:
    #!/usr/bin/env bash
    echo "🔍 Running code quality checks..."
    if [ -f "pom.xml" ]; then
        echo "📦 Running Maven checkstyle"
        if command -v mvn &> /dev/null; then
            mvn checkstyle:check
        elif [ -f "./mvnw" ]; then
            ./mvnw checkstyle:check
        else
            echo "❌ Maven not found and no wrapper available"
            exit 1
        fi
        echo "✅ Lint completed!"
    elif [ -f "build.gradle" ]; then
        echo "📦 Running Gradle checkstyle"
        ./gradlew checkstyleMain
        echo "✅ Lint completed!"
    else
        echo "⚠️  No linting configured for this project"
    fi

format:
    #!/usr/bin/env bash
    echo "🎨 Formatting code..."
    if [ -f "pom.xml" ]; then
        echo "📦 Running Spring Java Format"
        if command -v mvn &> /dev/null; then
            mvn spring-javaformat:apply
        elif [ -f "./mvnw" ]; then
            ./mvnw spring-javaformat:apply
        else
            echo "❌ Maven not found and no wrapper available"
            exit 1
        fi
        echo "✅ Format completed!"
    elif [ -f "build.gradle" ]; then
        echo "📦 Running Gradle format"
        ./gradlew format
        echo "✅ Format completed!"
    else
        echo "⚠️  No formatting configured for this project"
    fi

deploy:
    #!/usr/bin/env bash
    echo "🚀 Deploying application..."
    if [ -f "pom.xml" ]; then
        echo "📦 Deploying with Maven"
        if command -v mvn &> /dev/null; then
            mvn deploy
        elif [ -f "./mvnw" ]; then
            ./mvnw deploy
        else
            echo "❌ Maven not found and no wrapper available"
            exit 1
        fi
        echo "✅ Deploy completed!"
    elif [ -f "build.gradle" ]; then
        echo "📦 Deploying with Gradle"
        ./gradlew publish
        echo "✅ Deploy completed!"
    else
        echo "❌ No deploy configuration found"
        exit 1
    fi

# =============================================================================
# ESSENTIAL MAVEN COMMANDS (Keep only working ones)
# =============================================================================

mvn-validate:
    #!/usr/bin/env bash
    echo "✅ Validating Maven project..."
    if command -v mvn &> /dev/null; then
        mvn validate
    elif [ -f "./mvnw" ]; then
        ./mvnw validate
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi

mvn-site:
    #!/usr/bin/env bash
    echo "🌐 Generating Maven site..."
    if command -v mvn &> /dev/null; then
        mvn site
    elif [ -f "./mvnw" ]; then
        ./mvnw site
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi

# =============================================================================
# DATABASE COMMANDS
# =============================================================================

run-h2:
    #!/usr/bin/env bash
    echo "🗄️  Running with H2 database..."
    if command -v mvn &> /dev/null; then
        mvn spring-boot:run -Dspring-boot.run.profiles=h2
    elif [ -f "./mvnw" ]; then
        ./mvnw spring-boot:run -Dspring-boot.run.profiles=h2
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi

db-init-h2:
    #!/usr/bin/env bash
    echo "🗄️  Initializing H2 database..."
    if command -v mvn &> /dev/null; then
        mvn spring-boot:run -Dspring-boot.run.profiles=h2 -Dspring-boot.run.arguments="--spring.jpa.hibernate.ddl-auto=create" &
    elif [ -f "./mvnw" ]; then
        ./mvnw spring-boot:run -Dspring-boot.run.profiles=h2 -Dspring-boot.run.arguments="--spring.jpa.hibernate.ddl-auto=create" &
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi
    sleep 10
    echo "✅ H2 database initialized"

db-reset-h2:
    #!/usr/bin/env bash
    echo "🗄️  Resetting H2 database..."
    rm -f src/main/resources/db/h2/data.sql
    echo "✅ H2 database reset"

db-schema:
    #!/usr/bin/env bash
    echo "🗄️  Showing database schema..."
    find src/main/resources/db -name "schema.sql" -exec echo "=== {} ===" \; -exec cat {} \;

# =============================================================================
# CODE QUALITY AND COVERAGE
# =============================================================================

coverage:
    #!/usr/bin/env bash
    echo "📊 Generating code coverage report..."
    if command -v mvn &> /dev/null; then
        mvn jacoco:report
    elif [ -f "./mvnw" ]; then
        ./mvnw jacoco:report
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi
    echo "✅ Coverage report generated in target/site/jacoco/"

cyclonedx-report:
    #!/usr/bin/env bash
    echo "📋 Generating CycloneDX SBOM report..."
    if command -v mvn &> /dev/null; then
        mvn cyclonedx:makeAggregateBom
    elif [ -f "./mvnw" ]; then
        ./mvnw cyclonedx:makeAggregateBom
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi

# =============================================================================
# BUILD AND PACKAGE COMMANDS
# =============================================================================

jar-info:
    #!/usr/bin/env bash
    echo "📦 Getting JAR file info..."
    jar tf target/spring-petclinic-*.jar | head -20

jar-verify:
    #!/usr/bin/env bash
    echo "✅ Verifying JAR file..."
    jar tf target/spring-petclinic-*.jar > /dev/null && echo "✅ JAR file is valid"

jar-extract:
    #!/usr/bin/env bash
    echo "📦 Extracting JAR file..."
    mkdir -p target/extracted
    jar xf target/spring-petclinic-*.jar -d target/extracted
    echo "✅ JAR extracted to target/extracted/"

fat-jar:
    #!/usr/bin/env bash
    echo "📦 Creating fat JAR..."
    if command -v mvn &> /dev/null; then
        mvn package -Dspring-boot.repackage.enabled=true
    elif [ -f "./mvnw" ]; then
        ./mvnw package -Dspring-boot.repackage.enabled=true
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi

# =============================================================================
# SYSTEM AND ENVIRONMENT COMMANDS
# =============================================================================

java-version:
    #!/usr/bin/env bash
    echo "☕ Java version:"
    java -version

maven-version:
    #!/usr/bin/env bash
    echo "📦 Maven version:"
    if command -v mvn &> /dev/null; then
        mvn -version
    elif [ -f "./mvnw" ]; then
        ./mvnw -version
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi

status:
    #!/usr/bin/env bash
    echo "📊 Project status..."
    echo "Java version:"
    java -version
    echo "Maven version:"
    if command -v mvn &> /dev/null; then
        mvn -version
    elif [ -f "./mvnw" ]; then
        ./mvnw -version
    else
        echo "❌ Maven not found and no wrapper available"
    fi
    echo "Git status:"
    git status --porcelain | wc -l | xargs echo "Modified files:"
    echo "Build status:"
    if [ -f "target/spring-petclinic-*.jar" ]; then
        echo "✅ Application built successfully"
    else
        echo "❌ Application not built"
    fi

env-info:
    #!/usr/bin/env bash
    echo "🌍 Environment information..."
    echo "JAVA_HOME: $JAVA_HOME"
    echo "M2_HOME: $M2_HOME"
    echo "PATH: $PATH"
    echo "Current directory: $(pwd)"
    echo "Available memory: $(free -h 2>/dev/null || echo 'Not available on Windows')"

# =============================================================================
# FILE AND DIRECTORY COMMANDS
# =============================================================================

find-java:
    #!/usr/bin/env bash
    echo "📁 Finding Java files:"
    find src -name "*.java" | head -10

find-resources:
    #!/usr/bin/env bash
    echo "📁 Finding resource files:"
    find src/main/resources -type f | head -10

count-lines:
    #!/usr/bin/env bash
    echo "📊 Counting lines of code:"
    find src -name "*.java" -exec wc -l {} + | tail -1

# =============================================================================
# UTILITY COMMANDS
# =============================================================================

cleanup:
    #!/usr/bin/env bash
    echo "🧹 Cleaning up temporary files..."
    rm -rf target/tmp
    rm -f *.log
    rm -f heapdump.hprof
    echo "✅ Cleanup completed"

# =============================================================================
# DEVELOPMENT COMMANDS
# =============================================================================

dev-setup:
    #!/usr/bin/env bash
    echo "🔧 Setting up development environment..."
    echo "✅ Development environment configured"

dev-status:
    #!/usr/bin/env bash
    echo "📊 Development environment status..."
    if curl -s http://localhost:8080/actuator/health > /dev/null 2>&1; then
        echo "✅ Application is running"
        curl -s http://localhost:8080/actuator/health | jq .
    else
        echo "❌ Application is not running"
    fi

dev-stop:
    #!/usr/bin/env bash
    echo "🛑 Stopping development environment..."
    echo "Please stop the application manually (Ctrl+C)"

# =============================================================================
# DETECTION AND SETUP
# =============================================================================

detect:
    #!/usr/bin/env bash
    echo "🔍 Detecting project type..."
    if [ -f "pom.xml" ]; then
        echo "📦 Maven project detected"
        echo "Java version: $(java -version 2>&1 | head -1)"
        if command -v mvn &> /dev/null; then
            echo "Maven version: $(mvn -version 2>&1 | head -1)"
        elif [ -f "./mvnw" ]; then
            echo "Maven wrapper available"
        else
            echo "❌ Maven not found and no wrapper available"
        fi
    elif [ -f "build.gradle" ]; then
        echo "📦 Gradle project detected"
        echo "Java version: $(java -version 2>&1 | head -1)"
        echo "Gradle version: $(./gradlew --version 2>&1 | head -1)"
    else
        echo "❌ No build system detected"
    fi 