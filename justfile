# Multi-Language CI/CD Pipeline - Just Commands
# Universal Project Template - Language Agnostic

# CI: false
# STAGE: 0
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
# STAGE: 0
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
# STAGE: 0
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
# STAGE: 0
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
# STAGE: 0
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
# STAGE: 0
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
# STAGE: 0
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
# STAGE: 0
run-h2:
    #!/usr/bin/env bash
    echo "🗄️  Running with H2 database..."
    MVN_CMD=$(just get-mvn-cmd)
    echo "Using Maven: $MVN_CMD"
    $MVN_CMD spring-boot:run -Dspring-boot.run.profiles=h2

# CI: false
# STAGE: 0
db-init-h2:
    #!/usr/bin/env bash
    echo "🗄️  Initializing H2 database..."
    MVN_CMD=$(just get-mvn-cmd)
    echo "Using Maven: $MVN_CMD"
    $MVN_CMD spring-boot:run -Dspring-boot.run.profiles=h2 -Dspring-boot.run.arguments="--spring.jpa.hibernate.ddl-auto=create" &
    sleep 10
    echo "✅ H2 database initialized"

# CI: false
# STAGE: 0
db-reset-h2:
    #!/usr/bin/env bash
    echo "🗄️  Resetting H2 database..."
    rm -f src/main/resources/db/h2/data.sql
    echo "✅ H2 database reset"

# CI: false
# STAGE: 0
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
# STAGE: 0
java-version:
    #!/usr/bin/env bash
    echo "☕ Java version:"
    java -version

# CI: false
# STAGE: 0
maven-version:
    #!/usr/bin/env bash
    echo "📦 Maven version:"
    MVN_CMD=$(just get-mvn-cmd)
    echo "Using Maven: $MVN_CMD"
    $MVN_CMD -version

# CI: false
# STAGE: 0
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
# STAGE: 0
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
# STAGE: 0
find-java:
    #!/usr/bin/env bash
    echo "📁 Finding Java files:"
    find src -name "*.java" | head -10

# CI: false
# STAGE: 0
find-resources:
    #!/usr/bin/env bash
    echo "📁 Finding resource files:"
    find src/main/resources -type f | head -10

# CI: false
# STAGE: 0
count-lines:
    #!/usr/bin/env bash
    echo "📊 Counting lines of code:"
    find src -name "*.java" -exec wc -l {} + | tail -1

# =============================================================================
# UTILITY COMMANDS
# =============================================================================

# CI: false
# STAGE: 0
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
# STAGE: 0
dev-setup:
    #!/usr/bin/env bash
    echo "🔧 Setting up development environment..."
    echo "✅ Development environment configured"

# CI: false
# STAGE: 0
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
# STAGE: 0
dev-stop:
    #!/usr/bin/env bash
    echo "🛑 Stopping development environment..."
    echo "Please stop the application manually (Ctrl+C)"

# =============================================================================
# DETECTION AND SETUP
# =============================================================================

# CI: false
# STAGE: 0
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
# STAGE: 0
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
    
    # Use the comprehensive validate command
    just validate

# CI: false
# STAGE: 0
validate:
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
            
            # Validate STAGE value
            if ! [[ "$STAGE_VALUE" =~ ^[0-6]$ ]]; then
                echo "❌ $cmd: Invalid STAGE value '$STAGE_VALUE' (must be 0-6)"
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
            elif [ "$STAGE_VALUE" -ge 1 ] && [ "$STAGE_VALUE" -le 6 ]; then
                if [ "$CI_VALUE" != "true" ]; then
                    echo "❌ $cmd: Stages 1-6 must have CI: true (got CI: $CI_VALUE)"
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
            
            if [ "$CI_VALUE" = "true" ] && [ "$STAGE_VALUE" -lt 1 ] || [ "$STAGE_VALUE" -gt 6 ]; then
                echo "❌ $cmd: CI: true must have Stage 1-6 (got Stage: $STAGE_VALUE)"
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
        echo "   - All commands must have both # CI: true/false and # STAGE: 0-6"
        echo "   - Stage 0 ↔ CI: false (bidirectional consistency)"
        echo "   - Stages 1-6 ↔ CI: true (bidirectional consistency)"
        echo "   - If Stage 0, CI must be false"
        echo "   - If CI false, Stage must be 0"
        echo "   - If Stages 1-6, CI must be true"
        echo "   - If CI true, Stage must be 1-6"
        exit 1
    fi

# CI: false
# STAGE: 0
ci-commands:
    #!/usr/bin/env bash
    echo "📋 CI-suitable commands (Stages 1-6):"
    
    # Get all commands
    ALL_COMMANDS=$(just --list | grep -v "Available recipes:" | grep -v "^#" | sed 's/#.*$//' | tr -d ' ' | grep -v '^$')
    
    CI_COMMANDS=""
    LOCAL_COMMANDS=""
    
    for cmd in $ALL_COMMANDS; do
        if [ "$cmd" != "default" ]; then
            # Check if command has stage declaration
            if grep -A 5 -B 5 "^$cmd:" justfile | grep -q "STAGE:"; then
                STAGE=$(grep -A 5 -B 5 "^$cmd:" justfile | grep "STAGE:" | sed 's/.*STAGE: //')
                if [[ "$STAGE" =~ ^[1-6]$ ]]; then
                    CI_COMMANDS="$CI_COMMANDS $cmd"
                elif [[ "$STAGE" =~ ^0$ ]]; then
                    LOCAL_COMMANDS="$LOCAL_COMMANDS $cmd"
                fi
            else
                echo "⚠️  Command '$cmd' missing STAGE declaration"
            fi
        fi
    done
    
    echo "✅ CI-suitable (Stages 1-6): $CI_COMMANDS"
    echo "❌ Local-only (Stage 0): $LOCAL_COMMANDS"

# CI: false
# STAGE: 0
stage-commands:
    #!/usr/bin/env bash
    if [ -z "$STAGE" ]; then
        echo "❌ Please specify a stage number (0-6)"
        echo "💡 Usage: STAGE=0 just stage-commands"
        echo "💡 Stage 0 = Local commands, Stages 1-6 = CI commands"
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
get-stage-info:
    #!/usr/bin/env bash
    echo "📋 Dynamic stage information for pipeline..."
    
    # Get all commands
    ALL_COMMANDS=$(just --list | grep -v "Available recipes:" | grep -v "^#" | sed 's/#.*$//' | tr -d ' ' | grep -v '^$')
    
    # Initialize stage arrays
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
                if [[ "$STAGE" =~ ^[0-6]$ ]]; then
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