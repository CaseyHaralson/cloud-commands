# Git

Command reference: https://git-scm.com/docs

Pro Git Book: https://git-scm.com/book/en/v2

Example gitignore files: https://github.com/github/gitignore

## Config

List the set configurations and what file they come from:

```
git config --list
git config --list --show-origin
```

Check what Git thinks a particular value is (if a value could come from two places):

```
git config [config-key]
```

Set your display name and email globally or per project:

```
git config --global user.name "[name]"
git config --global user.email "[email]"

git config user.name "[name]"
git config user.email "[email]"
```

## Alias Commands

Create an alias git command that runs the configured command:

```
git config --global alias.[alias-command] '[git-command-string]'
```

For example, to see the last commit you can create an alias for the command and then call the alias instead of typing out the original command:

```
git config --global alias.last 'log -l HEAD'

git last
```

## New Repo & Remotes

Initialize the current directory into a new repo:

```
git init
```

Clone an existing repo into a new folder in the current directory:

```
git clone [repo-url]
git clone [repo-url] [new-folder-name]
```

View your remotes or add another remote:

```
git remote
git remote -v

git remote add [short-name] [repo-url]
```

Rename a remote or remove a remote:

```
git remote rename [old-short-name] [new-short-name]

git remote remove [short-name]
```

## Changes

### Stage Changes

Get the local repo's current status:

```
git status

git status -s
```

Add to the staging area:

```
git add [file]
git add [folder]
git add .
git add [blob]
```

Remove from the staging area (**WARNING**: make sure to include the "--staged" flag because this command outside of the staging area reverts changes):

```
git restore --staged [file]
git restore --staged [folder]
git restore --staged .
git restore --staged [blob]
```

View unstaged or staged file content changes:

```
git diff
git diff -- [file/blob]

git diff --staged
git diff --staged -- [file/blob]
```

Revert any changes to the selected items (**WARNING**: completely removes the changes from your local):

```
git restore [file]
git restore [folder]
git restore .
git restore [blob]
```

Remove untracked files (**WARNING**: completely removes these files from your local):

- a "-n" will show a dry run
- a "-f" will force the untracked files to be removed

```
git clean -n
git clean -f
```

### Commit Changes

Commit the staged changes:

```
git commit
git commit -m "[message]"
```

