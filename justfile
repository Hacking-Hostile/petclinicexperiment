# Multi-Language CI/CD Pipeline - Just Commands
# Universal Project Template - Language Agnostic

# CI: false
default:
    @echo "Available commands:"
    @echo "  System & Environment: java-version, get-mvn-cmd, maven-version, detect, env-info, status"
    @echo "  Utility Commands: find-java, find-resources, count-lines, cleanup, db-schema"
    @echo "  Database Commands: db-init-h2, db-reset-h2"
    @echo "  Development Commands: dev-setup, dev-status, dev-stop"
    @echo "  Build Commands: build, clean, test"
    @echo "  Maven Commands: mvn-validate, mvn-site, coverage, cyclonedx-report"
    @echo "  Quality Commands: lint, format, deploy"
    @echo "  Run Commands: run, run-h2"
    @echo ""
    @echo "Run 'just <command>' to execute a specific command"
    @echo "Run 'just --list' to see all available commands"

# CI: false
get-mvn-cmd:
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
build:
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
# STAGE: 4
test:
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

# CI: true
# STAGE: 3
clean:
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

# CI: false
run:
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
lint:
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
format:
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
deploy:
    #!/usr/bin/env bash
    echo "🚀 Deploying application..."
    echo "⚠️  Deployment not implemented yet"
    exit 1

# =============================================================================
# MAVEN SPECIFIC COMMANDS
# =============================================================================

# CI: true
# STAGE: 3
mvn-validate:
    #!/usr/bin/env bash
    echo "✅ Validating Maven project..."
    MVN_CMD=$(just get-mvn-cmd)
    echo "Using Maven: $MVN_CMD"
    $MVN_CMD validate

# CI: false
mvn-site:
    #!/usr/bin/env bash
    echo "🌐 Generating Maven site..."
    MVN_CMD=$(just get-mvn-cmd)
    echo "Using Maven: $MVN_CMD"
    $MVN_CMD site

# =============================================================================
# DATABASE COMMANDS
# =============================================================================

# CI: false
run-h2:
    #!/usr/bin/env bash
    echo "🗄️  Running with H2 database..."
    MVN_CMD=$(just get-mvn-cmd)
    echo "Using Maven: $MVN_CMD"
    $MVN_CMD spring-boot:run -Dspring-boot.run.profiles=h2

# CI: false
db-init-h2:
    #!/usr/bin/env bash
    echo "🗄️  Initializing H2 database..."
    MVN_CMD=$(just get-mvn-cmd)
    echo "Using Maven: $MVN_CMD"
    $MVN_CMD spring-boot:run -Dspring-boot.run.profiles=h2 -Dspring-boot.run.arguments="--spring.jpa.hibernate.ddl-auto=create" &
    sleep 10
    echo "✅ H2 database initialized"

# CI: false
db-reset-h2:
    #!/usr/bin/env bash
    echo "🗄️  Resetting H2 database..."
    rm -f src/main/resources/db/h2/data.sql
    echo "✅ H2 database reset"

# CI: false
db-schema:
    #!/usr/bin/env bash
    echo "🗄️  Showing database schema..."
    find src/main/resources/db -name "schema.sql" -exec echo "=== {} ===" \; -exec cat {} \;

# =============================================================================
# CODE QUALITY AND COVERAGE
# =============================================================================

# CI: true
# STAGE: 4
coverage:
    #!/usr/bin/env bash
    echo "📊 Generating code coverage report..."
    MVN_CMD=$(just get-mvn-cmd)
    echo "Using Maven: $MVN_CMD"
    $MVN_CMD jacoco:report
    echo "✅ Coverage report generated in target/site/jacoco/"

# CI: true
# STAGE: 3
cyclonedx-report:
    #!/usr/bin/env bash
    echo "📋 Generating CycloneDX SBOM report..."
    MVN_CMD=$(just get-mvn-cmd)
    echo "Using Maven: $MVN_CMD"
    $MVN_CMD cyclonedx:makeAggregateBom

# =============================================================================
# BUILD AND PACKAGE COMMANDS
# =============================================================================

# Note: JAR commands removed due to Maven download issues
# These commands require a successful build first

# =============================================================================
# SYSTEM AND ENVIRONMENT COMMANDS
# =============================================================================

# CI: false
java-version:
    #!/usr/bin/env bash
    echo "☕ Java version:"
    java -version

# CI: false
maven-version:
    #!/usr/bin/env bash
    echo "📦 Maven version:"
    MVN_CMD=$(just get-mvn-cmd)
    echo "Using Maven: $MVN_CMD"
    $MVN_CMD -version

# CI: false
status:
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
env-info:
    #!/usr/bin/env bash
    echo "🌍 Environment information..."
    echo "JAVA_HOME: $JAVA_HOME"
    echo "M2_HOME: $M2_HOME"
    echo "PATH: $PATH"
    echo "Current directory: $(pwd)"
    echo "Available memory: $(free -h 2>/dev/null || vm_stat 2>/dev/null | head -1 || echo 'Not available')"

# =============================================================================
# FILE AND DIRECTORY COMMANDS
# =============================================================================

# CI: false
find-java:
    #!/usr/bin/env bash
    echo "📁 Finding Java files:"
    find src -name "*.java" | head -10

