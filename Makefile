# Makefile for managing bioinformatics binaries

.PHONY: all download clean help test

# Default target
all: download

# Download and unpack all binaries
download:
	@echo "Downloading and unpacking binaries..."
	snakemake --cores 1

# Download specific binaries
plink1:
	snakemake bin/plink1 --cores 1

plink2:
	snakemake bin/plink2 --cores 1

regenie:
	snakemake bin/regenie --cores 1

# Clean downloaded files and binaries
clean:
	@echo "Cleaning downloaded files..."
	rm -rf bin/ downloads/
	rm -rf .snakemake/

# Show what would be downloaded
dry-run:
	snakemake --cores 1 --dry-run

# List all rules
list:
	snakemake --list-rules

# Show help
help:
	@echo "Available targets:"
	@echo "  all       - Download and unpack all binaries (default)"
	@echo "  download  - Download and unpack all binaries"
	@echo "  plink1    - Download and unpack PLINK1 only"
	@echo "  plink2    - Download and unpack PLINK2 only"
	@echo "  regenie   - Download and unpack regenie only"
	@echo "  clean     - Remove downloaded files and binaries"
	@echo "  dry-run   - Show what would be downloaded without actually downloading"
	@echo "  list      - List all available rules"
	@echo "  help      - Show this help message"
