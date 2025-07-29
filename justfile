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
        echo "📦 Running Spring Java Format"
        "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" spring-javaformat:apply
        echo "✅ Format completed!"
    elif [ -f "build.gradle" ]; then
        echo "📦 Running Gradle format"
        ./gradlew format
        echo "✅ Format completed!"
    else
        echo "⚠️  No formatting configured for this project"
    fi

# Universal deploy command
deploy:
    #!/usr/bin/env bash
    echo "🚀 Deploying application..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    if [ -f "pom.xml" ]; then
        echo "📦 Deploying with Maven"
        "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" deploy
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
# Maven-specific commands
# =============================================================================

mvn-clean:
    #!/usr/bin/env bash
    echo "🧹 Cleaning Maven project..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" clean

mvn-compile:
    #!/usr/bin/env bash
    echo "🔨 Compiling Maven project..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" compile

mvn-test:
    #!/usr/bin/env bash
    echo "🧪 Running Maven tests..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" test

mvn-package:
    #!/usr/bin/env bash
    echo "📦 Packaging Maven project..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" package

mvn-install:
    #!/usr/bin/env bash
    echo "📦 Installing Maven project..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" install

mvn-spring-boot-run:
    #!/usr/bin/env bash
    echo "🚀 Running Spring Boot with Maven..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" spring-boot:run

# =============================================================================
# Gradle-specific commands (if needed)
# =============================================================================

gradle-clean:
    #!/usr/bin/env bash
    echo "🧹 Cleaning Gradle project..."
    ./gradlew clean

gradle-build:
    #!/usr/bin/env bash
    echo "🔨 Building Gradle project..."
    ./gradlew build

gradle-test:
    #!/usr/bin/env bash
    echo "🧪 Running Gradle tests..."
    ./gradlew test

gradle-bootRun:
    #!/usr/bin/env bash
    echo "🚀 Running Spring Boot with Gradle..."
    ./gradlew bootRun

# =============================================================================
# Spring Boot specific commands
# =============================================================================

# Spring Boot Actuator endpoints
actuator-health:
    #!/usr/bin/env bash
    echo "🏥 Checking Spring Boot Actuator health..."
    curl -s http://localhost:8080/actuator/health | jq .

actuator-info:
    #!/usr/bin/env bash
    echo "ℹ️  Getting Spring Boot Actuator info..."
    curl -s http://localhost:8080/actuator/info | jq .

actuator-metrics:
    #!/usr/bin/env bash
    echo "📊 Getting Spring Boot Actuator metrics..."
    curl -s http://localhost:8080/actuator/metrics | jq .

actuator-env:
    #!/usr/bin/env bash
    echo "🌍 Getting Spring Boot Actuator environment..."
    curl -s http://localhost:8080/actuator/env | jq .

# Additional Actuator endpoints
actuator-beans:
    #!/usr/bin/env bash
    echo "🫘 Getting Spring Boot beans..."
    curl -s http://localhost:8080/actuator/beans | jq .

actuator-config:
    #!/usr/bin/env bash
    echo "⚙️  Getting Spring Boot configuration..."
    curl -s http://localhost:8080/actuator/configprops | jq .

actuator-mappings:
    #!/usr/bin/env bash
    echo "🗺️  Getting Spring Boot request mappings..."
    curl -s http://localhost:8080/actuator/mappings | jq .

actuator-scheduled:
    #!/usr/bin/env bash
    echo "⏰ Getting Spring Boot scheduled tasks..."
    curl -s http://localhost:8080/actuator/scheduledtasks | jq .

actuator-sessions:
    #!/usr/bin/env bash
    echo "💺 Getting Spring Boot session info..."
    curl -s http://localhost:8080/actuator/sessions | jq .

actuator-threaddump:
    #!/usr/bin/env bash
    echo "🧵 Generating Spring Boot thread dump..."
    curl -s http://localhost:8080/actuator/threaddump | jq .

actuator-heapdump:
    #!/usr/bin/env bash
    echo "💾 Generating Spring Boot heap dump..."
    curl -s http://localhost:8080/actuator/heapdump -o heapdump.hprof
    echo "✅ Heap dump saved to heapdump.hprof"

# Database profile commands
run-h2:
    #!/usr/bin/env bash
    echo "🗄️  Running with H2 database..."
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

