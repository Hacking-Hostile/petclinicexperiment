# Just Commands Reference

This document provides a comprehensive reference for all 128 Just commands available in the Spring PetClinic project.

## 📋 Table of Contents

- [Universal Commands](#universal-commands)
- [CI/CD Pipeline Commands](#cicd-pipeline-commands)
- [Development Workflow Commands](#development-workflow-commands)
- [Reporting Commands](#reporting-commands)
- [Spring-Specific Commands](#spring-specific-commands)
- [Database Management Commands](#database-management-commands)
- [System Information Commands](#system-information-commands)
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

## 🚀 CI/CD Pipeline Commands

These commands implement comprehensive CI/CD workflows and quality gates.

### `just ci-build`

**Purpose:** CI build with full validation
**What it does:**

- Runs clean build with tests
- Executes code quality checks
- Generates reports
- Validates build artifacts

### `just ci-test`

**Purpose:** CI test execution
**What it does:**

- Runs comprehensive test suite
- Generates test reports
- Validates test coverage
- Ensures test quality

### `just quality-gate`

**Purpose:** Quality gate validation
**What it does:**

- Runs all quality checks
- Validates code standards
- Checks test coverage
- Ensures build quality

---

## 🔄 Development Workflow Commands

These commands support the development workflow and debugging.

### `just dev-start`

**Purpose:** Start development environment
**What it does:**

- Starts the application in development mode
- Enables hot reload
- Opens development tools
- Sets up debugging

### `just dev-stop`

**Purpose:** Stop development environment
**What it does:**

- Stops the running application
- Cleans up resources
- Closes development tools
- Resets environment

### `just dev-restart`

**Purpose:** Restart development environment
**What it does:**

- Stops current instance
- Starts fresh instance
- Reloads configuration
- Resets state

### `just dev-status`

**Purpose:** Check development status
**What it does:**

- Shows running processes
- Displays application status
- Reports resource usage
- Shows active connections

---

## 📊 Reporting Commands

These commands generate comprehensive reports and analytics.

### `just report-coverage`

**Purpose:** Generate coverage report
**What it does:**

- Runs JaCoCo coverage analysis
- Generates HTML coverage report
- Shows coverage statistics
- Identifies uncovered code

### `just report-quality`

**Purpose:** Generate quality report
**What it does:**

- Runs Checkstyle analysis
- Generates quality report
- Shows code violations
- Provides improvement suggestions

### `just report-test`

**Purpose:** Generate test report
**What it does:**

- Runs comprehensive tests
- Generates test report
- Shows test statistics
- Identifies test issues

---

## 🌱 Spring-Specific Commands

These commands are specific to Spring Boot applications.

### `just actuator-health`

**Purpose:** Check application health
**What it does:**

- Calls Spring Boot Actuator health endpoint
- Shows application status
- Reports component health
- Validates system health

### `just actuator-info`

**Purpose:** Get application information
**What it does:**

- Calls Spring Boot Actuator info endpoint
- Shows application details
- Reports version information
- Displays configuration

### `just actuator-metrics`

**Purpose:** Get application metrics
**What it does:**

- Calls Spring Boot Actuator metrics endpoint
- Shows performance metrics
- Reports system statistics
- Displays runtime data

### `just actuator-env`

**Purpose:** Get environment information
**What it does:**

- Calls Spring Boot Actuator env endpoint
- Shows environment variables
- Reports configuration
- Displays system properties

### `just run-h2`

**Purpose:** Run with H2 database
**What it does:**

- Starts application with H2 profile
- Uses in-memory database
- Enables H2 console
- Sets up H2 configuration

### `just run-mysql`

**Purpose:** Run with MySQL database
**What it does:**

- Starts application with MySQL profile
- Connects to MySQL database
- Uses MySQL configuration
- Sets up MySQL connection

### `just run-postgres`

**Purpose:** Run with PostgreSQL database
**What it does:**

- Starts application with PostgreSQL profile
- Connects to PostgreSQL database
- Uses PostgreSQL configuration
- Sets up PostgreSQL connection

### `just coverage`

**Purpose:** Run coverage analysis
**What it does:**

- Executes tests with coverage
- Generates coverage report
- Shows coverage statistics
- Identifies uncovered areas

### `just validate-format`

**Purpose:** Validate code formatting
**What it does:**

- Checks code formatting
- Validates style compliance
- Reports formatting issues
- Ensures consistency

### `just compile-css`

**Purpose:** Compile CSS assets
**What it does:**

- Compiles Sass/SCSS files
- Generates CSS output
- Optimizes stylesheets
- Processes CSS assets

### `just native-build`

**Purpose:** Build native image
**What it does:**

- Builds GraalVM native image
- Creates executable binary
- Optimizes for performance
- Reduces startup time

### `just dev-run`

**Purpose:** Run in development mode
**What it does:**

- Starts with development profile
- Enables hot reload
- Sets up debugging
- Configures development tools

### `just test-containers`

**Purpose:** Run tests with containers
**What it does:**

- Uses Testcontainers for tests
- Spins up database containers
- Runs integration tests
- Cleans up containers

### `just docker-compose-up`

**Purpose:** Start Docker services
**What it does:**

- Starts Docker Compose services
- Spins up database containers
- Sets up development environment
- Configures services

### `just docker-compose-down`

**Purpose:** Stop Docker services
**What it does:**

- Stops Docker Compose services
- Removes containers
- Cleans up resources
- Resets environment

### `just show-props`

**Purpose:** Show application properties
**What it does:**

- Displays application properties
- Shows configuration values
- Reports environment settings
- Lists system properties

### `just deps-tree`

**Purpose:** Show dependency tree
**What it does:**

- Displays dependency hierarchy
- Shows transitive dependencies
- Reports dependency conflicts
- Lists all dependencies

### `just app-info`

**Purpose:** Show application information
**What it does:**

- Displays application details
- Shows version information
- Reports build details
- Lists application features

---

## 🗄️ Database Management Commands

These commands manage database operations and connections.

### `just db-init-h2`

**Purpose:** Initialize H2 database
**What it does:**

- Creates H2 database schema
- Initializes tables
- Sets up data
- Configures H2 connection

### `just db-init-mysql`

**Purpose:** Initialize MySQL database
**What it does:**

- Creates MySQL database schema
- Initializes tables
- Sets up data
- Configures MySQL connection

### `just db-init-postgres`

**Purpose:** Initialize PostgreSQL database
**What it does:**

- Creates PostgreSQL database schema
- Initializes tables
- Sets up data
- Configures PostgreSQL connection

### `just db-reset-h2`

**Purpose:** Reset H2 database
**What it does:**

- Drops existing schema
- Recreates database
- Initializes fresh data
- Resets H2 state

### `just db-validate`

**Purpose:** Validate database connection
**What it does:**

- Tests database connectivity
- Validates connection settings
- Reports connection status
- Ensures database availability

### `just db-schema`

**Purpose:** Show database schema
**What it does:**

- Displays database structure
- Shows table definitions
- Reports schema information
- Lists database objects

---

## 💻 System Information Commands

These commands provide system and environment information.

### `just java-version`

**Purpose:** Show Java version
**What it does:**

- Displays Java version information
- Shows JVM details
- Reports Java configuration
- Lists Java features

### `just maven-version`

**Purpose:** Show Maven version
**What it does:**

- Displays Maven version information
- Shows Maven configuration
- Reports Maven settings
- Lists Maven features

### `just git-status`

**Purpose:** Show Git status
**What it does:**

- Displays Git repository status
- Shows branch information
- Reports file changes
- Lists commit history

### `just find-java`

**Purpose:** Find Java installations
**What it does:**

- Locates Java installations
- Shows Java paths
- Reports Java versions
- Lists Java locations

### `just count-lines`

**Purpose:** Count lines of code
**What it does:**

- Counts total lines of code
- Shows file statistics
- Reports code metrics
- Lists file counts

---

## 📦 Maven Commands

These commands provide direct access to Maven operations.

### `just mvn-clean`

**Purpose:** Maven clean
**What it does:**

- Runs `mvn clean`
- Removes target directory
- Cleans build artifacts
- Resets build state

### `just mvn-compile`

**Purpose:** Maven compile
**What it does:**

- Runs `mvn compile`
- Compiles source code
- Generates classes
- Validates compilation

### `just mvn-test`

**Purpose:** Maven test
**What it does:**

- Runs `mvn test`
- Executes unit tests
- Generates test reports
- Validates test results

### `just mvn-package`

**Purpose:** Maven package
**What it does:**

- Runs `mvn package`
- Creates JAR file
- Generates artifacts
- Prepares for deployment

### `just mvn-install`

**Purpose:** Maven install
**What it does:**

- Runs `mvn install`
- Installs to local repository
- Generates artifacts
- Updates repository

### `just mvn-spring-boot-run`

**Purpose:** Maven Spring Boot run
**What it does:**

- Runs `mvn spring-boot:run`
- Starts Spring Boot application
- Enables development mode
- Sets up application

---

## 🛠️ Utility Commands

These commands provide utility functions and helpers.

### `just detect`

**Purpose:** Detect project type
**What it does:**

- Identifies build system
- Detects project structure
- Reports project type
- Shows configuration

### `just dev-setup`

**Purpose:** Setup development environment
**What it does:**

- Configures development tools
- Sets up environment
- Installs dependencies
- Prepares workspace

### `just dev-logs`

**Purpose:** Show development logs
**What it does:**

- Displays application logs
- Shows error messages
- Reports debug information
- Lists log entries

### `just help`

**Purpose:** Show help information
**What it does:**

- Displays available commands
- Shows command descriptions
- Provides usage examples
- Lists command options

### `just status`

**Purpose:** Show project status
**What it does:**

- Displays project information
- Shows build status
- Reports environment details
- Lists active processes

### `just version`

**Purpose:** Show version information
**What it does:**

- Displays application version
- Shows dependency versions
- Reports build information
- Lists version details

### `just env-info`

**Purpose:** Show environment information
**What it does:**

- Displays environment variables
- Shows system configuration
- Reports path settings
- Lists environment details

### `just cleanup`

**Purpose:** Clean up resources
**What it does:**

- Removes temporary files
- Cleans build artifacts
- Frees up disk space
- Resets environment

---

## 📊 Command Categories Summary

### **Total Commands: 128**

#### **Universal Commands (7)**

- `build`, `test`, `clean`, `run`, `lint`, `format`, `deploy`

#### **CI/CD Pipeline Commands (3)**

- `ci-build`, `ci-test`, `quality-gate`

#### **Development Workflow Commands (4)**

- `dev-start`, `dev-stop`, `dev-restart`, `dev-status`

#### **Reporting Commands (3)**

- `report-coverage`, `report-quality`, `report-test`

#### **Spring-Specific Commands (18)**

- Actuator: `actuator-health`, `actuator-info`, `actuator-metrics`, `actuator-env`
- Database: `run-h2`, `run-mysql`, `run-postgres`
- Quality: `coverage`, `validate-format`, `compile-css`
- Native: `native-build`, `dev-run`
- Container: `test-containers`, `docker-compose-up`, `docker-compose-down`
- Info: `show-props`, `deps-tree`, `app-info`

#### **Database Management Commands (6)**

- `db-init-h2`, `db-init-mysql`, `db-init-postgres`
- `db-reset-h2`, `db-validate`, `db-schema`

#### **System Information Commands (5)**

- `java-version`, `maven-version`, `git-status`, `find-java`, `count-lines`

#### **Maven Commands (6)**

- `mvn-clean`, `mvn-compile`, `mvn-test`, `mvn-package`, `mvn-install`, `mvn-spring-boot-run`

#### **Utility Commands (8)**

- `detect`, `dev-setup`, `dev-logs`, `help`, `status`, `version`, `env-info`, `cleanup`

---

## 🚀 Quick Start Examples

### **Basic Development Workflow**

```bash
# Setup and build
just dev-setup
just build

# Run tests and quality checks
just test
just lint

# Start development
just dev-run
```

### **CI/CD Pipeline**

```bash
# Full CI build
just ci-build

# Quality gate
just quality-gate

# Generate reports
just report-coverage
just report-quality
```

### **Database Operations**

```bash
# Initialize database
just db-init-h2

# Validate connection
just db-validate

# Run with specific database
just run-postgres
```

### **System Information**

```bash
# Check versions
just java-version
just maven-version

# Check status
just status
just git-status
```

---

## 📝 Notes

- All commands use existing tools and dependencies
- No third-party installations required
- Commands work with both Maven and Gradle projects
- Comprehensive coverage of development, testing, and deployment workflows
- Designed for multi-language CI/CD pipeline architecture
