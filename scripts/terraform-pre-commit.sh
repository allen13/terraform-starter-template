#!/bin/bash
# Pre-commit hook for Terraform validation
# Place this in .git/hooks/pre-commit and make it executable

set -e

# Check if terraform is installed
if ! command -v terraform &> /dev/null; then
    echo "Terraform is not installed. Please install Terraform to run pre-commit checks."
    exit 1
fi

# Format all Terraform files
echo "Running terraform fmt..."
terraform fmt -recursive

# Check for terraform files in the commit
files=$(git diff --cached --name-only --diff-filter=ACM | grep "\.tf$" || true)
if [ -z "$files" ]; then
    echo "No Terraform files to validate."
    exit 0
fi

# Get unique directories containing Terraform files
directories=$(dirname $(echo "$files") | sort -u)

# Run validation in each directory
for dir in $directories; do
    echo "Validating Terraform files in $dir..."
    
    # Check if directory exists (might have been renamed/moved)
    if [ -d "$dir" ]; then
        # Initialize if .terraform doesn't exist
        if [ ! -d "$dir/.terraform" ]; then
            echo "Initializing Terraform in $dir..."
            (cd "$dir" && terraform init -backend=false)
        fi
        
        # Validate
        echo "Running terraform validate in $dir..."
        (cd "$dir" && terraform validate)
    fi
done

# Add formatted files back to the commit
if [ -n "$files" ]; then
    git add $(echo "$files" | tr '\n' ' ')
fi

echo "Pre-commit checks passed!"
exit 0