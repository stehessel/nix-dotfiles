---
description: Create a git commit with conventional commit format
---

Create a git commit following these guidelines:

1. First, analyze the staged changes:

   - Run `git status` to see staged files
   - Run `git diff --staged` to review the actual changes

2. Create a commit message using Conventional Commits format:

   - Format: `<type>: <description>`
   - Types:
     - `feat`: New feature
     - `fix`: Bug fix
     - `docs`: Documentation changes
     - `style`: Code formatting (no logic changes)
     - `refactor`: Code restructuring (no behavior changes)
     - `perf`: Performance improvements
     - `test`: Adding or updating tests
     - `chore`: Build process, tooling, dependencies

3. Commit message requirements:

   - Use imperative mood (e.g., "add" not "added" or "adds")
   - Keep subject line under 72 characters
   - Be concise and descriptive
   - Focus on what and why, not how

4. Ensure atomic commits:

   - Each commit should have a single, clear purpose
   - If you detect multiple logical changes, suggest splitting them into separate commits

5. After creating the commit message, execute the commit using `git commit -m "message"`
