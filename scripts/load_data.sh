#!/bin/bash
# Loads sample data into the scratch org

# Exit if there is any issue, do not continue execution
set -e

echo -e "\nImporting sample data to scratch org"
sfdx force:data:tree:import --plan ./data/sample-data-plan.json

echo -e "\nDeploying community metadata to scratch org"
sfdx force:mdapi:deploy --deploydir mdapiDeploy/unpackaged -w 1