#!/bin/bash

# Filesystem Operations Tutorial
# Warning: Some commands require root privileges and can be destructive
# Always double-check commands that modify filesystems

show_header() {
    clear
    echo "============================================"
    echo "Linux Filesystem Operations Tutorial"
    echo "============================================"
    echo "WARNING: Many commands require root privileges"
    echo "DANGER: DD commands can destroy data if used incorrectly"
}

section_block_devices() {
    echo -e "\n=== Block Devices and Device Information ==="

    echo -e "\n1. List Block Devices"
    echo "Command: lsblk"
    lsblk

    echo -e "\n AWS match device from within linux to displayed name in AWS console"
    echo "Command: lsblk -o +SERIAL"
    lsblk -o +SERIAL
    
    echo -e "\n2. Show Block Device UUIDs"
    echo "Command: blkid"
    echo "Note: Requires root privileges for full output"
    sudo blkid 2>/dev/null || echo "Need sudo for full output"
    
    echo -e "\n3. Show Filesystem Usage"
    echo "Command: df -h"
    df -h
    
    read -p "Press ENTER to continue..."
}

section_mount_operations() {
    echo -e "\n=== Mount Operations ==="
    
    echo -e "\n1. Basic Mount Command Structure:"
    cat << 'EOF'
# Mount by device
mount /dev/sdb1 /mnt/mountpoint

# Mount by UUID
mount UUID="your-uuid-here" /mnt/mountpoint

# Mount with specific options
mount -o rw,noexec,nosuid /dev/sdb1 /mnt/mountpoint

# Show current mounts
mount | column -t
EOF
    
    echo -e "\n2. Common Mount Options:"
    cat << 'EOF'
rw          - Read-write
ro          - Read-only
noexec      - Prevent execution of binaries
nosuid      - Ignore SUID/SGID bits
noatime     - Don't update access times
defaults    - rw,suid,dev,exec,auto,nouser,async
EOF
    
    read -p "Press ENTER to continue..."
}

section_fstab_configuration() {
    echo -e "\n=== /etc/fstab Configuration ==="
    
    echo -e "\n1. FSTAB Format:"
    cat << 'EOF'
# Device                                 Mountpoint  FStype     Options  Dump  Pass
/dev/sda1                               /           ext4       defaults 0     1
UUID=1234-5678                          /home       ext4       defaults 0     2
LABEL=backup                            /backup     ext4       defaults 0     2
//server/share                          /smb        cifs       credentials=/etc/cifs-credentials 0 0
server:/share                           /nfs        nfs        defaults 0     0
EOF
    
    echo -e "\n2. Creating FSTAB Entries:"
    cat << 'EOF'
# 1. Get UUID
sudo blkid

# 2. Create mount point
sudo mkdir /mnt/mountpoint

# 3. Add entry to /etc/fstab
# UUID=your-uuid-here    /mnt/mountpoint    ext4    defaults    0    2

# 4. Test mount
sudo mount -a
EOF
    
    read -p "Press ENTER to continue..."
}

section_nfs_mounts() {
    echo -e "\n=== NFS Mounts ==="
    
    echo -e "\n1. Installing NFS Support:"
    cat << 'EOF'
# Debian/Ubuntu
sudo apt-get install nfs-common

# RHEL/CentOS
sudo yum install nfs-utils
EOF
    
    echo -e "\n2. Mounting NFS Shares:"
    cat << 'EOF'
# List available NFS shares
showmount -e server

# Manual mount
mount -t nfs server:/share /mnt/nfs

# FSTAB entry
server:/share    /mnt/nfs    nfs    defaults,_netdev    0    0

# Common NFS Options
rw,sync,hard,intr    # Recommended default options
EOF
    
    read -p "Press ENTER to continue..."
}

section_dd_operations() {
    echo -e "\n=== DD Operations ==="
    echo "WARNING: DD CAN DESTROY DATA IF USED INCORRECTLY"
    echo "ALWAYS DOUBLE-CHECK DEVICE NAMES"
    
    echo -e "\n1. Basic DD Usage:"
    cat << 'EOF'
# DANGER: These commands can destroy data if used incorrectly!

# Create empty filesystem
dd if=/dev/zero of=filesystem.img bs=1M count=100

# Create bootable USB
dd if=image.iso of=/dev/sdX bs=4M status=progress

# Backup MBR
dd if=/dev/sda of=mbr.backup bs=512 count=1

# Common Options
bs=     # Block size
count=  # Number of blocks
status=progress    # Show progress
conv=sync,noerror # Continue on errors
EOF
    
    echo -e "\n2. DD Safety Tips:"
    cat << 'EOF'
1. ALWAYS verify device names multiple times
2. Use 'lsblk' before DD operations
3. Never DD to a mounted filesystem
4. Consider using 'ddrescue' for data recovery
5. Make backups before DD operations
EOF
    
    read -p "Press ENTER to continue..."
}

