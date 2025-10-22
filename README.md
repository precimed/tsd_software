# tsd_software
Scripts to fetch specific binaries to be synced to TSD's s3-api dir

## Overview

This repository contains Snakemake workflows to download and unpack bioinformatics binaries including:
- **PLINK1** - Whole genome association analysis toolset (version 20250819)
- **PLINK2** - Next generation of PLINK (version 20251019)
- **regenie** - Fast whole genome regression modelling (version 4.1)

## Requirements

- Python 3.6+
- Snakemake
- curl (for downloading)
- unzip (for unpacking archives)

## Installation

Install Snakemake using pip in the current Python environment:
```bash
pip install snakemake
```

Or using conda/mamba:
```bash
mamba install -c conda-forge -c bioconda snakemake
```

Or using the provided conda environment file:
```bash
conda env create -f environment.yaml
conda activate tsd_software
```

## Usage

### Using Make (recommended)

The easiest way to use this workflow is via the provided Makefile:

```bash
# Download and unpack all binaries
make

# Download specific binaries
make plink1
make plink2
make regenie

# Show what would be downloaded without downloading
make dry-run

# Clean all downloaded files
make clean

# Show available commands
make help
```

### Using Snakemake directly

Run the workflow to download and unpack all binaries:
```bash
snakemake --cores 1
```

Download specific binaries:
```bash
snakemake bin/plink1 --cores 1
snakemake bin/plink2 --cores 1
snakemake bin/regenie --cores 1
```

Perform a dry run to see what would be downloaded:
```bash
snakemake --cores 1 --dry-run
```

Clean downloaded files:
```bash
rm -rf bin/ downloads/
```

### Verifying Downloads

After downloading, verify the binaries are correctly installed:
```bash
./verify_binaries.sh
```

This will check that all binaries exist, are executable, and display version information.

## Configuration

Binary versions and download URLs are configured in `config.yaml`. To update a binary version:

1. Edit `config.yaml`
2. Update the `version` and `url` fields for the desired binary
3. Run `make clean` to remove old binaries
4. Run `make` to download the new version

Example configuration entry:
```yaml
binaries:
  plink1:
    version: "20231211"
    url: "https://s3.amazonaws.com/plink1-assets/plink_linux_x86_64_20231211.zip"
    executable: "plink"
    description: "PLINK 1.9 - Whole genome association analysis toolset"
```

## Output

Binaries are downloaded to the `bin/` directory in the repository root:
- `bin/plink1` - PLINK 1.9 executable
- `bin/plink2` - PLINK 2.0 executable  
- `bin/regenie` - regenie executable

Downloaded archives are stored in the `downloads/` directory (can be safely deleted after unpacking).

## Workflow Structure

The Snakemake workflow consists of:

1. **download_binary** - Downloads binary archives from configured URLs
2. **unpack_binary** - Unpacks archives and renames executables as needed
3. **all** - Default rule that downloads and unpacks all binaries

The workflow automatically:
- Creates necessary directories (`bin/`, `downloads/`)
- Downloads archives only if not already present
- Unpacks binaries only if not already present
- Makes binaries executable
- Handles renaming of executables to standard names

## Troubleshooting

### Download failures
If downloads fail, check:
- Internet connectivity
- The URLs in `config.yaml` are still valid
- You have write permissions in the repository directory

### Binary not executable
If a binary exists but is not executable, run:
```bash
chmod +x bin/plink1 bin/plink2 bin/regenie
```

### Re-downloading binaries
To force re-download of binaries:
```bash
make clean
make
```

## License

See LICENSE file for details.

