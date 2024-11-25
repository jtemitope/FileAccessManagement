## Overview

This Bash script automates the creation of a project directory, the management of user groups, and the setup of specific file permissions for a Linux environment. It is designed to ensure that the members of a project team have the correct access to project resources, while preventing unauthorized users from modifying or accessing sensitive files.

## Features
* **Creates a Project Directory:** The script creates a project directory (/opt/project) with sub-directories for documents and scripts.
* **Manages User Groups:** A new user group is created, and specific users are added to this group.
* **Sets Group Permissions:** The script ensures that the group has full control over the project directory while restricting access to others.
* **Configures Group Ownership:** The SGID (Set Group ID) bit is applied, ensuring that new files inherit the group ownership of the parent directory.
* **Test Files:** The script creates two test files, one with read-only permissions for the group and another with execute permissions.

## Prerequisites
* A Linux system with bash shell support.
* `sudo` privileges to create users, modify group settings, and manage permissions.
* The users to be added to the group should exist, or the script can create new ones if necessary.

## Installation
1. Clone or download this repository to your local machine:
```
git clone https://github.com/jtemitope/FileAccessManagement.git
```
2. Navigate to the directory where the script is located
```
cd FileAccessManagement
```
3. Make sure the script is executable:
```
chmod +x filemanagement.sh
```

## Usage
To run the script, execute it with `sudo` since it requires administrative privileges for group and user management:
```
sudo ./filemanagement.sh
```
The script will perform the following tasks:

1. **Create directories** at `/opt/project/documents` and `/opt/project/scripts`.
2. **Create a new user group** called `project_team` (if it does not already exist).
3. **Add the specified users** (e.g., `user1` and `user2`) to the group.
4. **Set permissions** so that only members of the group can read and write to the project directory, while others have no access.
5. **Apply the SGID bit**, ensuring that new files within the project directory inherit group ownership.
6. **Apply sticky bit**, to enhance directory security.
7. **Create test files** with specified permissions: a read-only file (`read_file.txt`) and an executable file (`exec_file.sh`).

## Script Structure
- **Variables**: Customize the script by editing the following variables:
    
    - `PROJECT_DIR`: The base directory for the project (default: `/opt/project`).
    - `GROUP_NAME`: The name of the group to be created (default: `project_team`).
    - `USER1` and `USER2`: The users to be added to the group (default: `user1` and `user2`).
    
- **Directory Creation**: The script uses `mkdir -p` to create the project directory and its sub-directories for documents and scripts.
    
- **Group and User Management**: It checks if users exist and adds them to the project team group with `usermod -aG`. If a user does not exist, the script creates them using `useradd`.
    
- **Permissions**: The script sets permissions using `chmod` and changes ownership using `chown`. The group is given full access (`770`), and others have no access.
    
- **Test Files**: It creates two files (`read_only.txt` and `executable.sh`) within the directories, each with specific permissions.

## **Challenges Faced**

1. **User Existence Check**: Initially, the script assumed that all users would exist. To prevent errors, I added logic to check if a user exists and create them if necessary.
    
2. **Permission Configuration**: Setting the correct permissions (`770` for the group and `0` for others) and applying the SGID bit was crucial to ensure secure and appropriate access control.
    
3. **File Ownership Inheritance**: The use of the SGID bit ensures that new files inherit the group ownership of the parent directory, which is especially useful when working in teams.

## **Script Output**

The script outputs clear messages for each step it performs, such as:

- **Directory creation**: Confirmation when directories are created.
- **Group and user management**: Feedback on group creation and user additions.
- **Permissions settings**: Information about permission changes and group ownership setup.
- **Test file creation**: Confirmation of the creation of test files with their specific permissions.

Example of script output:
```
Creating project directories...
Project directories created: /opt/project/documents, /opt/project/scripts
Creating group project_team...
Group 'project_team' created successfully.
User user1 exists. Adding to group project_team...
User user2 exists. Adding to group project_team...
Permissions and group ownership configured successfully.
Test files created: read_file.txt (read-only), exec_file.sh (executable)
```

## **Testing**
1. **Verify the project directory**:  
    Check that the directories `documents` and `scripts` exist:
```
ls -l /opt/project/
```
    
2. **Check Group Membership**:  
    Ensure that users are part of the `project_team` group:
```
groups user1
groups user2
```
    
3. **Check Permissions**:  
    Verify that the permissions for the test files are set correctly:
```
ls -l /opt/project/documents/read_only.txt /opt/project/scripts/executable.sh
```

## **Contributing**

Feel free to contribute to this project by opening issues or submitting pull requests. You can:

- Suggest improvements or new features.
- Provide feedback.
- Contribute to the documentation.

## **Conclusion**

This Bash script simplifies managing project directories, user groups, and file permissions in Linux. By automating these processes, you can reduce the risk of human error and ensure that users have the correct level of access to resources.

If you found this useful, please share your thoughts or improvements! You can find the full script in my [GitHub repository](https://github.com/jtemitope/FileAccessManagement.git)