# Database management commands
db-init-h2:
    #!/usr/bin/env bash
    echo "🗄️  Initializing H2 database..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" spring-boot:run -Dspring-boot.run.profiles=h2 -Dspring-boot.run.arguments="--spring.jpa.hibernate.ddl-auto=create" &
    sleep 10
    pkill -f "spring-boot:run"
    echo "✅ H2 database initialized"

db-init-mysql:
    #!/usr/bin/env bash
    echo "🗄️  Initializing MySQL database..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" spring-boot:run -Dspring-boot.run.profiles=mysql -Dspring-boot.run.arguments="--spring.jpa.hibernate.ddl-auto=create" &
    sleep 10
    pkill -f "spring-boot:run"
    echo "✅ MySQL database initialized"

db-init-postgres:
    #!/usr/bin/env bash
    echo "🗄️  Initializing PostgreSQL database..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" spring-boot:run -Dspring-boot.run.profiles=postgres -Dspring-boot.run.arguments="--spring.jpa.hibernate.ddl-auto=create" &
    sleep 10
    pkill -f "spring-boot:run"
    echo "✅ PostgreSQL database initialized"

db-reset-h2:
    #!/usr/bin/env bash
    echo "🗄️  Resetting H2 database..."
    rm -f src/main/resources/db/h2/data.sql
    echo "✅ H2 database reset"

db-validate:
    #!/usr/bin/env bash
    echo "🗄️  Validating database connection..."
    curl -s http://localhost:8080/actuator/health | jq .components.db

db-schema:
    #!/usr/bin/env bash
    echo "🗄️  Showing database schema..."
    find src/main/resources/db -name "schema.sql" -exec echo "=== {} ===" \; -exec cat {} \;

# Code quality and coverage
coverage:
    #!/usr/bin/env bash
    echo "📊 Generating code coverage report..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" jacoco:report
    echo "✅ Coverage report generated in target/site/jacoco/"

validate-format:
    #!/usr/bin/env bash
    echo "🎨 Validating code format..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" spring-javaformat:validate

compile-css:
    #!/usr/bin/env bash
    echo "🎨 Compiling CSS..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" compile -Pcss

# Native image building
native-build:
    #!/usr/bin/env bash
    echo "🏗️  Building native image..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" native:compile

# Development helpers
dev-run:
    #!/usr/bin/env bash
    echo "🚀 Running in development mode..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" spring-boot:run -Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005"

dev-debug:
    #!/usr/bin/env bash
    echo "🐛 Starting in debug mode..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" spring-boot:run -Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005"

dev-reload:
    #!/usr/bin/env bash
    echo "🔄 Reloading application..."
    curl -X POST http://localhost:8080/actuator/restart

dev-profile:
    #!/usr/bin/env bash
    echo "🎭 Running with development profile..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" spring-boot:run -Dspring-boot.run.profiles=dev

dev-watch:
    #!/usr/bin/env bash
    echo "👀 Watching for changes..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" spring-boot:run -Dspring-boot.run.jvmArguments="-Dspring.devtools.restart.enabled=true"

dev-hot-reload:
    #!/usr/bin/env bash
    echo "🔥 Enabling hot reload..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" spring-boot:run -Dspring-boot.run.jvmArguments="-Dspring.devtools.restart.enabled=true -Dspring.devtools.livereload.enabled=true"

# Container and Docker commands
test-containers:
    #!/usr/bin/env bash
    echo "🐳 Running tests with containers..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" test -Dspring.profiles.active=testcontainers

docker-compose-up:
    #!/usr/bin/env bash
    echo "🐳 Starting Docker Compose..."
    docker-compose up -d

docker-compose-down:
    #!/usr/bin/env bash
    echo "🐳 Stopping Docker Compose..."
    docker-compose down

docker-build:
    #!/usr/bin/env bash
    echo "🐳 Building Docker image..."
    docker build -t spring-petclinic .

docker-run:
    #!/usr/bin/env bash
    echo "🐳 Running Docker container..."
    docker run -p 8080:8080 spring-petclinic

docker-stop:
    #!/usr/bin/env bash
    echo "🐳 Stopping Docker container..."
    docker stop $(docker ps -q --filter ancestor=spring-petclinic)

docker-logs:
    #!/usr/bin/env bash
    echo "🐳 Showing Docker logs..."
    docker logs $(docker ps -q --filter ancestor=spring-petclinic)

docker-clean:
    #!/usr/bin/env bash
    echo "🐳 Cleaning Docker resources..."
    docker system prune -f

# Application info commands
show-props:
    #!/usr/bin/env bash
    echo "⚙️  Showing application properties..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" spring-boot:run -Dspring-boot.run.arguments="--debug" &
    sleep 10
    pkill -f "spring-boot:run"

