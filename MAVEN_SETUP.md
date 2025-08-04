# Maven Setup Instructions

## 🎯 Goal
Set up Maven locally to avoid downloads during CI/CD pipeline execution.

## 📋 Current Status
- ✅ Maven wrapper (`mvnw`) is present
- ✅ Gradle wrapper (`gradlew`) is present  
- ❌ Maven wrapper tries to download Maven (causing delays/failures)

## 🔧 Solution Options

### Option 1: Manual Maven Installation (Recommended)

1. **Download Maven 3.9.10**:
   - Go to: https://archive.apache.org/dist/maven/maven-3/3.9.10/binaries/
   - Download: `apache-maven-3.9.10-bin.tar.gz`

2. **Extract to project**:
   ```bash
   # Create tools directory
   mkdir -p tools
   
   # Extract Maven
   tar -xzf apache-maven-3.9.10-bin.tar.gz -C tools/
   mv tools/apache-maven-3.9.10 tools/maven
   ```

3. **Verify installation**:
   ```bash
   tools/maven/bin/mvn -version
   ```

### Option 2: Use PowerShell Script

```powershell
# Run the PowerShell script
.\setup-maven.ps1
```

### Option 3: Use Bash Script

```bash
# Run the bash script
./setup-maven.sh
```

## 🚀 After Setup

Once Maven is installed in `tools/maven/`, the justfile will automatically use it:

```bash
# Test that it works
just build
just test
just ci
```

## 📁 Expected Structure

```
project/
├── tools/
│   └── maven/
│       ├── bin/
│       │   └── mvn
│       ├── boot/
│       ├── conf/
│       └── lib/
├── mvnw
├── gradlew
└── justfile
```

## 🎉 Benefits

- ✅ No downloads during CI/CD
- ✅ Faster pipeline execution
- ✅ Reliable builds
- ✅ Works offline
- ✅ Consistent Maven version across environments

## 🔍 Verification

After setup, running `just get-mvn-cmd` should return:
```
./tools/maven/bin/mvn
```

Instead of:
```
./mvnw
``` 