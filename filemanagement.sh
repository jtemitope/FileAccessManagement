#!/bin/bash

# Creating variables
PROJECT_DIR="/opt/project"
DOCS="$PROJECT_DIR/documents"
SCRIPTS="$PROJECT_DIR/scripts"
GROUP_NAME="project_team"
ROOT_USER="root"
USER1="Betty"
USER2="John"

#Creating project directories
#Using mkdir -p parent_dir/sub_dir to create nested directories in one go

echo "Creating project directories..."
mkdir -p "$DOCS" "$SCRIPTS"
echo "Directories created: $PROJECT_DIR, $DOCS, $SCRIPTS"

#Setting up User Groups and adding Users
echo "Creating group '$GROUP_NAME' and adding users..."
groupadd "$GROUP_NAME" && for USER in "$ROOT_USER" "$USER1" "$USER2"; do usermod -aG "$GROUP_NAME" "$USER"; done
echo "Group '$GROUP_NAME' created and users added: $ROOT_USER, $USER1, $USER2"

#Setting permissions for group-level control
echo "Setting group ownership and permissions..."
chown -R :$GROUP_NAME "$PROJECT_DIR"        #Group ownership
chmod -R 770 "$PROJECT_DIR"                 #Full access for group, none for others
chmod g+s "$PROJECT_DIR"                    #Ensuring that new files inherit group ownership
echo "Group ownership and permission set for '$GROUP_NAME'. All users in the group have full control"

#Setting Ownership and Sticky Bit
echo "Setting ownership to $ROOT_USER and applying sticky bit..."
chown $ROOT_USER:"$GROUP_NAME" "$PROJECT_DIR"
chmod +t "$PROJECT_DIR"
echo "Sticky bit applied to $PROJECT_DIR"

#Creating Test Files
echo "Creating test files with specific permissions..."
test_file1="$DOCS/read_file.txt"
test_file2="$SCRIPTS/exec_file.sh"

touch "$test_file1" "$test_file2"

#Setting permissions for the files created
chmod 640 "$test_file1"                 #Read-only permission for group
chmod 750 "$test_file2"                 #Execute permission for group
echo "Test files created: $test_file1 (read-only), $test_file2 (executable)"

#Giving a summary of the script
echo "Setup complete. Summary:"
echo "Project Directory: $PROJECT_DIR"
echo "Group: $GROUP_NAME"
echo "Users: $USER1, $USER2"
echo "Permissions: Group read/write, others denied"
echo "Sticky Bit: Applied to ensure file integrity"
echo "Test Files: $test_file1 (read-only), $test_file2 (executable)"
