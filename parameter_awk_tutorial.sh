#!/bin/bash

# Tutorial: Script Parameters and AWK Command Output Processing
# Filename: parameter_awk_tutorial.sh

show_header() {
    clear
    echo "================================================"
    echo "Tutorial: Script Parameters and AWK Output Processing"
    echo "================================================"
}

section_script_parameters() {
    echo -e "\n=== Script Parameters ==="
    echo "Command being run: $0"
    
    echo -e "\n1. Basic Parameter Handling"
    echo 'Script example:'
    echo '```bash'
    echo '#!/bin/bash'
    echo 'echo "First parameter: $1"'
    echo 'echo "Second parameter: $2"'
    echo 'echo "All parameters: $@"'
    echo 'echo "Number of parameters: $#"'
    echo '```'
    
    echo -e "\n2. Using getopts for Named Parameters"
    echo 'Example script:'
    cat << 'EOF'
#!/bin/bash
while getopts "f:n:h" opt; do
    case $opt in
        f) filename="$OPTARG";;
        n) number="$OPTARG";;
        h) echo "Usage: $0 -f filename -n number"; exit 0;;
        ?) echo "Invalid option"; exit 1;;
    esac
done
EOF

    echo -e "\n3. Using Long Options with getopt"
    echo 'Example script:'
    cat << 'EOF'
#!/bin/bash
TEMP=$(getopt -o f:n:h --long file:,number:,help -n 'test.sh' -- "$@")
eval set -- "$TEMP"
while true; do
    case "$1" in
        -f|--file) file="$2"; shift 2;;
        -n|--number) number="$2"; shift 2;;
        --) shift; break;;
        *) echo "Invalid option"; exit 1;;
    esac
done
EOF

    read -p "Press ENTER to continue..."
}

section_awk_basics() {
    echo -e "\n=== AWK Basics ==="
    
    echo -e "\n1. Basic AWK Structure"
    echo 'awk pattern { action }'
    
    echo -e "\n2. Print Specific Fields"
    echo "Command: ls -l | awk '{print \$1, \$9}'"
    ls -l | awk '{print $1, $9}'
    
    echo -e "\n3. Using Field Separator"
    echo "Command: echo 'one:two:three' | awk -F':' '{print \$2}'"
    echo 'one:two:three' | awk -F':' '{print $2}'
    
    read -p "Press ENTER to continue..."
}

section_awk_command_output() {
    echo -e "\n=== Processing Command Output with AWK ==="
    
    echo -e "\n1. Processing 'df' Output"
    echo "Command: df -h | awk 'NR>1 {print \$1, \$5}'"
    df -h | awk 'NR>1 {print $1, $5}'
    
    echo -e "\n2. Processing 'ps' Output"
    echo "Command: ps aux | awk 'NR>1 {print \$1, \$2, \$11}'"
    ps aux | awk 'NR>1 {print $1, $2, $11}' | head -5
    
    echo -e "\n3. Processing 'netstat' Output"
    echo "Command: netstat -an | awk '/LISTEN/ {print \$4}'"
    netstat -an | awk '/LISTEN/ {print $4}' | head -5
    
    read -p "Press ENTER to continue..."
}

section_practical_examples() {
    echo -e "\n=== Practical Examples ==="
    
    echo -e "\n1. Disk Space Monitor"
    cat << 'EOF'
#!/bin/bash
threshold=${1:-90}  # Default to 90%
df -h | awk -v thresh=$threshold 'NR>1 && substr($5, 1, length($5)-1) > thresh {
    print "Warning: Disk " $1 " is at " $5 " capacity"
}'
EOF
    
    echo -e "\n2. Memory Usage by Process"
    cat << 'EOF'
#!/bin/bash
process_name=$1
ps aux | awk -v proc="$process_name" '$11 ~ proc {
    sum += $4  # Add up memory percentage
} END {
    print "Total memory usage for " proc ": " sum "%"
}'
EOF
    
    echo -e "\n3. Network Connection Counter"
    cat << 'EOF'
#!/bin/bash
port=${1:-80}  # Default to port 80
netstat -an | awk -v p=$port '$4 ~ ":"p"$" {count++} END {
    print "Active connections on port " p ": " count
}'
EOF
    
    read -p "Press ENTER to continue..."
}

section_combining_parameters_awk() {
    echo -e "\n=== Combining Parameters and AWK ==="
    
    echo -e "\n1. Script with Parameters and AWK Processing"
    cat << 'EOF'
#!/bin/bash
# Usage: ./script.sh -p process_name -t threshold
while getopts "p:t:h" opt; do
    case $opt in
        p) process="$OPTARG";;
        t) threshold="$OPTARG";;
        h) echo "Usage: $0 -p process -t threshold"; exit 0;;
        ?) echo "Invalid option"; exit 1;;
    esac
done

# Monitor process memory usage with threshold
ps aux | awk -v proc="$process" -v thresh="$threshold" '
$11 ~ proc && $4 > thresh {
    print "Warning: Process " $11 " using " $4 "% memory"
}'
EOF
    
    read -p "Press ENTER to continue..."
}

create_example_script() {
    echo -e "\n=== Creating Example Script ==="
    cat << 'EOF' > example_script.sh
#!/bin/bash
# Example script demonstrating parameters and awk

# Process command line options
while getopts "p:t:h" opt; do
    case $opt in
        p) process="$OPTARG";;
        t) threshold="${OPTARG:-5}";;  # Default threshold 5%
        h) echo "Usage: $0 -p process -t threshold"; exit 0;;
        ?) echo "Invalid option"; exit 1;;
    esac
done

# Check if process name is provided
if [ -z "$process" ]; then
    echo "Error: Process name is required"
    echo "Usage: $0 -p process [-t threshold]"
    exit 1
fi

# Monitor process
echo "Monitoring process: $process (threshold: ${threshold}%)"
ps aux | awk -v proc="$process" -v thresh="$threshold" '
$11 ~ proc && $4 > thresh {
    printf "%-20s %-10s %-8s\n", $11, $2, $4"%"
}'
EOF

    chmod +x example_script.sh
    echo "Created example_script.sh"
    echo "Try running: ./example_script.sh -p bash -t 0.1"
}

main_menu() {
    while true; do
        show_header
        echo -e "\nSelect a section:"
        echo "1. Script Parameters"
        echo "2. AWK Basics"
        echo "3. Processing Command Output with AWK"
        echo "4. Practical Examples"
        echo "5. Combining Parameters and AWK"
        echo "6. Create Example Script"
        echo "7. Exit"
        
        read -p "Enter choice (1-7): " choice
        
        case $choice in
            1) section_script_parameters ;;
            2) section_awk_basics ;;
            3) section_awk_command_output ;;
            4) section_practical_examples ;;
            5) section_combining_parameters_awk ;;
            6) create_example_script ;;
            7) echo "Thank you for using the tutorial!"; exit 0 ;;
            *) echo "Invalid option. Press ENTER to continue..."; read ;;
        esac
    done
}

# Start the tutorial
main_menu
