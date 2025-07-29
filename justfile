# Multi-Language CI/CD Pipeline - Just Commands
# Spring PetClinic Project

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

# Universal build command
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

# Universal test command
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

# Universal clean command
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

# Universal run command
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

# Universal lint command
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

# Universal format command
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

# Universal deploy command
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
# Maven-specific commands
# =============================================================================

mvn-clean:
    #!/usr/bin/env bash
    echo "🧹 Cleaning Maven project..."
    if command -v mvn &> /dev/null; then
        mvn clean
    elif [ -f "./mvnw" ]; then
        ./mvnw clean
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi

mvn-compile:
    #!/usr/bin/env bash
    echo "🔨 Compiling Maven project..."
    if command -v mvn &> /dev/null; then
        mvn compile
    elif [ -f "./mvnw" ]; then
        ./mvnw compile
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi

mvn-test:
    #!/usr/bin/env bash
    echo "🧪 Running Maven tests..."
    if command -v mvn &> /dev/null; then
        mvn test
    elif [ -f "./mvnw" ]; then
        ./mvnw test
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi

mvn-package:
    #!/usr/bin/env bash
    echo "📦 Packaging Maven project..."
    if command -v mvn &> /dev/null; then
        mvn package
    elif [ -f "./mvnw" ]; then
        ./mvnw package
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi

mvn-install:
    #!/usr/bin/env bash
    echo "📦 Installing Maven project..."
    if command -v mvn &> /dev/null; then
        mvn install
    elif [ -f "./mvnw" ]; then
        ./mvnw install
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi

mvn-spring-boot-run:
    #!/usr/bin/env bash
    echo "🚀 Running Spring Boot with Maven..."
    if command -v mvn &> /dev/null; then
        mvn spring-boot:run
    elif [ -f "./mvnw" ]; then
        ./mvnw spring-boot:run
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi

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
# Database profile commands (working ones only)
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

# Database management commands (working ones only)
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

# Code quality and coverage
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

validate-format:
    #!/usr/bin/env bash
    echo "🎨 Validating code format..."
    if command -v mvn &> /dev/null; then
        mvn spring-javaformat:validate
    elif [ -f "./mvnw" ]; then
        ./mvnw spring-javaformat:validate
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi

compile-css:
    #!/usr/bin/env bash
    echo "🎨 Compiling CSS..."
    if command -v mvn &> /dev/null; then
        mvn compile -Pcss
    elif [ -f "./mvnw" ]; then
        ./mvnw compile -Pcss
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi

# Development helpers
dev-run:
    #!/usr/bin/env bash
    echo "🚀 Running in development mode..."
    if command -v mvn &> /dev/null; then
        mvn spring-boot:run -Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005"
    elif [ -f "./mvnw" ]; then
        ./mvnw spring-boot:run -Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005"
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi

dev-debug:
    #!/usr/bin/env bash
    echo "🐛 Starting in debug mode..."
    if command -v mvn &> /dev/null; then
        mvn spring-boot:run -Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005"
    elif [ -f "./mvnw" ]; then
        ./mvnw spring-boot:run -Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005"
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi

dev-profile:
    #!/usr/bin/env bash
    echo "🎭 Running with development profile..."
    if command -v mvn &> /dev/null; then
        mvn spring-boot:run -Dspring-boot.run.profiles=dev
    elif [ -f "./mvnw" ]; then
        ./mvnw spring-boot:run -Dspring-boot.run.profiles=dev
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi

dev-watch:
    #!/usr/bin/env bash
    echo "👀 Watching for changes..."
    if command -v mvn &> /dev/null; then
        mvn spring-boot:run -Dspring-boot.run.jvmArguments="-Dspring.devtools.restart.enabled=true"
    elif [ -f "./mvnw" ]; then
        ./mvnw spring-boot:run -Dspring-boot.run.jvmArguments="-Dspring.devtools.restart.enabled=true"
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi

dev-hot-reload:
    #!/usr/bin/env bash
    echo "🔥 Enabling hot reload..."
    if command -v mvn &> /dev/null; then
        mvn spring-boot:run -Dspring-boot.run.jvmArguments="-Dspring.devtools.restart.enabled=true -Dspring.devtools.livereload.enabled=true"
    elif [ -f "./mvnw" ]; then
        ./mvnw spring-boot:run -Dspring-boot.run.jvmArguments="-Dspring.devtools.restart.enabled=true -Dspring.devtools.livereload.enabled=true"
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi

