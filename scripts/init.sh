#!/bin/bash
# Initial setup for a scratch org

# set perms chmod u+x ./scripts/project_setup.sh
# end immediately on non-zero exit codes
set -e

# Installs the node modules
#npm install

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
echo "Assigning perm set 'ebikes' to scratch org user"
sfdx force:user:permset:assign -n ebikes -u ebikesScratch2

# Load sample data
echo "Importing sample data to scratch org"
sfdx force:data:tree:import --plan ./data/sample-data-plan.json

# Deploy community metadata
echo "Deploying community metadata to scratch org"
sfdx force:mdapi:deploy -u ebikesScratch2 --deploydir mdapiDeploy/unpackaged -w 1