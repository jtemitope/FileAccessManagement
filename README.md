# Overview

This Bash script automates the creation of a project directory, the management of user groups, and the setup of specific file permissions for a Linux environment. It is designed to ensure that the members of a project team have the correct access to project resources, while preventing unauthorized users from modifying or accessing sensitive files.

### Features
* **Creates a Project Directory:** The script creates a project directory (/opt/project) with subdirectories for documents and scripts.
* **Manages User Groups:** A new user group is created, and specific users are added to this group.
* **Sets Group Permissions:** The script ensures that the group has full control over the project directory while restricting access to others.
* **Configures Group Ownership:** The SGID (Set Group ID) bit is applied, ensuring that new files inherit the group ownership of the parent directory.
* **Test Files:** The script creates two test files, one with read-only permissions for the group and another with execute permissions.

### Prerequisites
* A Linux system with bash shell support.
* sudo privileges to create users, modify group settings, and manage permissions.
* The users to be added to the group should exist, or the script can create new ones if necessary.

### Installation
1. Clone or download this repository to your local machine:

