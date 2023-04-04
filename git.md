# Git

Command reference: https://git-scm.com/docs

Book: https://git-scm.com/book/en/v2

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

Get the most recent data from a remote:

```
git fetch
git fetch [remote-short-name]
```

View current information about a remote like the url, branches, and sync status:

```
git remote show [remote-short-name]
```

Push changes to a remote:

```
git push
git push [remote-short-name] [branch]
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

Push a tag or all local tags to a remote:

```
git push [tag]
git push [remote-short-name] [tag]

git push --tags
git push [remote-short-name] --tags
```

Delete a tag locally or from a remote:

```
git tag -d [tag]

git push --delete [tag]
git push [remote-short-name] --delete [tag]
```

## Branches

Checkout a branch:

```
git checkout [branch]
git switch [branch]
```

Create a branch and check it out, or just create a branch:

```
git checkout -b [branch]
git switch -c [branch]

git branch [branch]
```

Delete a branch:

```
git branch -d [branch]
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