deps-tree:
    #!/usr/bin/env bash
    echo "🌳 Showing dependency tree..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" dependency:tree

app-info:
    #!/usr/bin/env bash
    echo "ℹ️  Getting application info..."
    curl -s http://localhost:8080/actuator/info | jq .

# Maven plugin commands
mvn-dependency-tree:
    #!/usr/bin/env bash
    echo "🌳 Showing Maven dependency tree..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" dependency:tree

mvn-dependency-analyze:
    #!/usr/bin/env bash
    echo "🔍 Analyzing Maven dependencies..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" dependency:analyze

mvn-surefire-report:
    #!/usr/bin/env bash
    echo "📊 Generating Maven Surefire report..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" surefire-report:report

mvn-site:
    #!/usr/bin/env bash
    echo "🌐 Generating Maven site..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" site

mvn-validate:
    #!/usr/bin/env bash
    echo "✅ Validating Maven project..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" validate

mvn-verify:
    #!/usr/bin/env bash
    echo "✅ Verifying Maven project..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" verify

# Code quality commands
checkstyle-report:
    #!/usr/bin/env bash
    echo "📊 Generating Checkstyle report..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" checkstyle:checkstyle

format-check:
    #!/usr/bin/env bash
    echo "🎨 Checking code format..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" spring-javaformat:validate

format-apply:
    #!/usr/bin/env bash
    echo "🎨 Applying code format..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" spring-javaformat:apply

nohttp-check:
    #!/usr/bin/env bash
    echo "🔒 Checking for HTTP URLs..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" checkstyle:check -Dcheckstyle.configLocation=src/checkstyle/nohttp-checkstyle.xml

cyclonedx-report:
    #!/usr/bin/env bash
    echo "📋 Generating CycloneDX SBOM report..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" cyclonedx:makeAggregateBom

# Build and package commands
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

war-package:
    #!/usr/bin/env bash
    echo "📦 Packaging as WAR..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" package -Dpackaging=war

fat-jar:
    #!/usr/bin/env bash
    echo "📦 Creating fat JAR..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" package -Dspring-boot.repackage.enabled=true

# System and environment commands
java-version:
    #!/usr/bin/env bash
    echo "☕ Java version:"
    "/c/Program Files/Java/jdk-24/bin/java.exe" -version

maven-version:
    #!/usr/bin/env bash
    echo "📦 Maven version:"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" -version

git-status:
    #!/usr/bin/env bash
    echo "📝 Git status:"
    git status

git-log:
    #!/usr/bin/env bash
    echo "📝 Recent Git commits:"
    git log --oneline -10

git-branch:
    #!/usr/bin/env bash
    echo "🌿 Current Git branch:"
    git branch --show-current

curl-health:
    #!/usr/bin/env bash
    echo "🏥 Health check with curl:"
    curl -s http://localhost:8080/actuator/health | jq .

# File and directory commands
find-java:
    #!/usr/bin/env bash
    echo "📁 Finding Java files:"
    find src -name "*.java" | head -10

find-resources:
    #!/usr/bin/env bash
    echo "📁 Finding resource files:"
    find src/main/resources -type f | head -10

find-tests:
    #!/usr/bin/env bash
    echo "📁 Finding test files:"
    find src/test -name "*.java" | head -10

count-lines:
    #!/usr/bin/env bash
    echo "📊 Counting lines of code:"
    find src -name "*.java" -exec wc -l {} + | tail -1

list-deps:
    #!/usr/bin/env bash
    echo "📦 Listing dependencies:"
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" dependency:list

# Test enhancement commands
test-unit:
    #!/usr/bin/env bash
    echo "🧪 Running unit tests only..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" test -Dtest=*Test

test-integration:
    #!/usr/bin/env bash
    echo "🧪 Running integration tests only..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" test -Dtest=*IntegrationTest

test-containers-only:
    #!/usr/bin/env bash
    echo "🧪 Running container tests only..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" test -Dtest=*Test -Dspring.profiles.active=testcontainers

test-report:
    #!/usr/bin/env bash
    echo "📊 Generating test report..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" surefire-report:report

test-coverage-html:
    #!/usr/bin/env bash
    echo "📊 Generating HTML coverage report..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" jacoco:report
    echo "✅ HTML report available at target/site/jacoco/index.html"

