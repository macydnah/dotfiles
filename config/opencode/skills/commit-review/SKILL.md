---
name: commit-review
description: Analyze changes and create well-structured commits
license: MIT
compatibility: opencode
metadata:
  audience: developers
  workflow: git
---

## What I do

- Analyze `git status` and `git diff` to understand pending changes
- Review commit history (`git log`) to match existing commit style
- Plan atomic commits grouping related changes
- Execute commits with descriptive messages following conventions
- Support iterative/marathon mode for multiple commits

## When to use me

Use this skill when you have accumulated changes and need to:
- Review and organize uncommitted work
- Create a series of well-structured commits
- Clean up your working tree with proper commit hygiene

Ask clarifying questions about:
- Which changes to exclude from committing
- Preferred commit granularity (atomic vs grouped)
- Any files that should remain uncommitted

## Workflow

1. **Analyze**
   ```bash
   git status
   git diff --stat
   git log --oneline -20
   ```

2. **Plan**
   - Group changes by scope/feature
   - Determine commit order (dependencies first)
   - Identify files to exclude

3. **Confirm**
   - Present plan to user as a table
   - Ask about exclusions or reordering
   - Clarify commit granularity preferences

4. **Execute**
   - Stage files with `git add` (use `-p` for partial staging)
   - Commit with descriptive message
   - Mark task as completed

5. **Iterate**
   - Repeat for remaining changes (marathon mode)
   - Update progress tracking

## Commit Message Style

Follow conventional commits format:

```
type(scope): concise description

Optional body explaining the "why" with more detail.
```

**Types**: `feat`, `fix`, `refactor`, `chore`, `docs`

**Scope**: App/tool name (e.g., `neovim`, `hyprland`, `shell`)

## Partial Staging

When a file contains mixed changes (some to commit, some to exclude):

```bash
# Interactive patch mode
git add -p <file>

# Or with automated responses for known hunks
printf 'y\nn\ny\n...' | git add -p <file>
```

## Marathon Mode

For multiple commits in succession:
1. Create a todo list with all planned commits
2. Mark each as `in_progress` while working
3. Mark as `completed` immediately after commit succeeds
4. Continue to next item

## Notes

- Always verify staged changes before committing
- Use `git diff --cached` to review what will be committed
- Never commit sensitive files (.env, credentials, etc.)
- Can be invoked repeatedly for commit marathons
