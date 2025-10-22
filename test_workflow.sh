#!/bin/bash
# Comprehensive test of the workflow implementation

echo "====================================="
echo "Testing Snakemake Workflow"
echo "====================================="
echo ""

# Test 1: Check files exist
echo "Test 1: Verifying all required files exist..."
files=(
    "Snakefile"
    "config.yaml"
    "Makefile"
    "README.md"
    "ADDING_BINARIES.md"
    "verify_binaries.sh"
    "example_usage.sh"
    ".github/workflows/test-downloads.yml"
)

all_exist=true
for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "  ✓ $file"
    else
        echo "  ✗ $file (MISSING)"
        all_exist=false
    fi
done

if [ "$all_exist" = true ]; then
    echo "  Result: PASSED"
else
    echo "  Result: FAILED"
    exit 1
fi
echo ""

# Test 2: Check Snakefile syntax
echo "Test 2: Checking Snakefile syntax..."
if snakemake --list-rules > /dev/null 2>&1; then
    echo "  ✓ Snakefile syntax valid"
    echo "  Result: PASSED"
else
    echo "  ✗ Snakefile has syntax errors"
    echo "  Result: FAILED"
    exit 1
fi
echo ""

# Test 3: Check config.yaml is valid
echo "Test 3: Checking config.yaml validity..."
python3 -c "import yaml; yaml.safe_load(open('config.yaml'))" 2>/dev/null
if [ $? -eq 0 ]; then
    echo "  ✓ config.yaml is valid YAML"
    echo "  Result: PASSED"
else
    echo "  ✗ config.yaml has syntax errors"
    echo "  Result: FAILED"
    exit 1
fi
echo ""

# Test 4: Verify binaries in config
echo "Test 4: Checking configured binaries..."
binaries=$(python3 -c "import yaml; c=yaml.safe_load(open('config.yaml')); print(','.join(c['binaries'].keys()))")
echo "  Configured binaries: $binaries"
expected="plink1,plink2,regenie"
if [ "$binaries" = "$expected" ]; then
    echo "  ✓ All expected binaries configured"
    echo "  Result: PASSED"
else
    echo "  ✗ Unexpected binaries (expected: $expected)"
    echo "  Result: FAILED"
    exit 1
fi
echo ""

# Test 5: Dry run
echo "Test 5: Running workflow dry-run..."
if snakemake --cores 1 --dry-run > /dev/null 2>&1; then
    echo "  ✓ Dry run successful"
    echo "  Result: PASSED"
else
    echo "  ✗ Dry run failed"
    echo "  Result: FAILED"
    exit 1
fi
echo ""

# Test 6: Check Makefile targets
echo "Test 6: Checking Makefile targets..."
targets=("help" "list" "dry-run")
all_work=true
for target in "${targets[@]}"; do
    if make $target > /dev/null 2>&1; then
        echo "  ✓ make $target"
    else
        echo "  ✗ make $target (FAILED)"
        all_work=false
    fi
done

if [ "$all_work" = true ]; then
    echo "  Result: PASSED"
else
    echo "  Result: FAILED"
    exit 1
fi
echo ""

# Test 7: Check scripts are executable
echo "Test 7: Checking script permissions..."
scripts=("verify_binaries.sh" "example_usage.sh")
all_exec=true
for script in "${scripts[@]}"; do
    if [ -x "$script" ]; then
        echo "  ✓ $script is executable"
    else
        echo "  ✗ $script is not executable"
        all_exec=false
    fi
done

if [ "$all_exec" = true ]; then
    echo "  Result: PASSED"
else
    echo "  Result: FAILED"
    exit 1
fi
echo ""

echo "====================================="
echo "All tests PASSED!"
echo "====================================="
echo ""
echo "The Snakemake workflow is ready to use."
echo "Run 'make' or 'snakemake --cores 1' to download binaries."
