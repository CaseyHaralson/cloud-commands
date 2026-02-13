# Linux

## Basic

### Manual

See the manual for a command (can use vim commands to navigate and search):

```
man [command]
```

To search all commands for some text:

1. Run the following: `man -K "[text-to-find]"`
2. Use `/text-to-find` and other vim commands to search the opened man page
3. Quit the current page: `q`
4. Keep going to the next man pages if available

### Piping Commands

Control the amount of text from a command:

```
[command] | less
```

### History

View the last commands that have been run:

```
history
```

### Files and Directories

Get the current working directory:

```
pwd
```

List files and folders:

```
ls
ls -a
ls -al
```

Change directory:

```
cd [directory]
cd ..
cd ~
```

Make a file or directory (and any parent directories if they don't exist):

```
touch [file]

mkdir -p [directory]
```

Copy a file, directory, or files in a directory:

```
cp [file-path] [new-file-path]

cp -r [directory] [new-directory]

cp -r [directory]/. [new-directory]/
```

Move a file or directory (also used for renaming a directory):

```
mv [old] [new]
```

Remove a file or directory:

```
rm [file]

rm -r [directory]
```

Find how much space a directory is using:

```
du -h [directory]
du -sh [directory]
```

### File Contents

View a file's contents:

```
cat [file]

head [file]
head -n [num-lines] [file]

tail [file]
tail -n [num-lines] [file]
tail -f [file]
```

Search for text in a file or in files in a folder:

- -i = case insensitive search
- -w = full word search only
- -n = include file lines

```
grep [pattern] [file]

grep -nri "[some string]" [folder]
```

Compare the differences between two files:

```
diff [file1] [file2]
diff -c [file1] [file2]
```

### Find Files

First, install "locate" if it isn't already installed: `sudo apt install plocate`

Find files and folders on the machine by pattern:

- -i = ignore case sensitivity

```
locate [pattern]
locate [pattern] | less
```

Find files inside a directory:

```
find [directory] -name [pattern]

find [directory] -name *.txt
```

### File Permissions and Ownership

View the current permissions for files in the current directory:

- r = read, w = write, x = execute
- first group of three permissions are for the user/owner, then the group, then "others"

```
ls -l
ls -l [file]
```

Change the permissions on a file:

- r = read, w = write, x = execute
- u = owner, g = group, o = others, a = all
- \+ = add, - = remove, = = override current with new
- -R = recursive
- can use bits:
  - 0 : 000 = no permissions
  - 1 : 001 = execute
  - 2 : 010 = write
  - 4 : 100 = read
  - 7 : 111 = read, write, execute

```
chmod [permission-change] [file]

chmod a+w [file]
chmod o-x [file]
chmod u=rw,go=r [file]

chmod -R o-r [file pattern]

chmod 664 [file]
```

Change the owner, or group of a file:

```
chown [new-owner] [file]

chown :[new-group] [file]

chown [new-owner]:[new-group] [file]
```

### Processes

List the current processes:

```
ps axu
ps axu --sort -%cpu
ps axu --sort -%mem
```

Get real-time information about processes and their resource usage:

```
top
```

Request a process to stop, or force it to stop and loose all unsaved progress:

```
kill [pid]

kill SIGKILL [pid]
```

## Advanced

### Install sudo And Add User To Group

Switch to the root user fully ("-" switches fully instead of just simulating the user with original path and home):

```
su -
```

Install sudo:

```
apt install sudo
```

Add user to sudo group:

```
usermod -aG sudo [username]
```

Logout and re-login.

## Alias

View the list of configured command aliases:

```
alias
```

Create an command alias:

```
alias [name]="[command]"
```

Remove a configured alias:

```
unalias [name]
```

## Envsubst - File Environment Variable Substitutions

First, set up an environment variable like: `export FRUIT=apples`

Second, have a file that has content that references the variable like: `My favorite fruits are $FRUIT.`

Replace the variables in the file with their current values:

```
envsubst < [file]
envsubst < [input-file] > [output-file]
```

## Jq - Pretty Json Text

Prettify a json string:

```
[json-text] | jq
```

Only output a part of the json object:

```
[json-text] | jq '.[object-property].[child-property]'

echo '{"fruit":{"name":"apple","color":"green","price":1.20}}' | jq '.fruit'
echo '{"fruit":{"name":"apple","color":"green","price":1.20}}' | jq '.fruit.name'
```

Select a particular object from an array:

```
[json-text] | jq '.[index]'

echo '["x","y","z"]' | jq '.[1]'
```

## Ping

Ping an IP or a domain to check connectivity and latency:

```
ping -c [num-requests] [ip-or-domain]
```

## Sed - Replace Text In Files

Replace all instances of a word with another word:

- the "s" picks the delimiter
- the "e" allows for multiple replacements
- the "g" means global replacement
- "-i" will edit the file in place instead of printing the changes to the console

```
sed 's/[word-to-replace]/[new-word]/g' [file]

sed -i -e 's#[word-to-replace]#[new-word]#g' -e 's?[replace]?[new]?g' [file]
```

## Tar - Archive Files

Create (c) a compressed (z) tar file from a directory or from files:

```
tar -cvzf [compressed-file-name].tar.gz [directory]

tar -cvzf [compressed-file-name].tar.gz [file1] [file2]
```

Extract (x) a compressed (z) tar file:

```
tar -xvzf [file]
```

## Tmux

Tmux lets you manage multiple terminal sessions from a single screen.

- **Session** - A top-level container. Multiple sessions can run independently.
- **Window** - Like a tab in a browser. Each session can have multiple windows, and each window takes up the full terminal screen.
- **Pane** - A split within a single window. One window can be divided into multiple panes to see several terminals at once.

Hierarchy: Session > Windows > Panes

### Sessions

Start a new session:

```
tmux

tmux new -s [name]
```

List sessions:

```
tmux ls
```

Attach to a session:

```
tmux attach -t [name]

tmux a
```

Detach from a session: `Ctrl+b d`

Kill a session:

```
tmux kill-session -t [name]
```

Rename a session: `Ctrl+b $`

### Windows

Create a new window: `Ctrl+b c`

Switch between windows: `Ctrl+b n` (next), `Ctrl+b p` (previous), `Ctrl+b [number]`

Rename a window: `Ctrl+b ,`

Close a window: `Ctrl+b &` or `exit`

List windows: `Ctrl+b w`

### Panes

Split horizontally: `Ctrl+b "`

Split vertically: `Ctrl+b %`

Switch between panes: `Ctrl+b [arrow key]`

Close a pane: `Ctrl+b x` or `exit`

Resize a pane: `Ctrl+b Ctrl+[arrow key]`

Toggle pane zoom: `Ctrl+b z`

### Other

Scroll mode: `Ctrl+b [`, then `q` to exit

## Uname - Basic System Info

To get the basic information about a system:

```
uname -a
```

## Watch

Run a command with some frequency and watch the output:

```
watch -n [seconds] [command]
```

## Wget - Download Files

Note: wget also has a simple spider mode.

Download a file:

```
wget [url]
wget -O [new-file-name] [url]
```

Download all of the files from urls listed in a file:

```
wget -i [source-file]
```

Set the retry attempts:

```
wget -t [num] [url]
```

### Big Files

Download a file in the background or limit the download rate:

```
wget -b [url]

wget --limit-rate=[rate] [url]
wget --limit-rate=500k [url]
```

Check on the progress of a file being downloaded in the background:

```
tail -f wget-log
```

Continue downloading an interrupted file:

```
wget -c [url]
```

## Zip

Note: by default, you will probably want to create compressed files with "tar" on linux.

Zip a file or directory:

```
zip -r [zip-file] [directory]

zip [zip-file] [file1] [file2]
```

To unzip a file to the current directory:

```
unzip [zip-file]
```