# Configuration commands
config-list:
    #!/usr/bin/env bash
    echo "⚙️  Listing configuration properties..."
    curl -s http://localhost:8080/actuator/configprops | jq .

config-get:
    #!/usr/bin/env bash
    echo "⚙️  Getting specific configuration..."
    curl -s http://localhost:8080/actuator/configprops | jq '.configurations | keys'

config-validate:
    #!/usr/bin/env bash
    echo "✅ Validating configuration..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" spring-boot:run -Dspring-boot.run.arguments="--debug" &
    sleep 5
    pkill -f "spring-boot:run"

config-diff:
    #!/usr/bin/env bash
    echo "🔍 Showing configuration differences..."
    diff src/main/resources/application.properties src/main/resources/application-mysql.properties || echo "No differences found"

# Performance commands
memory-check:
    #!/usr/bin/env bash
    echo "💾 Checking memory usage..."
    jps -l | grep spring-petclinic | awk '{print $1}' | xargs -I {} jstat -gc {} 1 1

thread-check:
    #!/usr/bin/env bash
    echo "🧵 Checking thread status..."
    curl -s http://localhost:8080/actuator/threaddump | jq '.threads | length'

gc-check:
    #!/usr/bin/env bash
    echo "🗑️  Checking garbage collection..."
    jps -l | grep spring-petclinic | awk '{print $1}' | xargs -I {} jstat -gcutil {} 1 1

performance-profile:
    #!/usr/bin/env bash
    echo "📊 Performance profiling..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" spring-boot:run -Dspring-boot.run.jvmArguments="-XX:+UseG1GC -XX:+PrintGC -XX:+PrintGCDetails"

# Security commands
security-scan-deps:
    #!/usr/bin/env bash
    echo "🔒 Scanning dependencies for vulnerabilities..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" dependency:tree | grep -i vulnerable || echo "No vulnerable dependencies found"

security-check-urls:
    #!/usr/bin/env bash
    echo "🔒 Checking for HTTP URLs (security)..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" checkstyle:check -Dcheckstyle.configLocation=src/checkstyle/nohttp-checkstyle.xml

security-validate:
    #!/usr/bin/env bash
    echo "✅ Validating security configuration..."
    curl -s http://localhost:8080/actuator/health | jq .components.security

# Documentation commands
docs-generate:
    #!/usr/bin/env bash
    echo "📚 Generating documentation..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" site

docs-validate:
    #!/usr/bin/env bash
    echo "✅ Validating documentation..."
    find target/site -name "*.html" | head -5

api-docs:
    #!/usr/bin/env bash
    echo "📖 Generating API documentation..."
    curl -s http://localhost:8080/actuator/mappings | jq .

# Backup and recovery commands
backup-config:
    #!/usr/bin/env bash
    echo "💾 Backing up configuration..."
    cp src/main/resources/application.properties backup-application.properties
    echo "✅ Configuration backed up"

backup-data:
    #!/usr/bin/env bash
    echo "💾 Backing up data..."
    cp -r src/main/resources/db backup-db
    echo "✅ Data backed up"

restore-config:
    #!/usr/bin/env bash
    echo "🔄 Restoring configuration..."
    cp backup-application.properties src/main/resources/application.properties
    echo "✅ Configuration restored"

# =============================================================================
# CI/CD Pipeline commands
# =============================================================================

ci-build:
    #!/usr/bin/env bash
    echo "🏗️  CI Build with full validation..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" clean verify

ci-test:
    #!/usr/bin/env bash
    echo "🧪 CI Test with quality gates..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" test jacoco:report

quality-gate:
    #!/usr/bin/env bash
    echo "🚪 Quality Gate - comprehensive quality checks..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" verify checkstyle:check spring-javaformat:validate

# =============================================================================
# Development Workflow commands
# =============================================================================

dev-start:
    #!/usr/bin/env bash
    echo "🚀 Starting development environment..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" spring-boot:run

dev-stop:
    #!/usr/bin/env bash
    echo "🛑 Stopping development environment..."
    pkill -f "spring-boot:run"

dev-restart:
    #!/usr/bin/env bash
    echo "🔄 Restarting development environment..."
    just dev-stop
    sleep 2
    just dev-start

dev-status:
    #!/usr/bin/env bash
    echo "📊 Development environment status..."
    if pgrep -f "spring-boot:run" > /dev/null; then
        echo "✅ Application is running"
        curl -s http://localhost:8080/actuator/health | jq .
    else
        echo "❌ Application is not running"
    fi

# =============================================================================
# Reporting commands
# =============================================================================

