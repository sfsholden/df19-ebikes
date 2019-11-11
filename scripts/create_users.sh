#!/bin/bash
# Creates new users based on predefined definition file.
# For this example, we have a user that has the appropriate
# ebikes perm set, and one that does not.

# Exit if there is any issue, do not continue execution
set -e

function createUsers {
    if [ ${EMAIL} == "none" ]
    then
        createUsersWithoutEmail
    else
        createUsersWithEmail
    fi
}

function createUsersWithoutEmail {
    echo "Creating System Admin User"
    sfdx force:user:create -f config/users/system_admin.json
    echo -e "\nCreating Standard Platform User"
    sfdx force:user:create -f config/users/standard_user.json
}

function createUsersWithEmail {
    echo "Creating System Admin User with email address ${EMAIL}"
    sfdx force:user:create -f config/users/system_admin.json email=$EMAIL
    echo -e "\nCreating Standard Platform User with email address ${EMAIL}"
    sfdx force:user:create -f config/users/standard_user.json email=$EMAIL
    echo -e "\nResetting passwords for users. Password reset links sent to ${EMAIL}"
    sfdx force:apex:execute -f scripts/reset_user_password.apex
}

if [[ "$#" -ne 2 ]]; then
    echo "Incorrect number of parameters. Expected --email flag with value."
    exit 2
elif [[ "$1" == "--email" ]]; then
    EMAIL="$2"
else
    echo "Unexpected arguments. Expected --email flag with value."
    exit 2
fi

createUsers