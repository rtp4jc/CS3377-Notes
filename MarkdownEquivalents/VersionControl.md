
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

## Strategies
- Main Branch-centric
    - The main branch is where development takes place
    - Branches are made for long term changes
    - No branches for bugfixes
- Branches for everything
    - Branch for anything (bug, feature, documentation)
    - Helpful for code reviews, allows consistent pull requests that can have review requirements before being merged into the main product
    
- Continuous integration
    - Pushing can trigger other things like automatic builds

## Scenarios
- A bug is found in all 3 versions of your product
    - V1.0 has 30% of your customers
    - V2.0 has 70% of your customers
    - V3.0 is in development
    - Which should you update first
        - V1.0 because the patches are easier to apply from older versions because it 
