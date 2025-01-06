#!/bin/bash

# Comprehensive Linux Built-in Commands Tutorial
# Version 2.0

show_header() {
    clear
    echo "============================================"
    echo "Linux Built-in Commands and Operators Tutorial"
    echo "============================================"
}

section_special_operators() {
    echo -e "\n=== Special Operators ==="
    
    echo -e "\n1. ! (NOT/History Operator)"
    echo "Command: !ls"
    echo "Description: Runs the most recent ls command"
    echo "Command: !$"
    echo "Description: References the last argument of the previous command"
    echo "Command: !!"
    echo "Description: Repeats the last command"
    
    echo -e "\n2. % (Job Control)"
    echo "Command: jobs"
    sleep 100 & # Create a background job
    jobs
    echo "Command: kill %1"
    kill %1
    echo "Description: % references background jobs"
    
    echo -e "\n3. . (Dot Operator)"
    echo 'echo "test content" > test_script.sh'
    echo "test content" > test_script.sh
    chmod +x test_script.sh
    echo "Command: . ./test_script.sh"
    . ./test_script.sh
    echo "Description: Sources script in current shell"
    
    echo -e "\n4. : (Null Command)"
    echo "Command: :"
    :
    echo "Exit status: $?"
    echo "Description: Always returns success (0)"
    
    echo -e "\n5. @ (Array Operations)"
    echo "Command: array=('one' 'two' 'three')"
    array=('one' 'two' 'three')
    echo "Command: echo \${array[@]}"
    echo "${array[@]}"
    
    echo -e "\n6. [ ] (Test Operators)"
    echo "Command: [ -f test_script.sh ] && echo 'File exists'"
    [ -f test_script.sh ] && echo 'File exists'
    
    echo -e "\n7. { } (Brace Expansion)"
    echo "Command: echo {1..3}"
    echo {1..3}
    echo "Command: echo {a..c}"
    echo {a..c}
    
    # Cleanup
    rm -f test_script.sh
    
    read -p "Press ENTER to continue..."
}

section_flow_control() {
    echo -e "\n=== Flow Control Commands ==="
    
    echo -e "\n1. if/elif/else/fi Example:"
    echo 'Command: 
if [ -f /etc/passwd ]; then
    echo "Password file exists"
elif [ -f /etc/shadow ]; then
    echo "Shadow file exists"
else
    echo "Files not found"
fi'
    
    if [ -f /etc/passwd ]; then
        echo "Password file exists"
    elif [ -f /etc/shadow ]; then
        echo "Shadow file exists"
    else
        echo "Files not found"
    fi
    
    echo -e "\n2. for/do/done Example:"
    echo 'Command:
for i in {1..3}; do
    echo "Number: $i"
done'
    
    for i in {1..3}; do
        echo "Number: $i"
    done
    
    read -p "Press ENTER to continue..."
}

section_directory_stack() {
    echo -e "\n=== Directory Stack Operations (pushd/popd) ==="
    
    # Create test directories
    echo "Creating test directories..."
    mkdir -p ~/test/dir1 ~/test/dir2 ~/test/dir3
    
    echo -e "\n1. pushd - Push directory to stack"
    echo "Command: pushd ~/test/dir1"
    pushd ~/test/dir1
    
    echo -e "\nCurrent stack (dirs):"
    echo "Command: dirs -v"
    dirs -v
    
    echo -e "\nPushing another directory"
    echo "Command: pushd ~/test/dir2"
    pushd ~/test/dir2
    
    echo -e "\nUpdated stack:"
    echo "Command: dirs -v"
    dirs -v
    
    echo -e "\n2. popd - Pop directory from stack"
    echo "Command: popd"
    popd
    
    echo -e "\nStack after pop:"
    echo "Command: dirs -v"
    dirs -v
    
    # Cleanup
    cd
    rm -rf ~/test
    
    read -p "Press ENTER to continue..."
}

section_command_history() {
    echo -e "\n=== Command History and FC (Fix Command) ==="
    
    echo -e "\n1. Basic History Usage"
    echo "Command: history 5"
    history 5
    
    echo -e "\n2. FC Command Examples"
    echo "Command: fc -l -5"
    fc -l -5
    
    echo -e "\nFC Options:"
    echo "fc -l     # List last 16 commands"
    echo "fc -ln    # List without numbers"
    echo "fc -lr    # List in reverse order"
    echo "fc -e vim # Edit last command in vim"
    
    read -p "Press ENTER to continue..."
}

