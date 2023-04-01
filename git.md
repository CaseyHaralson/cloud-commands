# Git

https://git-scm.com/docs

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

## New Repo

Initialize the current directory into a new repo:

```
git init
```

Clone an existing repo into a new folder in the current directory:

```
git clone [repo-url]
git clone [repo-url] [new-folder-name]
```

## Changes

Get the repo's current status:

```
git status

git status -s
```

Add a file/folder/all to the staging area:

```
git add [file]
git add [folder]
git add .
```

Remove a file/folder/all from the staging area:

```
git restore --staged [file]
git restore --staged [folder]
git restore --staged .
```

View unstaged or staged file content changes:

```
git diff
git diff -- [file/blob]

git diff --staged
git diff --staged -- [file/blob]
```

Commit the staged changes:

```
git commit
git commit -m "[message]"
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
