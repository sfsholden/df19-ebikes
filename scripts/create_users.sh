#!/bin/bash
# Creates new users based on predefined definition file
# For this example, we have a user that has the appropriate
# ebikes perm set, and one that does not.

# Exit if there is any issue, do not continue execution
set -e

EMAIL=none

# Determine the email for the new user
function getEmailArgument() {
    while [[ $# > 1 ]]; do
        if ("$1" = '-e') {
            EMAIL="$2"
        }
        shift   # shift $2 to $1, etc.
    done
}

function createUsers() {
    echo "Creating ebikes user"
    sfdx force:user:create -f config/users/ebikes_user.json
    echo "Creating non-ebikes user"
    sfdx force:user:create -f config/users/standard_user.json
}

function createUsersWithEmail() {
    echo "Creating ebikes user with email address ${EMAIL}"
    sfdx force:user:create -f config/users/ebikes_user.json email=$EMAIL
    echo "Creating non-ebikes user with email address ${EMAIL}"
    sfdx force:user:create -f config/users/standard_user.json email=$EMAIL
    echo "Resetting passwords for users. Password reset links sent to ${EMAIL}"
    sfdx force:apex:execute -f scripts/reset_pwd.apex
}

getEmailArgument();

if [ "${EMAIL}" = "none" ]; 
then
    createUsers();
else
    createUsersWithEmail();
fi