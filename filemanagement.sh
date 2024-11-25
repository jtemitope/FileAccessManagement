#!/bin/bash

# Defining variables
PROJECT_DIR="/opt/project"
GROUP_NAME="project_team"
ROOT_USER="root"
USER1="Betty"
USER2="John"

# Creating project directories
# Using mkdir -p parent_dir/sub_dir to create nested directories in one go
echo "Creating project directories..."
mkdir -p "$PROJECT_DIR/documents" "$PROJECT_DIR/scripts"
echo "Project directories created at $PROJECT_DIR."

# Creating the group
echo "Creating group $GROUP_NAME"
if getent group "$GROUP_NAME" &>/dev/null; then
    echo "Group $GROUP_NAME already exists."
else
    groupadd "$GROUP_NAME" && echo "Group $GROUP_NAME created."
fi

# Ensure users exist and add them to the group
echo "Checking and adding users to the group..."
for USER in "$USER1" "$USER2"; do
    # Check if the user exists
    if id "$USER" &>/dev/null; then
        echo "User $USER exists. Adding to group $GROUP_NAME..."
    else
        echo "User $USER does not exist. Creating user..."
        useradd "$USER" && echo "User $USER created."
    fi

    # Add the created user to group
    usermod -aG "$GROUP_NAME" "$USER" && echo "User $USER added to group $GROUP_NAME"
done

# Setting group ownership and permission for project directory
echo "Setting group ownership and permissions for $PROJECT_DIR..."
chown -R :$GROUP_NAME "$PROJECT_DIR"        # Set group ownership
chmod -R 770 "$PROJECT_DIR"                 # Full access for group, none for others
chmod g+s "$PROJECT_DIR"                    # Ensuring that new files inherit group ownership
echo "Permission and group ownership configured."

# Creating test files with specific permissions
echo "Creating test files with specific permissions..."
touch "$PROJECT_DIR/documents/read_file.txt" "$PROJECT_DIR/scripts/exec_file.sh"
chmod 440 "$PROJECT_DIR/documents/read_file.txt"        # Read-only permission for group
chmod 550 "$PROJECT_DIR/scripts/exec_file.sh"           # Execute permission for group
echo "Test files created: read_file.txt (read-only), exec_file.sh (executable)"

# Setting Ownership to a privileged user and adding sticky bit for security
echo "Setting ownership to $ROOT_USER and applying sticky bit..."
chown $ROOT_USER:"$GROUP_NAME" "$PROJECT_DIR"
chmod +t "$PROJECT_DIR"
echo "Sticky bit applied to $PROJECT_DIR. Only file creators can delete their files."

# Final Output
echo "Project setup complete! Summary of actions:"
echo "- Project directories created at: $PROJECT_DIR"
echo "- Group '$GROUP_NAME' created and users $USER1, $USER2 added."
echo "- Permissions set: Full access for group '$GROUP_NAME', no access for others."
echo "- Test files created with specific permissions."

# Verifying setup
ls -ld "$PROJECT_DIR"
ls -l "$PROJECT_DIR/documents"
ls -l "$PROJECT_DIR/scripts"