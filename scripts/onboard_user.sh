#!/bin/bash
# =====================================================
# onboard_user.sh - User Onboarding Automation
# Author: Mohammad Maaz
# Description: Automate new user creation with SSH key
#======================================================

# Colours for better output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "=================================================="
echo "          USER ONBOARDING SYSTEM"
echo "=================================================="
echo ""

# Function to show usage
show_usage() {
     echo "Usage: $0 <username> <fullname> [group]"
     echo ""
     echo "Examples:"
     echo " $0 mohammad 'Mohammad Maaz' developer"
     exit 1
}

# Check if username is provided
if [ -z "$1" ]; then
   echo -e "${RED}ERROR: Username required${NC}"
   show_usage
fi

USERNAME=$1
FULLNAME=$2
GROUP=${3:-"users"} # Default gorup is 'user'

# Check if user is already exist
if id "$USERNAME" &>/dev/null; then
    echo -e "${RED}ERROR: User $USERNAME already exists${NC}"
    exit 1
fi

echo -e "${YELLOW}Creating user: $USERNAME ($FULLNAME)${NC}"
echo "Group: $GROUP"
echo ""

# Creating user with home directory
sudo useradd -m -s /bin/bash -c "$FULLNAME" "$USERNAME"
sudo usermod -aG "$GROUP" "$USERNAME"
echo -e "${GREEN}✓ User created${NC}"

# Create SSH directory
sudo mkdir -p /home/$USERNAME/.ssh
sudo chmod 700 /home/$USERNAME/.ssh

# Generate SSH key for user
sudo ssh-keygen -t rsa -b 4096 -f /home/$USERNAME/.ssh/id_rsa -N "" -C "$USERNAME@onboarded"
echo -e "${GREEN}✓ SSH key generated${NC}"

# Copy public key to authorized key
sudo cp /home/$USERNAME/.ssh/id_rsa.pub /home/$USERNAME/.ssh/authorized_keys
sudo chmod 600 /home/$USERNAME/.ssh/authorized_keys

# Fix ownership
sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh

# Set password (force changend on first login)
echo "$USERNAME: temppass" | sudo chpasswd
sudo passwd -e "$USERNAME" &>/dev/null
echo -e "${GREEN}✓ Temporary password set: temppass${NC}"

# Generate report
echo ""
echo "========================================================"
echo "                 ONBOARDING REPORT"
echo "========================================================"
echo ""
echo "Username       : $USERNAME"
echo "Full Name      : $FULLNAME"
echo "Home           : /home/$USERNAME"
echo "Group          : $GROUP"
echo ""
echo "SSH key (PRIVATE)"
echo "--------------------------------------------------------"
echo "cat /home/$USERNAME/.ssh/id_rsa"
echo "--------------------------------------------------------"
echo ""
echo "Login Instruction:"
echo "1. Save the private key above to a file"
echo "2. Connect: ssh -i private-key $USERNAME@$(hostname -I | awk '{print $1}')"
echo "3. Password: temppass (you must change it)"
echo ""
echo "========================================================"
echo "             Onboarding Completed!"
echo "========================================================"