You can change the most recent commit (**WARNING**: only if you haven't pushed the change to a remote) and include any staged changes with a new commit message. If there are no changes in the staging area it will just change the last commit message:

```
git commit --amend
git commit --amend -m "[message]"
```

### Sync Changes

Get the most recent data from a remote (doesn't pull changes in to your branches, just gets the history):

```
git fetch
git fetch [remote-short-name]
git fetch --all

git remote update
```

View current information about a remote like the url, branches, and sync status:

```
git remote show [remote-short-name]
```

Before pushing your changes to a remote, you might need to [Merge Changes](#merging) or [Rebase](#rebasing)

Push changes to a remote:

```
git push
git push [remote-short-name] [branch]
```

Push a new branch to a remote and set up remote tracking:
```
git push -u [remote-short-name] [branch]
```

## History

View the history of the current branch including and excluding merge commits:

```
git log
git log --pretty=format:"%h - %an, %ar : %s"
git log --oneline
git log --graph
git log --graph --pretty=format:"%h - %an, %ar : %s"
git log --graph --oneline

git log --no-merges
git log --no-merges --pretty=format:"%h - %an, %ar : %s"
git log --no-merges --oneline
```

View a summary of the changes in the commit history for the current branch:

```
git log --stat
git log --shortstat
```

View the details of a particular commit:

```
git show [commit-id]
```

### Filter

Filter the history to a specific file:

```
git log -- [file-path]
git log --oneline -- [file-path]
```

Filter the history to a date range:

```
git log --after=2.days
git log --after=2.weeks
git log --after="[YYYY-MM-DD]"

git log --before=2.days
git log --before=2.weeks
git log --before="[YYYY-MM-DD]"

git log --after=1.weeks --before=3.days
```

Filter the history to changes against a particular string:

```
git log -S [search-string]
```

## Tags

List the tags you have locally:

```
git tag
git tag -l "[pattern]"
```

Check out a tag to view the code at that time (makes a detached head, so you can't make changes), or check out the tag to a new branch so you can make changes:

```
git checkout [tag]

git checkout -b [new-branch-name] [tag]
```

Create an annotated tag, which contains who made the tag, when, and a message:

```
git tag -a [tag] -m "[message]"
git tag -a [tag] -m "[message]" [commit-id]
```

Create a lightweight tag:

```
git tag [tag]
git tag [tag] [commit-id]
```

Push a tag:

```
git push [remote-short-name] [tag]
```

Delete a tag locally or from a remote:

```
git tag -d [tag]

git push [remote-short-name] --delete [tag]
```

Move an existing tag to the current commit (add -a to annotate the tag) and then push the tag to the remote:

```
git tag -f [tag]
git tag -f -a [tag] -m "[message]"

git push -f [remote-short-name] [tag]
```

## Branches

View your local branches, remote branches, or all branches:

```
git branch -vv
git branch -v -r
git branch -vv -a
```

Get the most recent data from your remotes:

```
git remote update
```

Get the status of your local and remote branches for a remote origin:

```
git remote show [remote-short-name]
```

View the branches that have or haven't been merged into a branch (your current branch by default):

```
git branch --merged
git branch --no-merged

git branch --merged [branch]
git branch --no-merged [branch]
```

Checkout a branch:

```
git checkout [branch]
git switch [branch]

git checkout [local-branch] [remote-short-name]/[remote-branch]
git switch [local-branch] [remote-short-name]/[remote-branch]
```

Create a branch and check it out, or just create a branch:

```
git checkout -b [branch]
git switch -c [branch]

git branch [branch]
```

Delete a local branch or a remote branch:

```
git branch -d [branch]

git push origin --delete [branch]
```

Change a branch name, push the branch to remote, and delete the old branch (**WARNING**: don't do this if the branch is in use by other collaborators) (**WARNING**: don't do this for the main branch - research how to do that if needed):

```
git branch --move [old-branch-name] [new-branch-name]

git push --set-upstream [remote-short-name] [new-branch-name]

git push [remote-short-name] --delete [old-branch-name]
```

### Stash

When you want to switch to a different branch, you probably want a clean workspace before you switch. If you have any current changes, you can save them into a stash, and then reapply them when you switch back to the correct branch. You can also apply stashes to a different branch if you want.

List the stored stashes:

```
git stash list
```

Stash the current changes and clean the workspace (-u sashes untracked files):

```
git stash push -m "[message]"
git stash push -u -m "[message]"
```

Apply a stash to the current branch by stash index (by using `git stash list`) or apply the stash and delete it at the same time:

```
git stash apply [index]

git stash pop --index [index]
```

Delete a stash by stash index:

```
git stash drop [index]
```

## Merging

First, check out the branch you want to merge into: `git checkout [branch]`

Second, don't forget to sync your changes after handling the merge: [Sync Changes](#sync-changes)

Merge changes from another branch:

```
git merge [changes-branch]
git merge [remote-short-name]/[changes-branch]
```

### Conflicts

If you end up with conflicts, the conflicted files will have annotations inside the file to indicate what needs to be handled:

```
<<<<<<< HEAD:[file]
conflicting changes from your branch
=======
conflicting changes from the changes-branch
>>>>>>> [changes-branch]:[file]
```

You will need to:

1. open the conflicted files
2. look for the annotations
3. fix the conflicts
4. remove the annotations
5. save the files
6. mark each file as resolved: `git add [file]`

Check the repo status to find any files with conflicts:

```
git status
```

You can also use a merge tool to help with conflicts:

```
git mergetool
```

After all of the conflicted files are resolved, commit and update the message if necessary (the merge and conflict message will display for editing) to end the merge:

```
git commit
```

## Rebasing

**WARNING**: don't rebase a branch that other people are working on or may have based their work on! It is best to NOT rebase if you have already pushed your changes somewhere. The _Pro Git_ book has this to say:

> If you follow that guideline, you’ll be fine. If you don’t, people will hate you, and you’ll be scorned by friends and family.

First, check out the branch you want to merge into: `git checkout [branch]`

Rebase on to changes from another branch:

```
git rebase [changes-branch]
```