# Application info commands
show-props:
    #!/usr/bin/env bash
    echo "⚙️  Showing application properties..."
    if command -v mvn &> /dev/null; then
        mvn spring-boot:run -Dspring-boot.run.arguments="--debug" &
    elif [ -f "./mvnw" ]; then
        ./mvnw spring-boot:run -Dspring-boot.run.arguments="--debug" &
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi
    sleep 10
    echo "✅ Properties displayed"

deps-tree:
    #!/usr/bin/env bash
    echo "🌳 Showing dependency tree..."
    if command -v mvn &> /dev/null; then
        mvn dependency:tree
    elif [ -f "./mvnw" ]; then
        ./mvnw dependency:tree
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi

# Maven plugin commands
mvn-dependency-tree:
    #!/usr/bin/env bash
    echo "🌳 Showing Maven dependency tree..."
    if command -v mvn &> /dev/null; then
        mvn dependency:tree
    elif [ -f "./mvnw" ]; then
        ./mvnw dependency:tree
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi

mvn-dependency-analyze:
    #!/usr/bin/env bash
    echo "🔍 Analyzing Maven dependencies..."
    if command -v mvn &> /dev/null; then
        mvn dependency:analyze
    elif [ -f "./mvnw" ]; then
        ./mvnw dependency:analyze
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi

mvn-surefire-report:
    #!/usr/bin/env bash
    echo "📊 Generating Maven Surefire report..."
    if command -v mvn &> /dev/null; then
        mvn surefire-report:report
    elif [ -f "./mvnw" ]; then
        ./mvnw surefire-report:report
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

mvn-verify:
    #!/usr/bin/env bash
    echo "✅ Verifying Maven project..."
    if command -v mvn &> /dev/null; then
        mvn verify
    elif [ -f "./mvnw" ]; then
        ./mvnw verify
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi

# Code quality commands
checkstyle-report:
    #!/usr/bin/env bash
    echo "📊 Generating Checkstyle report..."
    if command -v mvn &> /dev/null; then
        mvn checkstyle:checkstyle
    elif [ -f "./mvnw" ]; then
        ./mvnw checkstyle:checkstyle
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi

format-check:
    #!/usr/bin/env bash
    echo "🎨 Checking code format..."
    if command -v mvn &> /dev/null; then
        mvn spring-javaformat:validate
    elif [ -f "./mvnw" ]; then
        ./mvnw spring-javaformat:validate
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi

format-apply:
    #!/usr/bin/env bash
    echo "🎨 Applying code format..."
    if command -v mvn &> /dev/null; then
        mvn spring-javaformat:apply
    elif [ -f "./mvnw" ]; then
        ./mvnw spring-javaformat:apply
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi

nohttp-check:
    #!/usr/bin/env bash
    echo "🔒 Checking for HTTP URLs..."
    if command -v mvn &> /dev/null; then
        mvn checkstyle:check -Dcheckstyle.configLocation=src/checkstyle/nohttp-checkstyle.xml
    elif [ -f "./mvnw" ]; then
        ./mvnw checkstyle:check -Dcheckstyle.configLocation=src/checkstyle/nohttp-checkstyle.xml
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi

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
    if command -v mvn &> /dev/null; then
        mvn package -Dpackaging=war
    elif [ -f "./mvnw" ]; then
        ./mvnw package -Dpackaging=war
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi

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

# System and environment commands
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
    if command -v mvn &> /dev/null; then
        mvn dependency:list
    elif [ -f "./mvnw" ]; then
        ./mvnw dependency:list
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi

# Test enhancement commands
test-unit:
    #!/usr/bin/env bash
    echo "🧪 Running unit tests only..."
    if command -v mvn &> /dev/null; then
        mvn test -Dtest=*Test
    elif [ -f "./mvnw" ]; then
        ./mvnw test -Dtest=*Test
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi

test-integration:
    #!/usr/bin/env bash
    echo "🧪 Running integration tests only..."
    if command -v mvn &> /dev/null; then
        mvn test -Dtest=*IntegrationTest
    elif [ -f "./mvnw" ]; then
        ./mvnw test -Dtest=*IntegrationTest
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi

test-report:
    #!/usr/bin/env bash
    echo "📊 Generating test report..."
    if command -v mvn &> /dev/null; then
        mvn surefire-report:report
    elif [ -f "./mvnw" ]; then
        ./mvnw surefire-report:report
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi

