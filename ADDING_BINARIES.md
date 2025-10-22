# Adding New Binaries

This document explains how to add new bioinformatics binaries to the workflow.

## Steps to Add a New Binary

1. **Find the download URL**: Locate the direct download URL for the Linux x86_64 version of the binary (usually a .zip file)

2. **Edit config.yaml**: Add a new entry under `binaries:` following the existing pattern

3. **Run the workflow**: Execute `make` or `snakemake --cores 1` to download the new binary

## Example: Adding bcftools

To add bcftools to the workflow, edit `config.yaml`:

```yaml
binaries:
  # ... existing entries ...
  
  bcftools:
    version: "1.19"
    url: "https://github.com/samtools/bcftools/releases/download/1.19/bcftools-1.19-linux-x86_64.tar.bz2"
    executable: "bcftools"
    description: "BCFtools - utilities for variant calling and manipulating VCFs and BCFs"
```

Then run:
```bash
make bcftools
```

Or to download all binaries including the new one:
```bash
make
```

## Configuration Fields

- `version`: Version number of the binary (for documentation purposes)
- `url`: Direct download URL for the binary archive
- `executable`: Name of the executable file inside the archive (before renaming)
- `description`: Brief description of the tool (optional, for documentation)

## Supported Archive Formats

Currently, the workflow supports:
- `.zip` files (using unzip)

To add support for other formats (e.g., `.tar.gz`, `.tar.bz2`), modify the `unpack_binary` rule in the Snakefile.

## Testing

After adding a new binary, test it:

1. **Dry run**: `snakemake bin/BINARY_NAME --cores 1 --dry-run`
2. **Download**: `snakemake bin/BINARY_NAME --cores 1`
3. **Verify**: `./verify_binaries.sh` (after updating the script to check the new binary)

## Troubleshooting

- **Wrong executable name**: If the unpacked executable has a different name than expected, adjust the `executable` field in `config.yaml`
- **Archive format not supported**: Modify the `unpack_binary` rule in `Snakefile` to handle the new format
- **Download fails**: Verify the URL is correct and accessible
