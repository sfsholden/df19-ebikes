#!/bin/bash
# Initial setup for a dev hub and scratch org

# Exit if there is any issue, do not continue execution
set -e

DEV_HUB_ORG_ALIAS=
SCRATCH_ORG_ALIAS=
ORG_DURATION=

while [[ $# > 1 ]]
do
    key="$1"

    case $key in
    --devhuborg)
        DEV_HUB_ORG_ALIAS="$2"
        shift # past argument
        ;;
    --scratchorg)
        SCRATCH_ORG_ALIAS="$2"
        shift # past argument
        ;;
    --durationdays)
        ORG_DURATION="$2"
        shift # past argument
        ;;
    *)
        # unknown option
        ;;
    esac
shift # past argument or value
done

echo -e "\nAuthenticating against the dev hub org with alias '${DEV_HUB_ORG_ALIAS}'"
sfdx force:auth:web:login -d -a ${DEV_HUB_ORG_ALIAS}

echo -e "\nCreating the default scratch org with alias '${SCRATCH_ORG_ALIAS}' and org duration ${ORG_DURATION}"
sfdx force:org:create -s -d ${ORG_DURATION} -a ${SCRATCH_ORG_ALIAS} -f config/project-scratch-def.json

echo -e "\nPushing source to scratch org '${SCRATCH_ORG_ALIAS}'"
sfdx force:source:push

echo -e "\nAssigning perm set 'ebikes' to default scratch org user"
sfdx force:user:permset:assign -n ebikes