# Linux

## Basic

### Piping Commands

Control the amount of text from a command:

```
[command] | less
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

Make a file or directory:

```
touch [file]

mkdir [directory]
```

Copy a file or directory:

```
cp [file-path] [new-file-path]

cp -r [directory] [new-directory]
```

Move a file or directory:

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

Search for text in a file:

- -i = case insensitive search
- -w = full word search only
- -n = include file lines

```
grep [pattern] [file]
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

## Tar - Archive Files

Extract (x) a compressed (z) tar file:

```
tar -xvzf [file]
```

Create (c) a compressed (z) tar file from a folder:

```
tar -cvzf [compressed-file-name].tar.gz [folder]
```

## Watch

Run a command with some frequency and watch the output:

```
watch -n [seconds] [command]
```
