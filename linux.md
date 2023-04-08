# Linux

## Basic

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

### File Contents

View a file's contents:

```
cat [file]
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