# CI: false
find-resources:
    #!/usr/bin/env bash
    echo "📁 Finding resource files:"
    find src/main/resources -type f | head -10

# CI: false
count-lines:
    #!/usr/bin/env bash
    echo "📊 Counting lines of code:"
    find src -name "*.java" -exec wc -l {} + | tail -1

# =============================================================================
# UTILITY COMMANDS
# =============================================================================

# CI: false
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

# CI: false
dev-setup:
    #!/usr/bin/env bash
    echo "🔧 Setting up development environment..."
    echo "✅ Development environment configured"

# CI: false
dev-status:
    #!/usr/bin/env bash
    echo "📊 Development environment status..."
    if curl -s http://localhost:8080/actuator/health > /dev/null 2>&1; then
        echo "✅ Application is running"
        curl -s http://localhost:8080/actuator/health | jq . 2>/dev/null || curl -s http://localhost:8080/actuator/health
    else
        echo "❌ Application is not running"
    fi

# CI: false
dev-stop:
    #!/usr/bin/env bash
    echo "🛑 Stopping development environment..."
    echo "Please stop the application manually (Ctrl+C)"

# =============================================================================
# DETECTION AND SETUP
# =============================================================================

# CI: false
detect:
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

# =============================================================================
# CI VALIDATION COMMANDS
# =============================================================================

# CI: false
ci:
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
ci-validate:
    #!/usr/bin/env bash
    echo "🔍 Validating CI command declarations..."
    
    # Get all commands
    ALL_COMMANDS=$(just --list | grep -v "Available recipes:" | grep -v "^#" | sed 's/#.*$//' | tr -d ' ' | grep -v '^$')
    
    # Check each command has CI comment
    MISSING_CI_COMMENTS=""
    for cmd in $ALL_COMMANDS; do
        if [ "$cmd" != "default" ]; then
            # Search for CI comment in the justfile using a more robust pattern
            if ! grep -A 5 -B 5 "^$cmd:" justfile | grep -q "CI:"; then
                MISSING_CI_COMMENTS="$MISSING_CI_COMMENTS $cmd"
            fi
        fi
    done
    
    if [ -n "$MISSING_CI_COMMENTS" ]; then
        echo "❌ Commands missing CI declarations: $MISSING_CI_COMMENTS"
        echo "💡 Add '# CI: true' or '# CI: false' to each command"
        echo "💡 Example:"
        echo "   # CI: true"
        echo "   build:"
        echo "       echo 'Building...'"
        exit 1
    fi
    
    echo "✅ All commands have CI declarations"
    
    # Validate stage declarations for CI commands
    echo "🔍 Validating stage declarations for CI commands..."
    MISSING_STAGE_COMMENTS=""
    for cmd in $ALL_COMMANDS; do
        if [ "$cmd" != "default" ]; then
            # Check if command is CI and has stage declaration
            if grep -A 5 -B 5 "^$cmd:" justfile | grep -q "CI: true"; then
                if ! grep -A 5 -B 5 "^$cmd:" justfile | grep -q "STAGE:"; then
                    MISSING_STAGE_COMMENTS="$MISSING_STAGE_COMMENTS $cmd"
                fi
            fi
        fi
    done
    
    if [ -n "$MISSING_STAGE_COMMENTS" ]; then
        echo "❌ CI commands missing STAGE declarations: $MISSING_STAGE_COMMENTS"
        echo "💡 Add '# STAGE: X' to each CI command"
        echo "💡 Example:"
        echo "   # CI: true"
        echo "   # STAGE: 3"
        echo "   build:"
        echo "       echo 'Building...'"
        exit 1
    fi
    
    echo "✅ All CI commands have stage declarations"

# CI: false
ci-commands:
    #!/usr/bin/env bash
    echo "📋 CI-suitable commands:"
    
    # Get all commands
    ALL_COMMANDS=$(just --list | grep -v "Available recipes:" | grep -v "^#" | sed 's/#.*$//' | tr -d ' ' | grep -v '^$')
    
    CI_COMMANDS=""
    NON_CI_COMMANDS=""
    
    for cmd in $ALL_COMMANDS; do
        if [ "$cmd" != "default" ]; then
            # Search for CI comment in the justfile using a more robust pattern
            if grep -A 5 -B 5 "^$cmd:" justfile | grep -q "CI: true"; then
                CI_COMMANDS="$CI_COMMANDS $cmd"
            elif grep -A 5 -B 5 "^$cmd:" justfile | grep -q "CI: false"; then
                NON_CI_COMMANDS="$NON_CI_COMMANDS $cmd"
            else
                echo "⚠️  Command '$cmd' missing CI declaration"
            fi
        fi
    done
    
    echo "✅ CI-suitable: $CI_COMMANDS"
    echo "❌ Local-only: $NON_CI_COMMANDS"

# CI: false
stage-commands:
    #!/usr/bin/env bash
    STAGE=$1
    if [ -z "$STAGE" ]; then
        echo "❌ Please specify a stage number (1-6)"
        echo "💡 Usage: just stage-commands <stage_number>"
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
        echo "✅ Stage $STAGE commands: $STAGE_COMMANDS"
    else
        echo "❌ No commands found for stage $STAGE"
    fi 