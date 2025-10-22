#!/bin/bash
# Script to verify downloaded binaries

set -e

BIN_DIR="bin"

echo "Verifying downloaded binaries..."
echo "================================"

# Check if bin directory exists
if [ ! -d "$BIN_DIR" ]; then
    echo "ERROR: bin/ directory not found. Run 'make download' first."
    exit 1
fi

# Function to check a binary
check_binary() {
    local name=$1
    local path="$BIN_DIR/$name"
    
    echo -n "Checking $name... "
    if [ -f "$path" ]; then
        if [ -x "$path" ]; then
            echo "✓ Found and executable"
            # Try to get version info
            case $name in
                plink1)
                    "$path" --version 2>&1 | head -1 || echo "  (version info unavailable)"
                    ;;
                plink2)
                    "$path" --version 2>&1 | head -1 || echo "  (version info unavailable)"
                    ;;
                regenie)
                    "$path" --version 2>&1 | head -1 || echo "  (version info unavailable)"
                    ;;
            esac
        else
            echo "✗ Found but not executable"
            return 1
        fi
    else
        echo "✗ Not found"
        return 1
    fi
}

# Check all binaries
PASSED=0
FAILED=0

# Disable exit on error
set +e

for binary in plink1 plink2 regenie; do
    if check_binary "$binary"; then
        ((PASSED++))
    else
        ((FAILED++))
    fi
done

echo ""
echo "Results: $PASSED passed, $FAILED failed"

if [ $FAILED -gt 0 ]; then
    exit 1
fi
