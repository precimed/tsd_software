#!/bin/bash
# Example usage script for the bioinformatics binary download workflow
# This script demonstrates various ways to use the workflow

set -e

echo "=============================================="
echo "Bioinformatics Binary Download Workflow Demo"
echo "=============================================="
echo ""

# Show help
echo "1. Showing available make targets:"
echo "   $ make help"
echo ""
make help
echo ""

# Dry run
echo "2. Performing a dry-run to see what would be downloaded:"
echo "   $ make dry-run"
echo ""
make dry-run
echo ""

# List rules
echo "3. Listing all Snakemake rules:"
echo "   $ make list"
echo ""
make list
echo ""

# Show configuration
echo "4. Current binary configuration:"
echo "   $ cat config.yaml"
echo ""
cat config.yaml
echo ""

# Download instructions (not executed due to network limitations)
echo "5. To download all binaries (when internet is available):"
echo "   $ make"
echo "   or"
echo "   $ make download"
echo ""

echo "6. To download a specific binary:"
echo "   $ make plink1"
echo "   $ make plink2"
echo "   $ make regenie"
echo ""

echo "7. To verify downloaded binaries (after download):"
echo "   $ ./verify_binaries.sh"
echo ""

echo "8. To clean all downloaded files:"
echo "   $ make clean"
echo ""

echo "9. Using Snakemake directly:"
echo "   $ snakemake --cores 1                 # Download all"
echo "   $ snakemake bin/plink1 --cores 1      # Download PLINK1 only"
echo "   $ snakemake --cores 1 --dry-run       # Dry run"
echo ""

echo "=============================================="
echo "For more information, see:"
echo "  - README.md for general usage"
echo "  - ADDING_BINARIES.md for adding new tools"
echo "  - config.yaml for binary configuration"
echo "=============================================="
