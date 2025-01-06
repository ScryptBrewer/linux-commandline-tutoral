# Linux Commands Tutorial
## Interactive Learning Tool for Built-in Commands and Operators

This tutorial provides hands-on experience with Linux built-in commands, special operators, and shell functionality.

### Quick Start

```bash
# Clone the repository
git clone https://your-repo/linux-commands-tutorial.git
cd linux-commandline-tutoral


# Make the script executable
chmod +x linux_builtin_tutorial.sh

# Run the tutorial
./linux_builtin_tutorial.sh

# Cleanup after done
pwd
cd ..
rm -r linux-commandline-tutoral


# Linux Commands Tutorial
[Previous sections remain the same...]

## Command Reference Guide

### Special Operators and Characters

| Operator | Description | Example |
|----------|-------------|----------|
| `!` | History expansion operator | `!!` (last command), `!$` (last argument) |
| `%` | Job control reference | `%1` (job #1), `%ssh` (job starting with 'ssh') |
| `.` | Current directory/source command | `./script.sh`, `. script.sh` |
| `:` | Null command | `: > file.txt` (truncate file) |
| `@` | Array operations | `${array[@]}` (expand array) |
| `[ ]` | Test operator | `[ -f file ]` (test if file exists) |
| `{ }` | Brace expansion/grouping | `{1..5}`, `{a,b,c}` |

### Directory Operations

| Command | Description | Example |
|---------|-------------|----------|
| `pushd` | Push directory to stack | `pushd /path/to/dir` |
| `popd` | Pop directory from stack | `popd` |
| `dirs` | Display directory stack | `dirs -v` |
| `cd` | Change directory | `cd /path` |
| `pwd` | Print working directory | `pwd` |

### Shell Built-ins

#### Flow Control
| Command | Description | Example |
|---------|-------------|----------|
| `if/then/else` | Conditional execution | `if [ $a -eq $b ]; then echo "equal"; fi` |
| `for` | Loop iteration | `for i in {1..5}; do echo $i; done` |
| `while` | Conditional loop | `while true; do echo "loop"; done` |
| `case` | Pattern matching | `case $var in pattern) action;; esac` |
| `break` | Exit from loop | `break` |
| `continue` | Skip to next iteration | `continue` |

#### Process Control
| Command | Description | Example |
|---------|-------------|----------|
| `exec` | Execute command replacing shell | `exec bash` |
| `exit` | Exit shell | `exit 0` |
| `return` | Return from function | `return 1` |
| `wait` | Wait for process completion | `wait $PID` |

#### Job Control
| Command | Description | Example |
|---------|-------------|----------|
| `jobs` | List background jobs | `jobs -l` |
| `fg` | Bring job to foreground | `fg %1` |
| `bg` | Send job to background | `bg %1` |
| `kill` | Terminate process | `kill -9 PID` |

#### Shell Variables
| Command | Description | Example |
|---------|-------------|----------|
| `export` | Export variable to environment | `export PATH=$PATH:/new/path` |
| `readonly` | Make variable read-only | `readonly VAR=value` |
| `unset` | Remove variable/function | `unset VAR` |
| `local` | Declare local variable | `local var=value` |

#### Command History
| Command | Description | Example |
|---------|-------------|----------|
| `fc` | Fix command | `fc -l`, `fc -e vim` |
| `history` | Show command history | `history 10` |
| `rehash` | Rebuild command hash table | `rehash` |

#### System Limits
| Command | Description | Example |
|---------|-------------|----------|
| `ulimit` | User limits | `ulimit -a`, `ulimit -n 1024` |
| `umask` | File creation mask | `umask 022` |

#### Shell Utilities
| Command | Description | Example |
|---------|-------------|----------|
| `echo` | Display message | `echo "Hello"` |
| `printf` | Formatted output | `printf "%s\n" "text"` |
| `read` | Read user input | `read -p "Enter value: " var` |
| `eval` | Evaluate expression | `eval "echo \$var"` |
| `type` | Display command type | `type ls` |

### Advanced Features

#### Parameter Expansion
```bash
${parameter:-default}    # Use default if parameter unset
${parameter:=default}    # Set default if parameter unset
${parameter:?error}     # Display error if parameter unset
${parameter:+value}     # Use alternate value if parameter set
${#parameter}           # Length of parameter
${parameter#pattern}    # Remove matching prefix pattern
${parameter%pattern}    # Remove matching suffix pattern
