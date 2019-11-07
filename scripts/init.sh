#!/bin/bash
# Initial setup for a scratch org

###############################################################
# REQUIREMENT
# Set perms for script by running: chmod u+x ./scripts/init.sh
###############################################################

# Exit if there is any issue, do not continue execution
set -e

ORG_DURATION=7
ALIAS_NAME=ebikesScratch

function setUserArgs() {
    while [[ $# > 1 ]]
    do
        key="$1"

        case $key in
        -)
            ALIAS_NAME="$2"
            shift # past argument
            ;;
        -d)
            ORG_DURATION="$2"
            shift # past argument
            ;;
        *)
            # unknown option
            ;;
        esac
    shift # past argument or value
    done
}

# Authenticate against the dev hub and assign the alias "mydevhub"
echo "Authing against dev hub. Set alias 'mydevhub'"
#sfdx force:auth:web:login -d -a mydevhub

# Create the default scratch org with the alias "ebikesScratch"
echo "Creating scratch org. Set alias 'ebikesSratch'"
#sfdx force:org:create -s -f config/project-scratch-def.json -a ebikesScratch

# Push source to scratch org
echo "Pushing source to scratch org"
sfdx force:source:push

# Assign the ebikes perm set to the ebikesScratch org
echo "Assigning perm set 'ebikes' to default scratch org user"
sfdx force:user:permset:assign -n ebikes -u ebikesScratch2

# Load sample data
echo "Importing sample data to scratch org"
sfdx force:data:tree:import --plan ./data/sample-data-plan.json

# Deploy community metadata
echo "Deploying community metadata to scratch org"
sfdx force:mdapi:deploy -u ebikesScratch2 --deploydir mdapiDeploy/unpackaged -w 1