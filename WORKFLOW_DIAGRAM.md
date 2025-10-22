# Workflow Diagram

## Repository Structure

```
tsd_software/
├── .github/
│   └── workflows/
│       └── test-downloads.yml    # CI/CD workflow for automated testing
├── bin/                          # Output: Downloaded binaries (gitignored)
│   ├── plink1                    # PLINK 1.9 executable
│   ├── plink2                    # PLINK 2.0 executable
│   └── regenie                   # regenie executable
├── downloads/                    # Temporary: Downloaded archives (gitignored)
│   ├── plink1.zip
│   ├── plink2.zip
│   └── regenie.zip
├── Snakefile                     # Main workflow definition
├── config.yaml                   # Binary configuration (URLs, versions)
├── Makefile                      # Convenience interface
├── verify_binaries.sh            # Binary verification script
├── example_usage.sh              # Usage demonstration
├── test_workflow.sh              # Comprehensive test suite
├── README.md                     # Main documentation
├── ADDING_BINARIES.md            # Guide for adding new binaries
├── .gitignore                    # Excludes bin/, downloads/, .snakemake/
└── LICENSE                       # License file
```

## Workflow Flow

```
User Command
    ↓
make / snakemake
    ↓
    ├─→ Read config.yaml (binary definitions)
    │
    ├─→ download_binary (for each binary)
    │   └─→ curl → downloads/{binary}.zip
    │
    ├─→ unpack_binary (for each binary)
    │   └─→ unzip → bin/{binary}
    │           └─→ chmod +x
    │
    └─→ all (final rule)
        └─→ bin/plink1, bin/plink2, bin/regenie ✓
```

## Data Flow

```
config.yaml
    ↓ (defines)
Binary URLs & Versions
    ↓ (downloads)
downloads/*.zip
    ↓ (unpacks)
bin/plink1, bin/plink2, bin/regenie
    ↓ (verified by)
verify_binaries.sh
```

## Snakemake Rules

```
┌────────────────────────────────────────┐
│         rule: all (default)            │
│  input: bin/plink1, bin/plink2,       │
│         bin/regenie                    │
└───────────────┬────────────────────────┘
                │
        ┌───────┴───────┬────────────┐
        │               │            │
        ▼               ▼            ▼
┌──────────────┐ ┌──────────────┐ ┌──────────────┐
│ unpack_binary│ │ unpack_binary│ │ unpack_binary│
│  plink1      │ │  plink2      │ │  regenie     │
└──────┬───────┘ └──────┬───────┘ └──────┬───────┘
       │                │                │
       ▼                ▼                ▼
┌──────────────┐ ┌──────────────┐ ┌──────────────┐
│download_     │ │download_     │ │download_     │
│binary plink1 │ │binary plink2 │ │binary regenie│
└──────────────┘ └──────────────┘ └──────────────┘
```

## User Interaction Paths

### Path 1: Download All Binaries
```bash
make                          # User command
  → snakemake --cores 1       # Executes workflow
    → Downloads all binaries
    → Unpacks to bin/
```

### Path 2: Download Specific Binary
```bash
make plink1                              # User command
  → snakemake bin/plink1 --cores 1      # Executes workflow
    → Downloads plink1.zip
    → Unpacks to bin/plink1
```

### Path 3: Dry Run (Validation)
```bash
make dry-run                   # User command
  → snakemake --dry-run        # Shows what would be done
    → No actual downloads
    → Reports planned actions
```

### Path 4: Verification
```bash
./verify_binaries.sh           # User command
  → Checks bin/ directory
  → Verifies executability
  → Shows version info
```

## Configuration Extension

To add a new binary (e.g., samtools):

1. Edit `config.yaml`:
```yaml
binaries:
  # ... existing entries ...
  samtools:
    version: "1.19"
    url: "https://github.com/samtools/samtools/releases/download/1.19/samtools-1.19-linux-x86_64.tar.bz2"
    executable: "samtools"
    description: "SAM/BAM file manipulation"
```

2. Run:
```bash
make samtools
```

3. Binary appears at `bin/samtools`

## CI/CD Pipeline

```
GitHub Event (push/PR)
    ↓
.github/workflows/test-downloads.yml
    ↓
    ├─→ Setup Python & Snakemake
    ├─→ Verify Snakefile syntax
    ├─→ Run dry-run
    ├─→ Download all binaries
    ├─→ Verify binaries
    └─→ Upload as artifacts ✓
```

## Testing Hierarchy

```
test_workflow.sh
    ├─→ Test 1: File existence
    ├─→ Test 2: Snakefile syntax
    ├─→ Test 3: config.yaml validity
    ├─→ Test 4: Binary configuration
    ├─→ Test 5: Workflow dry-run
    ├─→ Test 6: Makefile targets
    └─→ Test 7: Script permissions
```

All tests must pass for the workflow to be considered functional.
