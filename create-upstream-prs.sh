#!/bin/bash

# Create Pull Requests from fork (uratmangun) to upstream (Resaqulyubi)

FORK_OWNER="uratmangun"
UPSTREAM_REPO="Resaqulyubi/vue-wedding-sample-animation"

echo "=== Creating Pull Requests from Fork to Upstream ==="
echo "Fork: ${FORK_OWNER}/vue-wedding-sample-animation"
echo "Upstream: ${UPSTREAM_REPO}"
echo ""

# Array of PR data (branch, base, title, body)
declare -a PRS=(
    "jv-readme-wedding-anim|master|Add Javanese README for wedding animation project|Add a new README_JV.md written in Javanese to document the wedding animation web app. The file describes features, tech stack, project structure, setup and deployment instructions (Docker and Nixpacks), customization notes, and license. This provides localized documentation for Javanese-speaking contributors and users."
    "add-readme-indonesia-wedding-app|master|Add Indonesian README for wedding animation app|Provide an Indonesian-language README describing the wedding invitation animation web app. The new README (README_ID.md) documents features, technologies, project structure, setup and deployment instructions (Docker and Nixpacks), customization notes, and license information so Indonesian-speaking contributors can quickly understand and run the project."
    "arabic-readme-wedding-invite|master|Add Arabic README for wedding invitation project|Create an Arabic-language README (README_AR.md) describing the wedding invitation demo built with Laravel, Vue.js and GSAP. The file documents features, tech stack, project structure, setup and deployment instructions (Docker/Nixpacks), customization notes, and licensing — providing Arabic-speaking contributors and users with clear guidance on running and deploying the project."
    "aramaic-readme-wedding-sample|master|Add README in Aramaic for wedding animation sample|Add a new README-ARAMAIC.md documenting the wedding invitation animation sample in Aramaic. The file introduces the project, lists features, tech stack (Vue 3, GSAP, Laravel 10, PHP 8.1+, Vite, Tailwind), project structure, setup and build steps, deployment notes (Docker/Nixpacks), optimization tips, and contributor guidance. This README was added to provide native-language documentation and onboarding information for Aramaic-speaking contributors and users."
    "docs/vue-wedding-readme|master|Replace README with Vue wedding invitation overview|Replace the old Laravel boilerplate README with a concise, project-specific README describing the Vue-based wedding invitation landing page, its features, tech stack, deployment options (Docker and Nixpacks), and setup instructions. This update was needed to provide clear documentation tailored to this project's structure and workflows, removing irrelevant Laravel template content and adding practical setup, build, and deployment guidance for contributors and deployers."
    "u-branch-1|master|Add new Landing.vue page for wedding site|- No changes detected (no commit messages provided)"
)

# Process each PR
for pr_data in "${PRS[@]}"; do
    IFS='|' read -r branch base title body <<< "$pr_data"
    
    echo ""
    echo "=== Creating PR for branch: $branch ==="
    echo "Title: $title"
    
    # Create PR from fork to upstream
    # The head format is "fork-owner:branch" when creating cross-repository PRs
    gh pr create \
        --repo "$UPSTREAM_REPO" \
        --base "$base" \
        --head "${FORK_OWNER}:${branch}" \
        --title "$title" \
        --body "$body" && echo "✓ Successfully created PR for $branch" || echo "⚠ Failed to create PR for $branch (may already exist)"
done

echo ""
echo "=== PR Creation Complete ==="
echo "Check the pull requests at: https://github.com/${UPSTREAM_REPO}/pulls"
