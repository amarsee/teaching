#!/bin/bash

## A git crash course

# What's my current working directory?
pwd

# What's in my current working directory?
ls

# Try again with different flags
ls -l
ls -a
ls -la

# Documentation for shell commands (useful for listing flags/options)
# man <name of command> (macOS/Linux)
# <name of command> --help (Windows)
# [q] to exit documentation in Terminal

# Create a folder where repo will live and navigate to it
mkdir ~/Desktop/myFirstRepo
cd ~/Desktop/myFirstRepo

# Configure git (once on a new computer before starting to use git)
git config --global user.name your_name
git config --global user.name your_email@domain.blah

# Initialize a git repo in our working directory
git init

# Create a first file
echo "# A new file" > first.txt
# > is a pipe operator that passes the output of one command to a file

# Check the status of a repo
git status

# Tell git to start tracking a file
git add first.txt

# Check status again
git status

# First commmit (message describing commit with -m is mandatory)
git commit -m 'my first commit!'

# Check status again
git status

# Edit/add more stuff
echo "# A new line" >> first.txt
# >> is a pipe operator that appends the output of one command to a file

mkdir subfolder
cd subfolder
echo "# New file one" > one.txt
echo "# New file two" > two.txt
cd ..

# Check status again
git status

# Add an entire folder and commit
git add first.txt
git add subfolder/
# The first use of git add on a file tells git to start tracking that file
# Subsequent use of git add tells git to reflect changes to that file in next commit

# Alternatively
git add .

# Documentation for git commands
# git help <name of command>

# Make one more change and commit
echo "# Another new line" >> first.txt
git add first.txt
git commit -m 'really important update'


# See what's changed since last commit
git diff

# Look at history of commits
git log

# Oops, I made a mistake - I need to revert (undo) some prior commit
git revert [first 7 characters of commit SHA] --no-edit
# This creates a new commit where state of files will be that of specified commit
# --no-edit says I don't want to modify the commit message

# See this is the case with git log
git log

# See this is the case by print contents of file
cat first.txt

# Thus far, everything we've done is local to our machine
# A lot of the power of git comes through publishing code with remote repositories
# Create a repository on GitHub, then
git remote add origin https://github.com/alexander-poon/myFirstRepo.git
# git remote add is the command
# 'origin' is a shorthand name for remote repository (call it whatever you want)

# Push to remote repository
git push -u origin master
# origin is the name of the remote repository that you specified with git remote add
# master is the branch of the remote repository you want to push to
# -u tells that the master branch of the remote repository is what to push to by default
# After using -u, you can push with just 'git push'

# Git workflow (First time around)
# 1) Create a local repository
# 2) Create files in repository
# 3) git add one or more files to start tracking changes
# 4) Add one or more commits
# 5) Point local repository to remote repository
# 6) push to remote

# Git workflow (Ongoing)
# 1) Modify files
# 2) git add one or more files to commit
# 3) Add one or more commits
# 4) push changes to remote

# Access someone else's work
git clone https://github.com/some-user/repo.git
# This creates a copy of a repo in your working directory
