#!/bin/bash

echo -e "\nPushing source to scratch org '${SCRATCH_ORG_ALIAS}'"
sfdx force:source:push

echo -e "\nAssigning perm set 'ebikes' to default scratch org user"
sfdx force:user:permset:assign -n ebikes

#TODO - also need to refresh sobject definitions. This looked like a good spot.