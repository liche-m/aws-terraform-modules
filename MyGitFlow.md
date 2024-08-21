# My Git Flow

This is the process that I follow prior to pushing any changes to a repository:

<br>

Ensure that the `main` or `master` branch in your local repository is up-to-date with the `main` or `master` branch in the remote repository:

1. Check your current branch: `git branch --show-current` or `git branch`
2. Switch to the `main` or `master` branch: `git switch main` or `git switch master`
3. Update your local repository with the latest changes from the remote repository: `git fetch origin`
4. Pull the latest changes to your local repository: `git pull --rebase origin main` or `git pull --rebase origin master`

<br>

Update your feature branch locally:

1. Switch to the feature branch: `git switch eventbridge_module`
2. Integrate changes from the `main` or `master` branch into the feature branch: `git rebase main` or `git rebase master`

   - `main` or `master` refers to the local branch named main/master.
   - Git will use the local state of the `main` or `master` branch to rebase your feature branch.

3. Push the updated feature branch to the remote repository: `git push --force origin eventbridge_module`
4. Create a Pull Request.