section_bind_mounts() {
    echo -e "\n=== Bind Mounts ==="
    
    echo -e "\n1. Basic Bind Mount:"
    cat << 'EOF'
# Mount directory to another location
mount --bind /source /destination

# Mount read-only bind
mount --bind -o ro /source /destination

# FSTAB entry for bind mount
/source    /destination    none    bind    0    0
EOF
    
    echo -e "\n2. Common Use Cases:"
    cat << 'EOF'
1. Expose directories to chroot environments
2. Override parts of read-only filesystem
3. Share directories between namespaces
4. Testing directory structures
EOF
    
    echo -e "\n3. Example Bind Mount Script:"
    cat << 'EOF'
#!/bin/bash
# Temporarily override a configuration file

ORIGINAL="/etc/config"
OVERRIDE="/tmp/config.override"
BACKUP="${ORIGINAL}.backup"

# Backup original
cp "$ORIGINAL" "$BACKUP"

# Create bind mount
mount --bind "$OVERRIDE" "$ORIGINAL"

# Do work here...

# Unmount when done
umount "$ORIGINAL"

# Restore original if needed
# cp "$BACKUP" "$ORIGINAL"
EOF
    
    read -p "Press ENTER to continue..."
}

create_example_script() {
    echo -e "\n=== Creating Example Mount Script ==="
    
    cat << 'EOF' > safe_mount.sh
#!/bin/bash
# Safe Mount Script with Error Checking

usage() {
    echo "Usage: $0 [-u UUID] [-d device] [-l label] -m mountpoint"
    echo "Example: $0 -u 1234-5678 -m /mnt/data"
    exit 1
}

# Parse arguments
while getopts "u:d:l:m:h" opt; do
    case $opt in
        u) UUID="$OPTARG";;
        d) DEVICE="$OPTARG";;
        l) LABEL="$OPTARG";;
        m) MOUNTPOINT="$OPTARG";;
        h) usage;;
        ?) usage;;
    esac
done

# Verify we have a mount point
if [ -z "$MOUNTPOINT" ]; then
    echo "Error: Mount point is required"
    usage
fi

# Verify we have something to mount
if [ -z "$UUID" ] && [ -z "$DEVICE" ] && [ -z "$LABEL" ]; then
    echo "Error: Need either UUID, device, or label"
    usage
fi

# Create mount point if it doesn't exist
if [ ! -d "$MOUNTPOINT" ]; then
    mkdir -p "$MOUNTPOINT" || {
        echo "Error: Could not create mount point"
        exit 1
    }
fi

# Construct mount command
if [ -n "$UUID" ]; then
    MOUNT_SRC="UUID=$UUID"
elif [ -n "$LABEL" ]; then
    MOUNT_SRC="LABEL=$LABEL"
else
    MOUNT_SRC="$DEVICE"
fi

# Check if already mounted
if mountpoint -q "$MOUNTPOINT"; then
    echo "Error: $MOUNTPOINT is already mounted"
    exit 1
fi

# Attempt mount
echo "Mounting $MOUNT_SRC to $MOUNTPOINT"
mount "$MOUNT_SRC" "$MOUNTPOINT" || {
    echo "Error: Mount failed"
    exit 1
}

echo "Successfully mounted to $MOUNTPOINT"
EOF
    
    chmod +x safe_mount.sh
    echo "Created safe_mount.sh"
    echo "Try running: ./safe_mount.sh -h"
}

main_menu() {
    while true; do
        show_header
        echo -e "\nSelect a section:"
        echo "1. Block Devices and Information"
        echo "2. Mount Operations"
        echo "3. FSTAB Configuration"
        echo "4. NFS Mounts"
        echo "5. DD Operations"
        echo "6. Bind Mounts"
        echo "7. Create Example Script"
        echo "8. Exit"
        
        read -p "Enter choice (1-8): " choice
        
        case $choice in
            1) section_block_devices ;;
            2) section_mount_operations ;;
            3) section_fstab_configuration ;;
            4) section_nfs_mounts ;;
            5) section_dd_operations ;;
            6) section_bind_mounts ;;
            7) create_example_script ;;
            8) echo "Thank you for using the tutorial!"; exit 0 ;;
            *) echo "Invalid option. Press ENTER to continue..."; read ;;
        esac
    done
}

# Start the tutorial
main_menu
