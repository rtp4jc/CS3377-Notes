
# Version Control
## Benefits
- Data backup
- Change synchronization
- Undoing earlier changes
- Used for multiple releases
- Used for long-running development
    - Save incremental changes locally or on another branch without messing people up

## Types of VCS
- Monolithic (ClearCase)
    - Have to check out files to make changes (only one person at a time)
    - Committed one file at a time
    - Need an additional tool to group files
    - Has branching
    - Merges are performed per file
    - Code review is done manually
- Distributed (git)
    - Clone the repository locally to update files
    - Committed in a group of files (whatever you select)
    - Has some automatic file grouping
    - Has branching
    - Merges occur with each commit (1+ files)
    - Code review is done with pull requests
