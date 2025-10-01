# Pull Request Transfer Guide

## Overview
This guide explains how to transfer all 6 pull requests from `uratmangun/vue-wedding-sample-animation` to `Resaqulyubi/vue-wedding-sample-animation`.

## Prerequisites
- You must have push access to `Resaqulyubi/vue-wedding-sample-animation`
- GitHub CLI (`gh`) must be installed and authenticated

## Pull Requests to Transfer

1. **PR #6**: Add Javanese README for wedding animation project (branch: `jv-readme-wedding-anim`)
2. **PR #5**: Add Indonesian README for wedding animation app (branch: `add-readme-indonesia-wedding-app`)
3. **PR #4**: Add Arabic README for wedding invitation project (branch: `arabic-readme-wedding-invite`)
4. **PR #3**: Add README in Aramaic for wedding animation sample (branch: `aramaic-readme-wedding-sample`)
5. **PR #2**: Replace README with Vue wedding invitation overview (branch: `docs/vue-wedding-readme`)
6. **PR #1**: Add new Landing.vue page for wedding site (branch: `u-branch-1`)

## Method 1: Automated Script (For Repository Owner)

If you have access to `Resaqulyubi/vue-wedding-sample-animation`, run the included `transfer-prs.sh` script:

```bash
chmod +x transfer-prs.sh
./transfer-prs.sh
```

## Method 2: Manual Transfer Steps

### Step 1: Clone both repositories

```bash
# Clone source repository
git clone git@github.com:uratmangun/vue-wedding-sample-animation.git source-repo
cd source-repo

# Add target repository as remote
git remote add target git@github.com:Resaqulyubi/vue-wedding-sample-animation.git
```

### Step 2: Transfer each branch and create PR

For each PR, repeat these steps:

#### PR #6: Javanese README
```bash
git fetch origin jv-readme-wedding-anim
git checkout jv-readme-wedding-anim
git push target jv-readme-wedding-anim:jv-readme-wedding-anim

gh pr create \
  --repo Resaqulyubi/vue-wedding-sample-animation \
  --base master \
  --head jv-readme-wedding-anim \
  --title "Add Javanese README for wedding animation project" \
  --body "Add a new README_JV.md written in Javanese to document the wedding animation web app. The file describes features, tech stack, project structure, setup and deployment instructions (Docker and Nixpacks), customization notes, and license. This provides localized documentation for Javanese-speaking contributors and users."
```

#### PR #5: Indonesian README
```bash
git fetch origin add-readme-indonesia-wedding-app
git checkout add-readme-indonesia-wedding-app
git push target add-readme-indonesia-wedding-app:add-readme-indonesia-wedding-app

gh pr create \
  --repo Resaqulyubi/vue-wedding-sample-animation \
  --base master \
  --head add-readme-indonesia-wedding-app \
  --title "Add Indonesian README for wedding animation app" \
  --body "Provide an Indonesian-language README describing the wedding invitation animation web app. The new README (README_ID.md) documents features, technologies, project structure, setup and deployment instructions (Docker and Nixpacks), customization notes, and license information so Indonesian-speaking contributors can quickly understand and run the project."
```

#### PR #4: Arabic README
```bash
git fetch origin arabic-readme-wedding-invite
git checkout arabic-readme-wedding-invite
git push target arabic-readme-wedding-invite:arabic-readme-wedding-invite

gh pr create \
  --repo Resaqulyubi/vue-wedding-sample-animation \
  --base master \
  --head arabic-readme-wedding-invite \
  --title "Add Arabic README for wedding invitation project" \
  --body "Create an Arabic-language README (README_AR.md) describing the wedding invitation demo built with Laravel, Vue.js and GSAP. The file documents features, tech stack, project structure, setup and deployment instructions (Docker/Nixpacks), customization notes, and licensing — providing Arabic-speaking contributors and users with clear guidance on running and deploying the project."
```

#### PR #3: Aramaic README
```bash
git fetch origin aramaic-readme-wedding-sample
git checkout aramaic-readme-wedding-sample
git push target aramaic-readme-wedding-sample:aramaic-readme-wedding-sample

gh pr create \
  --repo Resaqulyubi/vue-wedding-sample-animation \
  --base master \
  --head aramaic-readme-wedding-sample \
  --title "Add README in Aramaic for wedding animation sample" \
  --body "Add a new README-ARAMAIC.md documenting the wedding invitation animation sample in Aramaic. The file introduces the project, lists features, tech stack (Vue 3, GSAP, Laravel 10, PHP 8.1+, Vite, Tailwind), project structure, setup and build steps, deployment notes (Docker/Nixpacks), optimization tips, and contributor guidance. This README was added to provide native-language documentation and onboarding information for Aramaic-speaking contributors and users."
```

#### PR #2: Vue Wedding README
```bash
git fetch origin docs/vue-wedding-readme
git checkout docs/vue-wedding-readme
git push target docs/vue-wedding-readme:docs/vue-wedding-readme

gh pr create \
  --repo Resaqulyubi/vue-wedding-sample-animation \
  --base master \
  --head docs/vue-wedding-readme \
  --title "Replace README with Vue wedding invitation overview" \
  --body "Replace the old Laravel boilerplate README with a concise, project-specific README describing the Vue-based wedding invitation landing page, its features, tech stack, deployment options (Docker and Nixpacks), and setup instructions. This update was needed to provide clear documentation tailored to this project's structure and workflows, removing irrelevant Laravel template content and adding practical setup, build, and deployment guidance for contributors and deployers."
```

#### PR #1: Landing Page
```bash
git fetch origin u-branch-1
git checkout u-branch-1
git push target u-branch-1:u-branch-1

gh pr create \
  --repo Resaqulyubi/vue-wedding-sample-animation \
  --base master \
  --head u-branch-1 \
  --title "Add new Landing.vue page for wedding site" \
  --body "- No changes detected (no commit messages provided)"
```

## Method 3: Request Collaborator Access

If you need to run the transfer yourself:

1. Ask the owner of `Resaqulyubi/vue-wedding-sample-animation` to add you as a collaborator with push access
2. Once granted, run the `transfer-prs.sh` script from this repository

## Troubleshooting

### Permission Denied Error
- Ensure you have push access to the target repository
- Check that your SSH key is properly configured: `ssh -T git@github.com`
- Verify you're authenticated with the correct GitHub account

### Branch Already Exists
- If branches already exist in target repo, use force push: `git push target branch-name:branch-name -f`

### PR Already Exists
- If a PR already exists for a branch, the script will skip it with a warning

## Verification

After transfer, verify all PRs are created:

```bash
gh pr list --repo Resaqulyubi/vue-wedding-sample-animation --state all
```
