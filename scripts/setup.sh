#!/bin/bash
# Setup script for initializing the Terraform project

set -e

# Check for dependencies
command -v terraform >/dev/null 2>&1 || { echo "Terraform is required but not installed. Aborting."; exit 1; }
command -v git >/dev/null 2>&1 || { echo "Git is required but not installed. Aborting."; exit 1; }

# Current directory
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${DIR}/.." && pwd)"

echo "Setting up Terraform Starter Template in: ${REPO_ROOT}"

# Initialize Git repo if not already initialized
if [ ! -d "${REPO_ROOT}/.git" ]; then
    echo "Initializing Git repository..."
    git init "${REPO_ROOT}"
    git -C "${REPO_ROOT}" add .
    git -C "${REPO_ROOT}" commit -m "Initial commit from Terraform Starter Template"
fi

# Set up pre-commit hook
echo "Setting up pre-commit hook..."
PRE_COMMIT="${REPO_ROOT}/.git/hooks/pre-commit"
cp "${REPO_ROOT}/scripts/terraform-pre-commit.sh" "${PRE_COMMIT}"
chmod +x "${PRE_COMMIT}"

# Create environment directories if they don't exist
for env in dev staging prod; do
    if [ ! -d "${REPO_ROOT}/environments/${env}" ]; then
        echo "Creating ${env} environment..."
        mkdir -p "${REPO_ROOT}/environments/${env}"
        
        # Only copy files from dev if it's not the dev environment
        if [ "${env}" != "dev" ] && [ -d "${REPO_ROOT}/environments/dev" ]; then
            cp "${REPO_ROOT}/environments/dev/"*.tf "${REPO_ROOT}/environments/${env}/"
            
            # Replace environment name in files
            find "${REPO_ROOT}/environments/${env}" -type f -name "*.tf" -exec sed -i "s/environment = \"dev\"/environment = \"${env}\"/g" {} \;
        fi
    fi
done

# Initialize all environments
for env in dev staging prod; do
    if [ -d "${REPO_ROOT}/environments/${env}" ]; then
        echo "Initializing Terraform in ${env} environment..."
        cd "${REPO_ROOT}/environments/${env}"
        terraform init -backend=false
    fi
done

echo "Setup complete! Your Terraform project is ready."
echo "Remember to configure your remote backend and provider settings."