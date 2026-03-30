Use the JSpec workflow
---
1. Declare "Using the JSpec workflow"

2. If the current directory is not inside a git repo, offer to initialise it as
   a git repo as follows:

  git init .
  git commit -m 'initial empty commit' --allow-empty

3. If the .jspec/ folder does not exist within the current directory create it.

4. Make both .claude/ and .jspec gitignored locally by creating a .gitignore
   file inside each containing a single '*'.

5. Follow the workflow rules below.

---

## JSpec Workflow

### Files (read or create them in this order)

> Flow: `spec.md` → `architecture.md` → `tasks.md`

1. **spec.md** — project purpose, scope (in & out), features, functional and non-functional requirements
2. **design.md** — technology choices, project layout, components, data flow, concurrency model (if applicable), testing & deployment strategy
3. **tasks.md** — broken into numbered stages with numbered sub-steps; each step has a `[ ]` checkbox: `x` means completed, `~` means in progress. **tasks.md contains only actions and their completion state — not goals, rationale, or design decisions.** Goals and rationale belong in spec.md and design.md.

A `research.md` file may exist separately and be referenced by any of the above.
Before creating design.md, ask the user if they want to enter a research phase.

### Design principles

- **Agile / MVP first**: each stage must deliver demonstrable value on its own. Prefer a thin working slice over a complete implementation. Refactoring, hardening, and polish belong in later stages, not the stage that first introduces a feature.
- **Just-in-time dependencies**: only add a library or dependency in the task that first requires it. Do not front-load all dependencies early.
- **Linting and code style**: set up linting and formatting tools in Stage 1 so they apply implicitly to all subsequent work. Do not add a dedicated polish/clean-up stage for these.
- **Defer refinement**: error handling, hardening, and non-MVP polish belong in later stages, not the stage that first introduces a feature.

### JSpec Workflow Rules

- If any file is missing, enter planning mode and discuss what to create with the user.
- If a file changes, cascade updates to all subsequent files and check if earlier files are also affected.
- When all files exist: report status with a context window of tasks — show 2 tasks before and 2 tasks after the next/current task, with their completion status, so the user can see where they are in the flow. Then ask the user whether to continue.
- Keep README and any CLI tool's help text up-to-date while working on tasks current while working current**README/CLI help**: keep these current — update them in the same stage as the feature they document, at whatever point in the stage makes sense. Never document features that haven't been built yet.
- **Demo**: the last task of every stage is a hands-on demo. Always give the user explicit, copy-pasteable instructions: the exact commands to run (in order), where to run them (e.g. as test user, in a new shell), and exactly what output or behaviour to look for. Never make the user infer what to do. Wait for the user to confirm it worked, then commit all changes with a suitable git commit message before moving to the next stage.
- **Never mark a task complete without explicit user confirmation.** After completing work for a task, report what was done and wait for the user to confirm before checking it off and moving on. If the user has not said it worked or approved the output, the task is not done.
- **Completed tasks are a historical record.** It is acceptable to edit a completed task's description if it more accurately reflects what was actually built (e.g. correcting a detail, improving clarity). It is NEVER acceptable to add, change, or remove a feature in a completed task's description if that feature has not yet been implemented — that would misrepresent the state of the codebase.
- If the user asks you to "update your workflow", update this ~/.claude/commands/jspec.md command
- whenever the design changes you should ALWAYS consider whether you need to go all the way back to the spec and cascade the changes down

## Available Tools

Check if the following CLI tools are always available and should be used when relevant:

- **`gh`** — GitHub CLI: manage PRs, issues, branches, and CI/CD
- **`jira`** — Jira CLI: view and update tickets, transitions, and comments
- **`git`** — NEVER put "co-authored by Claude" in a commit message
- **`ig`** — create .gitignore files for everything in .jspec/ and .claude/ in a repo
