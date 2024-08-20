# My Git Flow

This is the process that I follow prior to pushing any changes to a repository:

Ensure that the `main` or `master` branch in your local repository is up-to-date with the `main` or `master` branch in the remote repository:

1. Check your current branch: `git branch --show-current` or `git branch`
2. Switch to the `main` or `master` branch: `git switch main` or `git switch master`
3. Update your local repository with the latest changes from the remote repository: `git fetch origin`
4. Pull the latest changes to your local repository: `git pull --rebase origin main` or `git pull --rebase origin master`