section_rehash() {
    echo -e "\n=== Rehash Command ==="
    
    echo "Command: hash"
    hash
    
    echo -e "\nCommand: hash -r (equivalent to rehash)"
    hash -r
    
    echo -e "\nWhen to use rehash:"
    echo "1. After installing new software"
    echo "2. After modifying PATH"
    echo "3. When new commands aren't found"
    
    read -p "Press ENTER to continue..."
}

section_ulimit() {
    echo -e "\n=== Ulimit (User Limits) ==="
    
    echo -e "\n1. View all limits"
    echo "Command: ulimit -a"
    ulimit -a
    
    echo -e "\n2. View specific limits:"
    echo "Command: ulimit -n (max open files)"
    ulimit -n
    
    echo "Command: ulimit -u (max user processes)"
    ulimit -u
    
    echo -e "\nCommon ulimit options:"
    echo "-f: Maximum file size"
    echo "-t: Maximum CPU time"
    echo "-v: Maximum virtual memory"
    echo "-n: Maximum number of open files"
    echo "-u: Maximum number of processes"
    
    read -p "Press ENTER to continue..."
}

section_umask() {
    echo -e "\n=== Umask (File Creation Mask) ==="
    
    echo -e "\n1. Current umask value"
    echo "Command: umask"
    umask
    
    echo -e "\n2. Symbolic umask value"
    echo "Command: umask -S"
    umask -S
    
    echo -e "\nCreating test files..."
    echo "Command: touch umask_test_file"
    touch umask_test_file
    echo "Command: ls -l umask_test_file"
    ls -l umask_test_file
    
    echo -e "\nCreating test directory..."
    echo "Command: mkdir umask_test_dir"
    mkdir umask_test_dir
    echo "Command: ls -ld umask_test_dir"
    ls -ld umask_test_dir
    
    # Cleanup
    rm -f umask_test_file
    rmdir umask_test_dir
    
    read -p "Press ENTER to continue..."
}

section_shell_variables() {
    echo -e "\n=== Shell Variables and Environment ==="
    
    echo -e "\n1. Setting and displaying variables"
    echo "Command: TEST_VAR='Hello World'"
    TEST_VAR='Hello World'
    echo "Command: echo \$TEST_VAR"
    echo $TEST_VAR
    
    echo -e "\n2. Exporting variables"
    echo "Command: export TEST_VAR"
    export TEST_VAR
    
    echo -e "\n3. Readonly variables"
    echo "Command: readonly CONST_VAR='constant'"
    readonly CONST_VAR='constant'
    
    echo -e "\n4. Unsetting variables"
    echo "Command: unset TEST_VAR"
    unset TEST_VAR
    
    read -p "Press ENTER to continue..."
}

section_shell_utilities() {
    echo -e "\n=== Shell Utilities ==="
    
    echo -e "\n1. Echo command"
    echo "Command: echo 'Hello World'"
    echo 'Hello World'
    
    echo -e "\n2. Printf command"
    echo "Command: printf 'Format %s\n' 'string'"
    printf 'Format %s\n' 'string'
    
    echo -e "\n3. Read command"
    echo "Command: read -t 1 -p 'Press any key (timeout 1s): '"
    read -t 1 -p 'Press any key (timeout 1s): '
    
    read -p "Press ENTER to continue..."
}

main_menu() {
    while true; do
        show_header
        echo -e "\nSelect a section:"
        echo "1. Special Operators"
        echo "2. Flow Control Commands"
        echo "3. Directory Stack (pushd/popd)"
        echo "4. Command History and FC"
        echo "5. Rehash Command"
        echo "6. Ulimit (User Limits)"
        echo "7. Umask (File Creation Mask)"
        echo "8. Shell Variables"
        echo "9. Shell Utilities"
        echo "10. Exit"
        
        read -p "Enter choice (1-10): " choice
        
        case $choice in
            1) section_special_operators ;;
            2) section_flow_control ;;
            3) section_directory_stack ;;
            4) section_command_history ;;
            5) section_rehash ;;
            6) section_ulimit ;;
            7) section_umask ;;
            8) section_shell_variables ;;
            9) section_shell_utilities ;;
            10) echo "Thank you for using the tutorial!"; exit 0 ;;
            *) echo "Invalid option. Press ENTER to continue..."; read ;;
        esac
    done
}

# Start the tutorial
main_menu