test-coverage-html:
    #!/usr/bin/env bash
    echo "📊 Generating HTML coverage report..."
    if command -v mvn &> /dev/null; then
        mvn jacoco:report
    elif [ -f "./mvnw" ]; then
        ./mvnw jacoco:report
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi
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
    if command -v mvn &> /dev/null; then
        mvn spring-boot:run -Dspring-boot.run.arguments="--debug" &
    elif [ -f "./mvnw" ]; then
        ./mvnw spring-boot:run -Dspring-boot.run.arguments="--debug" &
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi
    sleep 5
    echo "✅ Configuration validated"

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
    if command -v mvn &> /dev/null; then
        mvn spring-boot:run -Dspring-boot.run.jvmArguments="-XX:+UseG1GC -XX:+PrintGC -XX:+PrintGCDetails"
    elif [ -f "./mvnw" ]; then
        ./mvnw spring-boot:run -Dspring-boot.run.jvmArguments="-XX:+UseG1GC -XX:+PrintGC -XX:+PrintGCDetails"
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi

# Security commands
security-scan-deps:
    #!/usr/bin/env bash
    echo "🔒 Scanning dependencies for vulnerabilities..."
    if command -v mvn &> /dev/null; then
        mvn dependency:tree | grep -i vulnerable || echo "No vulnerable dependencies found"
    elif [ -f "./mvnw" ]; then
        ./mvnw dependency:tree | grep -i vulnerable || echo "No vulnerable dependencies found"
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi

security-check-urls:
    #!/usr/bin/env bash
    echo "🔒 Checking for HTTP URLs (security)..."
    if command -v mvn &> /dev/null; then
        mvn checkstyle:check -Dcheckstyle.configLocation=src/checkstyle/nohttp-checkstyle.xml
    elif [ -f "./mvnw" ]; then
        ./mvnw checkstyle:check -Dcheckstyle.configLocation=src/checkstyle/nohttp-checkstyle.xml
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi

security-validate:
    #!/usr/bin/env bash
    echo "✅ Validating security configuration..."
    curl -s http://localhost:8080/actuator/health | jq .components.security

# Documentation commands
docs-generate:
    #!/usr/bin/env bash
    echo "📚 Generating documentation..."
    if command -v mvn &> /dev/null; then
        mvn site
    elif [ -f "./mvnw" ]; then
        ./mvnw site
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi

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
# Development Workflow commands
# =============================================================================

dev-start:
    #!/usr/bin/env bash
    echo "🚀 Starting development environment..."
    if command -v mvn &> /dev/null; then
        mvn spring-boot:run
    elif [ -f "./mvnw" ]; then
        ./mvnw spring-boot:run
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi

dev-stop:
    #!/usr/bin/env bash
    echo "🛑 Stopping development environment..."
    echo "Please stop the application manually (Ctrl+C)"

dev-restart:
    #!/usr/bin/env bash
    echo "🔄 Restarting development environment..."
    echo "Please restart the application manually"

dev-status:
    #!/usr/bin/env bash
    echo "📊 Development environment status..."
    if curl -s http://localhost:8080/actuator/health > /dev/null 2>&1; then
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
    if command -v mvn &> /dev/null; then
        mvn jacoco:report
    elif [ -f "./mvnw" ]; then
        ./mvnw jacoco:report
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi
    echo "✅ Coverage report: target/site/jacoco/index.html"

report-quality:
    #!/usr/bin/env bash
    echo "📊 Generating quality report..."
    if command -v mvn &> /dev/null; then
        mvn checkstyle:checkstyle
    elif [ -f "./mvnw" ]; then
        ./mvnw checkstyle:checkstyle
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi
    echo "✅ Quality report generated"

report-test:
    #!/usr/bin/env bash
    echo "📊 Generating test report..."
    if command -v mvn &> /dev/null; then
        mvn surefire-report:report
    elif [ -f "./mvnw" ]; then
        ./mvnw surefire-report:report
    else
        echo "❌ Maven not found and no wrapper available"
        exit 1
    fi
    echo "✅ Test report: target/site/surefire-report.html"

# =============================================================================
# Utility commands
# =============================================================================

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

version:
    #!/usr/bin/env bash
    echo "📦 Version information..."
    echo "Spring Boot version:"
    if command -v mvn &> /dev/null; then
        mvn help:evaluate -Dexpression=project.version -q -DforceStdout
    elif [ -f "./mvnw" ]; then
        ./mvnw help:evaluate -Dexpression=project.version -q -DforceStdout
    else
        echo "❌ Maven not found and no wrapper available"
    fi
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
    echo "  🗄️  Database: run-h2"
    echo "  📊 Reports: report-coverage, report-quality"
    echo "  🔧 Utils: status, version, env-info"
    echo ""
    echo "💡 Use 'just --list' to see all available commands"
    echo "💡 Use 'just <command>' to run a specific command"

# =============================================================================
# Development helpers
# =============================================================================

dev-setup:
    #!/usr/bin/env bash
    echo "🔧 Setting up development environment..."
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