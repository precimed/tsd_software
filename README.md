# tsd_software
Scripts to fetch specific binaries to be synced to TSD's s3-api dir

## Overview

This repository contains Snakemake workflows to download and unpack bioinformatics binaries including:
- PLINK1 - Whole genome association analysis toolset
- PLINK2 - Next generation of PLINK
- regenie - Fast whole genome regression modelling

## Requirements

- Python 3.6+
- Snakemake
- curl
- unzip

## Installation

Install Snakemake:
```bash
pip install snakemake
```

## Usage

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

Clean downloaded files:
```bash
rm -rf bin/ downloads/
```

## Configuration

Binary versions and download URLs are configured in `config.yaml`. To update a binary version, modify the corresponding entry in this file.

## Output

Binaries are downloaded to the `bin/` directory in the repository root:
- `bin/plink1` - PLINK 1.9 executable
- `bin/plink2` - PLINK 2.0 executable  
- `bin/regenie` - regenie executable

Downloaded archives are stored in `downloads/` directory.

