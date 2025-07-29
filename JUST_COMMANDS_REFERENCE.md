# Just Commands Reference - Spring PetClinic

## Overview

This document provides a comprehensive reference for all `just` commands available in the Spring PetClinic project. The commands are organized by category and include descriptions, usage examples, and requirements.

## Quick Start

```bash
# Setup environment (run once)
source setup-env.sh

# Show all available commands
just --list

# Get help
just help

# Build the application
just build

# Run tests
just test

# Start the application
just run

# Clean the project
just clean
```

## Setup Instructions

### For All Users

1. **Run the setup script once** to configure your environment:

   ```bash
   source setup-env.sh
   ```

2. **Verify setup** by running:

   ```bash
   just detect
   ```

3. **Start using commands**:
   ```bash
   just build
   just run
   ```

## Command Categories

### 🔨 Universal Commands (Cross-platform, build-tool agnostic)

| Command  | Description                          | Usage         |
| -------- | ------------------------------------ | ------------- |
| `build`  | Build the application (Maven/Gradle) | `just build`  |
| `test`   | Run tests (Maven/Gradle)             | `just test`   |
| `clean`  | Clean the project (Maven/Gradle)     | `just clean`  |
| `run`    | Start the application (Maven/Gradle) | `just run`    |
| `lint`   | Run code quality checks              | `just lint`   |
| `format` | Format code                          | `just format` |
| `deploy` | Deploy the application               | `just deploy` |

### 📦 Essential Maven Commands

| Command        | Description            | Usage               |
| -------------- | ---------------------- | ------------------- |
| `mvn-validate` | Validate Maven project | `just mvn-validate` |
| `mvn-verify`   | Verify Maven project   | `just mvn-verify`   |
| `mvn-site`     | Generate Maven site    | `just mvn-site`     |

### 🗄️ Database Commands

| Command       | Description            | Usage              |
| ------------- | ---------------------- | ------------------ |
| `run-h2`      | Run with H2 database   | `just run-h2`      |
| `db-init-h2`  | Initialize H2 database | `just db-init-h2`  |
| `db-reset-h2` | Reset H2 database      | `just db-reset-h2` |
| `db-schema`   | Show database schema   | `just db-schema`   |

### 📊 Code Quality and Coverage

| Command            | Description                    | Usage                   |
| ------------------ | ------------------------------ | ----------------------- |
| `coverage`         | Generate code coverage report  | `just coverage`         |
| `nohttp-check`     | Check for HTTP URLs (security) | `just nohttp-check`     |
| `cyclonedx-report` | Generate CycloneDX SBOM report | `just cyclonedx-report` |

### 📦 Build and Package Commands

| Command       | Description       | Usage              |
| ------------- | ----------------- | ------------------ |
| `jar-info`    | Get JAR file info | `just jar-info`    |
| `jar-verify`  | Verify JAR file   | `just jar-verify`  |
| `jar-extract` | Extract JAR file  | `just jar-extract` |
| `fat-jar`     | Create fat JAR    | `just fat-jar`     |

### 🌍 System and Environment Commands

| Command         | Description              | Usage                |
| --------------- | ------------------------ | -------------------- |
| `java-version`  | Show Java version        | `just java-version`  |
| `maven-version` | Show Maven version       | `just maven-version` |
| `status`        | Show project status      | `just status`        |
| `version`       | Show version information | `just version`       |
| `env-info`      | Show environment info    | `just env-info`      |

### 📁 File and Directory Commands

| Command          | Description         | Usage                 |
| ---------------- | ------------------- | --------------------- |
| `find-java`      | Find Java files     | `just find-java`      |
| `find-resources` | Find resource files | `just find-resources` |
| `find-tests`     | Find test files     | `just find-tests`     |
| `count-lines`    | Count lines of code | `just count-lines`    |

### 🔧 Utility Commands

| Command   | Description              | Usage          |
| --------- | ------------------------ | -------------- |
| `cleanup` | Clean up temporary files | `just cleanup` |
| `help`    | Show help information    | `just help`    |

### 🚀 Development Commands

| Command      | Description                   | Usage             |
| ------------ | ----------------------------- | ----------------- |
| `dev-setup`  | Setup development environment | `just dev-setup`  |
| `dev-status` | Check development status      | `just dev-status` |
| `dev-stop`   | Stop development environment  | `just dev-stop`   |

### 🔍 Detection and Setup

| Command  | Description                   | Usage         |
| -------- | ----------------------------- | ------------- |
| `detect` | Detect project type and tools | `just detect` |

## Quick Examples

### Basic Development Workflow

```bash
# Setup environment
source setup-env.sh

# Build the application
just build

# Run tests
just test

# Start the application
just run

# Check status
just status
```

### Database Operations

```bash
# Run with H2 database
just run-h2

# Initialize H2 database
just db-init-h2

# View database schema
just db-schema
```

### Code Quality

```bash
# Format code
just format

# Run linting
just lint

# Generate coverage report
just coverage

# Check for HTTP URLs
just nohttp-check
```

### System Information

```bash
# Check Java and Maven versions
just java-version
just maven-version

# Get project status
just status

# View environment info
just env-info

# Detect project type
just detect
```

## Requirements

### Prerequisites

- **Java**: JDK 8+ (JDK 24 recommended)
- **Maven**: 3.6+ (or Maven wrapper)
- **Just**: Command runner (install via `scoop install just` on Windows)
- **Git**: Version control

### Optional Tools

- **jq**: JSON processor (for some commands)
- **curl**: HTTP client (for some commands)

## Troubleshooting

### Common Issues

1. **"just: command not found"**

   ```bash
   # Add just to PATH
   export PATH="/c/Users/krato/scoop/shims:$PATH"
   # Or run setup script
   source setup-env.sh
   ```

2. **"Maven not found"**

   ```bash
   # Run setup script
   source setup-env.sh
   ```

3. **"Java version mismatch"**
   ```bash
   # Check Java version
   just java-version
   # Ensure JAVA_HOME is set correctly
   ```

### Getting Help

```bash
# Show all commands
just --list

# Get help
just help

# Check project status
just status

# Detect environment
just detect
```

## Cross-Platform Compatibility

All commands are designed to work across different platforms:

- **Windows**: Tested and working
- **macOS**: Should work with standard tools
- **Linux**: Should work with standard tools

The commands use:

- Standard shell commands
- Cross-platform Maven wrapper (`./mvnw`)
- Environment variable detection
- Fallback mechanisms

## Summary

This cleaned-up justfile provides **39 essential commands** that cover all core functionality without redundancy:

- ✅ **7 Universal Commands** (build, test, clean, run, lint, format, deploy)
- ✅ **3 Essential Maven Commands** (validate, verify, site)
- ✅ **4 Database Commands** (H2 operations)
- ✅ **3 Quality Commands** (coverage, security, SBOM)
- ✅ **4 Build Commands** (JAR operations)
- ✅ **5 System Commands** (version, status, environment)
- ✅ **4 File Commands** (find, count)
- ✅ **3 Utility Commands** (cleanup, help)
- ✅ **3 Development Commands** (setup, status, stop)
- ✅ **1 Detection Command** (detect)

**Total: 39 essential, non-redundant commands** (down from 94 redundant commands)