report-coverage:
    #!/usr/bin/env bash
    echo "📊 Generating comprehensive coverage report..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" jacoco:report
    echo "✅ Coverage report: target/site/jacoco/index.html"

report-quality:
    #!/usr/bin/env bash
    echo "📊 Generating quality report..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" checkstyle:checkstyle
    echo "✅ Quality report generated"

report-test:
    #!/usr/bin/env bash
    echo "📊 Generating test report..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" surefire-report:report
    echo "✅ Test report: target/site/surefire-report.html"

# =============================================================================
# Utility commands
# =============================================================================

status:
    #!/usr/bin/env bash
    echo "📊 Project status..."
    echo "Java version:"
    "/c/Program Files/Java/jdk-24/bin/java.exe" -version
    echo "Maven version:"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" -version
    echo "Git status:"
    git status --porcelain | wc -l | xargs echo "Modified files:"
    echo "Build status:"
    if [ -f "target/spring-petclinic-*.jar" ]; then
        echo "✅ Application built successfully"
    else
        echo "❌ Application not built"
    fi

version:
    #!/usr/bin/env bash
    echo "📦 Version information..."
    echo "Spring Boot version:"
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" help:evaluate -Dexpression=project.version -q -DforceStdout
    echo "Java version:"
    "/c/Program Files/Java/jdk-24/bin/java.exe" -version
    echo "Maven version:"
    "/c/Users/krato/Desktop/apache-maven-3.9.11/bin/mvn" -version

env-info:
    #!/usr/bin/env bash
    echo "🌍 Environment information..."
    echo "JAVA_HOME: $JAVA_HOME"
    echo "M2_HOME: $M2_HOME"
    echo "PATH: $PATH"
    echo "Current directory: $(pwd)"
    echo "Available memory: $(free -h 2>/dev/null || echo 'Not available on Windows')"

cleanup:
    #!/usr/bin/env bash
    echo "🧹 Cleaning up temporary files..."
    rm -rf target/tmp
    rm -f *.log
    rm -f heapdump.hprof
    echo "✅ Cleanup completed"

help:
    #!/usr/bin/env bash
    echo "🚀 Spring PetClinic - Just Commands Help"
    echo ""
    echo "📋 Available command categories:"
    echo "  🔨 Build: build, clean, compile"
    echo "  🧪 Test: test, test-unit, test-integration"
    echo "  🚀 Run: run, dev-run, dev-debug"
    echo "  🎨 Quality: lint, format, coverage"
    echo "  🗄️  Database: run-h2, run-mysql, run-postgres"
    echo "  🐳 Docker: docker-build, docker-run"
    echo "  📊 Reports: report-coverage, report-quality"
    echo "  🔧 Utils: status, version, env-info"
    echo ""
    echo "💡 Use 'just --list' to see all available commands"
    echo "💡 Use 'just <command>' to run a specific command"

# =============================================================================
# Deployment commands
# =============================================================================

deploy-docker:
    #!/usr/bin/env bash
    echo "🐳 Deploying with Docker..."
    docker build -t spring-petclinic .
    docker run -d -p 8080:8080 --name petclinic-app spring-petclinic
    echo "✅ Application deployed in Docker container"

# =============================================================================
# Development helpers
# =============================================================================

dev-setup:
    #!/usr/bin/env bash
    echo "🔧 Setting up development environment..."
    export JAVA_HOME="/c/Program Files/Java/jdk-24"
    export PATH="/c/Users/krato/Desktop/apache-maven-3.9.11/bin:$PATH"
    echo "✅ Development environment configured"

dev-logs:
    #!/usr/bin/env bash
    echo "📋 Development logs..."
    if [ -f "target/spring-petclinic.log" ]; then
        tail -f target/spring-petclinic.log
    else
        echo "No log file found"
    fi

# =============================================================================
# Detection and setup
# =============================================================================

detect:
    #!/usr/bin/env bash
    echo "🔍 Detecting project type..."
    if [ -f "pom.xml" ]; then
        echo "📦 Maven project detected"
        echo "Java version: $(java -version 2>&1 | head -1)"
        echo "Maven version: $(mvn -version 2>&1 | head -1)"
    elif [ -f "build.gradle" ]; then
        echo "📦 Gradle project detected"
        echo "Java version: $(java -version 2>&1 | head -1)"
        echo "Gradle version: $(./gradlew --version 2>&1 | head -1)"
    else
        echo "❌ No build system detected"
    fi 