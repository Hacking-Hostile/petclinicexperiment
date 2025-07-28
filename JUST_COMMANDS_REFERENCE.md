# Just Commands Reference

This document provides a comprehensive reference for all Just commands available in the Spring PetClinic project.

## 📋 Table of Contents

- [Universal Commands](#universal-commands)
- [Spring-Specific Commands](#spring-specific-commands)
- [Maven Commands](#maven-commands)
- [Utility Commands](#utility-commands)
- [Command Categories Summary](#command-categories-summary)

---

## 🔧 Universal Commands

These commands work across different build systems (Maven/Gradle) and are language-agnostic.

### `just build`

**Purpose:** Build the application
**What it does:**

- Detects the build system (Maven/Gradle)
- Runs `mvn clean package -DskipTests` for Maven projects
- Runs `./gradlew build -x test` for Gradle projects
- Creates executable JAR file

### `just test`

**Purpose:** Run all tests
**What it does:**

- Executes all unit and integration tests
- Runs `mvn test` for Maven projects
- Runs `./gradlew test` for Gradle projects
- Shows test results and coverage

### `just clean`

**Purpose:** Clean build artifacts
**What it does:**

- Removes compiled classes and generated files
- Runs `mvn clean` for Maven projects
- Runs `./gradlew clean` for Gradle projects
- Frees up disk space

### `just run`

**Purpose:** Start the application
**What it does:**

- Runs the built JAR file if available
- Falls back to `mvn spring-boot:run` for Maven
- Falls back to `./gradlew bootRun` for Gradle
- Starts the application on localhost:8080

### `just lint`

**Purpose:** Run code quality checks
**What it does:**

- Runs Checkstyle validation
- Checks code formatting and style
- Reports violations and issues
- Ensures code quality standards

### `just format`

**Purpose:** Format code automatically
**What it does:**

- Applies Spring Java Format to code
- Runs `mvn spring-javaformat:apply` for Maven
- Runs `./gradlew formatMain` for Gradle
- Standardizes code formatting

### `just deploy`

**Purpose:** Deploy the application
**What it does:**

- Builds the application for deployment
- Prepares deployment artifacts
- Provides manual deployment instructions
- Suggests Docker deployment option

---

## 🌱 Spring-Specific Commands

These commands are specifically designed for Spring Boot applications and leverage Spring Boot features.

### Spring Boot Actuator Commands

#### `just actuator-health`

**Purpose:** Check application health
**What it does:**

- Calls `/actuator/health` endpoint
- Returns application health status
- Shows if application is running properly
- Requires application to be running

#### `just actuator-info`

**Purpose:** Get application information
**What it does:**

- Calls `/actuator/info` endpoint
- Returns build and application info
- Shows version, build time, etc.
- Requires application to be running

#### `just actuator-metrics`

**Purpose:** Get application metrics
**What it does:**

- Calls `/actuator/metrics` endpoint
- Returns performance metrics
- Shows JVM, HTTP, and custom metrics
- Requires application to be running

#### `just actuator-env`

**Purpose:** Get environment information
**What it does:**

- Calls `/actuator/env` endpoint
- Returns environment variables
- Shows configuration properties
- Requires application to be running

### Database Profile Commands

#### `just run-h2`

**Purpose:** Run with H2 database
**What it does:**

- Starts application with H2 in-memory database
- Uses `spring.profiles.active=h2`
- Default database for development
- No external database required

#### `just run-mysql`

**Purpose:** Run with MySQL database
**What it does:**

- Starts application with MySQL database
- Uses `spring.profiles.active=mysql`
- Requires MySQL server running
- Uses configuration from `application-mysql.properties`

#### `just run-postgres`

**Purpose:** Run with PostgreSQL database
**What it does:**

- Starts application with PostgreSQL database
- Uses `spring.profiles.active=postgres`
- Requires PostgreSQL server running
- Uses configuration from `application-postgres.properties`

### Code Quality & Coverage Commands

#### `just coverage`

**Purpose:** Run code coverage analysis
**What it does:**

- Runs tests with JaCoCo coverage
- Generates coverage report
- Creates HTML report at `target/site/jacoco/index.html`
- Shows line, branch, and method coverage

#### `just validate-format`

**Purpose:** Validate code formatting
**What it does:**

- Checks if code follows Spring Java Format
- Validates without making changes
- Reports formatting violations
- Ensures consistent code style

#### `just compile-css`

**Purpose:** Compile SCSS to CSS
**What it does:**

- Compiles SCSS files using LibSass
- Processes Bootstrap SCSS files
- Generates compiled CSS files
- Uses Maven profile `-Pcss`

### Native & Development Commands

#### `just native-build`

**Purpose:** Build native image
**What it does:**

- Creates GraalVM native image
- Uses Spring Boot native support
- Generates optimized executable
- Requires GraalVM installation

#### `just dev-run`

**Purpose:** Run with development tools
**What it does:**

- Enables Spring Boot DevTools
- Enables automatic restart on changes
- Provides development-friendly features
- Uses `spring.devtools.restart.enabled=true`

### Container & Docker Commands

#### `just test-containers`

**Purpose:** Run tests with containers
**What it does:**

- Runs tests using Testcontainers
- Spins up database containers for tests
- Ensures isolated test environment
- Uses Docker for test databases

#### `just docker-compose-up`

**Purpose:** Start Docker services
**What it does:**

- Starts services defined in `docker-compose.yml`
- Launches database containers
- Sets up development environment
- Runs in detached mode (`-d`)

#### `just docker-compose-down`

**Purpose:** Stop Docker services
**What it does:**

- Stops all running containers
- Removes containers and networks
- Cleans up Docker resources
- Shuts down development environment

### Application Info Commands

#### `just show-props`

**Purpose:** Show application properties
**What it does:**

- Displays Spring Boot configuration
- Shows active profiles and properties
- Runs with `--debug` flag
- Shows first 20 debug lines

#### `just deps-tree`

**Purpose:** Show dependency tree
**What it does:**

- Displays Maven dependency tree
- Shows all project dependencies
- Helps identify dependency conflicts
- Useful for dependency analysis

#### `just app-info`

**Purpose:** Get application information
**What it does:**

- Shows application startup info
- Displays Spring Boot banner
- Shows active profiles
- Runs with `--info` flag

---

## 📦 Maven Commands

Direct Maven commands for fine-grained control.

### `just mvn-clean`

**Purpose:** Maven clean
**What it does:** Removes target directory and compiled files

### `just mvn-compile`

**Purpose:** Maven compile
**What it does:** Compiles source code to target directory

### `just mvn-test`

**Purpose:** Maven test
**What it does:** Runs all tests in the project

### `just mvn-package`

**Purpose:** Maven package
**What it does:** Creates JAR file in target directory

### `just mvn-install`

**Purpose:** Maven install
**What it does:** Installs JAR to local Maven repository

### `just mvn-spring-boot-run`

**Purpose:** Run with Spring Boot Maven plugin
**What it does:** Starts application using Spring Boot Maven plugin

---

## 🔧 Utility Commands

Helper commands for development and debugging.

### `just detect`

**Purpose:** Detect project type
**What it does:**

- Identifies build system (Maven/Gradle)
- Shows available commands
- Detects project structure
- Provides project information

### `just dev-setup`

**Purpose:** Setup development environment
**What it does:**

- Checks Java version
- Checks Maven version
- Verifies environment setup
- Shows development tools status

### `just dev-logs`

**Purpose:** Show application logs
**What it does:**

- Displays recent application logs
- Shows real-time log output
- Helps with debugging
- Monitors application status

### `just help`

**Purpose:** Show help information
**What it does:**

- Lists all available commands
- Shows command categories
- Provides usage information
- Displays command descriptions

---

## 📊 Command Categories Summary

| Category            | Commands | Description                                  |
| ------------------- | -------- | -------------------------------------------- |
| **Universal**       | 7        | Cross-platform build and deployment commands |
| **Spring-Specific** | 18       | Spring Boot specific features and tools      |
| **Maven**           | 6        | Direct Maven plugin commands                 |
| **Utility**         | 4        | Development and debugging helpers            |
| **Total**           | **35**   | Complete command set                         |

### Command Distribution

- **Actuator Commands:** 4 (Health, Info, Metrics, Environment)
- **Database Commands:** 3 (H2, MySQL, PostgreSQL)
- **Quality Commands:** 3 (Coverage, Format Validation, CSS Compilation)
- **Development Commands:** 2 (Native Build, Dev Tools)
- **Container Commands:** 3 (Test Containers, Docker Compose Up/Down)
- **Info Commands:** 3 (Properties, Dependencies, Application Info)

---

## 🚀 Quick Start Examples

### Basic Development Workflow

```bash
# Setup and build
just dev-setup
just build

# Run with default database
just run-h2

# Check health
just actuator-health
```

### Testing and Quality

```bash
# Run tests
just test

# Check code coverage
just coverage

# Validate formatting
just validate-format
```

### Database Switching

```bash
# Run with different databases
just run-h2      # In-memory database
just run-mysql   # MySQL database
just run-postgres # PostgreSQL database
```

### Container Development

```bash
# Start services
just docker-compose-up

# Run tests with containers
just test-containers

# Stop services
just docker-compose-down
```

---

## 📝 Notes

- All commands use Java 24 and Maven 3.9.11
- Commands are configured for Windows environment
- Spring Boot Actuator endpoints require application to be running
- Some commands may fail if JAR file is in use by another process
- Docker commands require Docker to be installed and running

---

_This documentation covers all 35 Just commands available in the Spring PetClinic project. Each command is designed to simplify common development tasks and provide a consistent interface across different build systems._
