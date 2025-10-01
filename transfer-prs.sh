#!/bin/bash

# Transfer Pull Requests from uratmangun/vue-wedding-sample-animation to Resaqulyubi/vue-wedding-sample-animation

SOURCE_REPO="uratmangun/vue-wedding-sample-animation"
TARGET_REPO="Resaqulyubi/vue-wedding-sample-animation"

echo "=== Transferring Pull Requests ==="
echo "Source: $SOURCE_REPO"
echo "Target: $TARGET_REPO"
echo ""

# Add target repository as a remote if not already added
if ! git remote | grep -q "target-repo"; then
    echo "Adding target repository as remote..."
    git remote add target-repo "git@github.com:${TARGET_REPO}.git"
fi

# Fetch all branches from source
echo "Fetching all branches from source..."
git fetch origin

# Array of PR data (number, branch, base, title, body)
declare -a PRS=(
    "6|jv-readme-wedding-anim|master|Add Javanese README for wedding animation project|Add a new README_JV.md written in Javanese to document the wedding animation web app. The file describes features, tech stack, project structure, setup and deployment instructions (Docker and Nixpacks), customization notes, and license. This provides localized documentation for Javanese-speaking contributors and users."
    "5|add-readme-indonesia-wedding-app|master|Add Indonesian README for wedding animation app|Provide an Indonesian-language README describing the wedding invitation animation web app. The new README (README_ID.md) documents features, technologies, project structure, setup and deployment instructions (Docker and Nixpacks), customization notes, and license information so Indonesian-speaking contributors can quickly understand and run the project."
    "4|arabic-readme-wedding-invite|master|Add Arabic README for wedding invitation project|Create an Arabic-language README (README_AR.md) describing the wedding invitation demo built with Laravel, Vue.js and GSAP. The file documents features, tech stack, project structure, setup and deployment instructions (Docker/Nixpacks), customization notes, and licensing — providing Arabic-speaking contributors and users with clear guidance on running and deploying the project."
    "3|aramaic-readme-wedding-sample|master|Add README in Aramaic for wedding animation sample|Add a new README-ARAMAIC.md documenting the wedding invitation animation sample in Aramaic. The file introduces the project, lists features, tech stack (Vue 3, GSAP, Laravel 10, PHP 8.1+, Vite, Tailwind), project structure, setup and build steps, deployment notes (Docker/Nixpacks), optimization tips, and contributor guidance. This README was added to provide native-language documentation and onboarding information for Aramaic-speaking contributors and users."
    "2|docs/vue-wedding-readme|master|Replace README with Vue wedding invitation overview|Replace the old Laravel boilerplate README with a concise, project-specific README describing the Vue-based wedding invitation landing page, its features, tech stack, deployment options (Docker and Nixpacks), and setup instructions. This update was needed to provide clear documentation tailored to this project's structure and workflows, removing irrelevant Laravel template content and adding practical setup, build, and deployment guidance for contributors and deployers."
    "1|u-branch-1|master|Add new Landing.vue page for wedding site|- No changes detected (no commit messages provided)"
)

# Process each PR
for pr_data in "${PRS[@]}"; do
    IFS='|' read -r pr_num branch base title body <<< "$pr_data"
    
    echo ""
    echo "=== Processing PR #$pr_num: $title ==="
    
    # Check if branch exists locally
    if git show-ref --verify --quiet "refs/heads/$branch"; then
        echo "Branch $branch exists locally"
    elif git show-ref --verify --quiet "refs/remotes/origin/$branch"; then
        echo "Checking out branch $branch from origin..."
        git checkout -b "$branch" "origin/$branch"
    else
        echo "ERROR: Branch $branch not found"
        continue
    fi
    
    # Push branch to target repository
    echo "Pushing branch $branch to target repository..."
    git push target-repo "$branch:$branch" -f
    
    # Create PR in target repository
    echo "Creating PR in target repository..."
    
    # Escape quotes in title and body for gh cli
    escaped_title=$(echo "$title" | sed 's/"/\\"/g')
    escaped_body=$(echo "$body" | sed 's/"/\\"/g')
    
    gh pr create \
        --repo "$TARGET_REPO" \
        --base "$base" \
        --head "$branch" \
        --title "$escaped_title" \
        --body "$escaped_body" || echo "Failed to create PR (may already exist)"
    
    echo "✓ Completed PR #$pr_num"
done

echo ""
echo "=== Transfer Complete ==="
echo "All pull requests have been transferred to $TARGET_REPO"
