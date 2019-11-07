#!/bin/bash
# Initial setup for a dev hub and scratch org

# Exit if there is any issue, do not continue execution
set -e

DEV_HUB_ORG_ALIAS=mydevhub
SCRATCH_ORG_ALIAS=ebikesScratch
ORG_DURATION=7

function setUserArgs() {
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
}

echo "Authenticate against the dev hub. Default alias is 'mydevhub' unless overridden."
sfdx force:auth:web:login -d -a ${DEV_HUB_ORG_ALIAS}

echo "Create the default scratch org. Default alias is 'ebikesScratch' unless overridden."
sfdx force:org:create -s -d ${ORG_DURATION} -a ${SCRATCH_ORG_ALIAS} -f config/project-scratch-def.json