#!/bin/bash
DIR=$(dirname "$0")
VERSION=$(./tools/get-version.sh)
mkdir -p "${DIR}/../dist"
sed -e "s/VERSION_PLACEHOLDER/${VERSION}/" \
    "${DIR}/../dist/python-ansible-compat.spec.in" \
    > "${DIR}/../dist/python-ansible-compat.spec"

export LC_ALL=en_US.UTF-8
CHANGELOG=$(git log -n 20 --pretty="* %ad %an %ae \n- %s\n" --date=format:"%a %b %d %Y")
NUM=$(grep -nr "%changelog" ${DIR}/../dist/python-ansible-compat.spec|awk -F':' '{print $1}')
let NUM_START=$NUM+1
NUM_END=$(awk '{print NR}' ${DIR}/../dist/python-ansible-compat.spec|tail -n1)
sed -i "${NUM_START},${NUM_END}d" ${DIR}/../dist/python-ansible-compat.spec
echo -e "$CHANGELOG" >> ${DIR}/../dist/python-ansible-compat.spec
