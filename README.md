gtShell
=======

gtShell is a shell script that allows you to save and jump to commonly used directories. It supports tab completion.

**installation:**

 1. `git clone git@github.com:huangbowen521/gtShell.git`

 2. add gtShell.sh file path to your `~/.bash_profile` or `~/.bashrc` file
 3. reload your profile or restart your terminal  

**Usage:**

* `gt -a <bookmark_name>` - Saves the current directory as "bookmark_name"'
 
* `gt -d <bookmark_name>` - Deletes the bookmark'
 
* `gt -l`                 - Lists all available bookmarks'
 
* `gt -h` - Lists usage

* `gt <bookmark_name>`    - Jump to the bookmark' 


**Example:**

```bash
current_user:~$ cd sourcecode/study/
current_user:~/sourcecode/study$ gt -a study
current_user:~/sourcecode/study$ cd ~
current_user:~$ gt study
current_user:~/sourcecode/study$ gt -l
goAgent=/Users/twer/sourcecode/goagent/goagent-goagent-9c1edd3/local
octopress=/Users/twer/sourcecode/octopress
goShell=/Users/twer/sourcecode/shell/goShell
study=/Users/twer/sourcecode/study
current_user:~/sourcecode/study$ gt -d study
current_user:~/sourcecode/study$ gt -l
goAgent=/Users/twer/sourcecode/goagent/goagent-goagent-9c1edd3/local
octopress=/Users/twer/sourcecode/octopress
goShell=/Users/twer/sourcecode/shell/goShell
current_user:~/sourcecode/study$ gt -h
Usage:
-a <bookmark_name> - Saves the current directory as "bookmark_name"
-d <bookmark_name> - Deletes the bookmark
-l                 - Lists all available bookmarks
-h(-help,--help)   - Lists usage
<bookmark_name>    - Jump to the bookmark
current_user:~/sourcecode/study$ gt go<Tab>
goAgent  goShell  
current_user:~/sourcecode/study$ gt goShell
```