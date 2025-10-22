"""
Snakemake workflow to download and unpack bioinformatics binaries.
Downloads PLINK1, PLINK2, and regenie to the bin/ directory.
"""

configfile: "config.yaml"

# Get list of binaries from config
BINARIES = list(config["binaries"].keys())

# Default rule - download and unpack all binaries
rule all:
    input:
        expand("bin/{binary}", binary=BINARIES)

# Rule to download a binary archive
rule download_binary:
    output:
        "downloads/{binary}.zip"
    params:
        url = lambda wildcards: config["binaries"][wildcards.binary]["url"]
    shell:
        """
        mkdir -p downloads
        curl -L -o {output} {params.url}
        """

# Rule to unpack a binary archive
rule unpack_binary:
    input:
        "downloads/{binary}.zip"
    output:
        "bin/{binary}"
    params:
        executable = lambda wildcards: config["binaries"][wildcards.binary]["executable"]
    shell:
        """
        mkdir -p bin
        unzip -o {input} -d bin/
        if [ "{params.executable}" != "{wildcards.binary}" ]; then
            mv bin/{params.executable} {output}
        fi
        chmod +x {output}
        """
