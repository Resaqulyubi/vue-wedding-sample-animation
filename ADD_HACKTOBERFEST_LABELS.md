# Add Hacktoberfest Labels to PRs

## For Repository Maintainer (Resaqulyubi)

### Quick Method - Using GitHub CLI

```bash
# 1. Create the hacktoberfest label (if it doesn't exist)
gh label create hacktoberfest \
  --repo Resaqulyubi/vue-wedding-sample-animation \
  --description "Hacktoberfest participation" \
  --color "FF6B6B"

# 2. Add the label to all 6 PRs
gh pr edit 1 --repo Resaqulyubi/vue-wedding-sample-animation --add-label "hacktoberfest"
gh pr edit 2 --repo Resaqulyubi/vue-wedding-sample-animation --add-label "hacktoberfest"
gh pr edit 3 --repo Resaqulyubi/vue-wedding-sample-animation --add-label "hacktoberfest"
gh pr edit 4 --repo Resaqulyubi/vue-wedding-sample-animation --add-label "hacktoberfest"
gh pr edit 5 --repo Resaqulyubi/vue-wedding-sample-animation --add-label "hacktoberfest"
gh pr edit 6 --repo Resaqulyubi/vue-wedding-sample-animation --add-label "hacktoberfest"
```

### Alternative - Using GitHub Web Interface

1. Go to https://github.com/Resaqulyubi/vue-wedding-sample-animation/labels
2. Click "New label"
3. Name: `hacktoberfest`
4. Description: `Hacktoberfest participation`
5. Color: `#FF6B6B` (or any color you prefer)
6. Click "Create label"

Then for each PR (1-6):
1. Go to the PR page
2. Click on "Labels" in the right sidebar
3. Select "hacktoberfest"

### Automated Script

```bash
#!/bin/bash

REPO="Resaqulyubi/vue-wedding-sample-animation"

# Create label
gh label create hacktoberfest \
  --repo "$REPO" \
  --description "Hacktoberfest participation" \
  --color "FF6B6B" 2>/dev/null || echo "Label may already exist"

# Add to all PRs
for pr in {1..6}; do
  echo "Adding hacktoberfest label to PR #$pr..."
  gh pr edit $pr --repo "$REPO" --add-label "hacktoberfest"
done

echo "✓ Done! All PRs now have the hacktoberfest label"
```

## PR Links

- PR #1: https://github.com/Resaqulyubi/vue-wedding-sample-animation/pull/1
- PR #2: https://github.com/Resaqulyubi/vue-wedding-sample-animation/pull/2
- PR #3: https://github.com/Resaqulyubi/vue-wedding-sample-animation/pull/3
- PR #4: https://github.com/Resaqulyubi/vue-wedding-sample-animation/pull/4
- PR #5: https://github.com/Resaqulyubi/vue-wedding-sample-animation/pull/5
- PR #6: https://github.com/Resaqulyubi/vue-wedding-sample-animation/pull/6
