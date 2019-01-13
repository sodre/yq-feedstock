#!/usr/bin/env bash

# PLEASE NOTE: This script has been automatically generated by conda-smithy. Any changes here
# will be lost next time ``conda smithy rerender`` is run. If you would like to make permanent
# changes to this script, consider a proposal to conda-smithy so that other feedstocks can also
# benefit from the improvement.

set -xeuo pipefail
export PYTHONUNBUFFERED=1
export FEEDSTOCK_ROOT=${FEEDSTOCK_ROOT:-/home/conda/feedstock_root}
export RECIPE_ROOT=${RECIPE_ROOT:-/home/conda/recipe_root}
export CI_SUPPORT=${FEEDSTOCK_ROOT}/.ci_support
export CONFIG_FILE="${CI_SUPPORT}/${CONFIG}.yaml"

conda install --yes --quiet conda-forge-ci-setup=2 conda-build -c conda-forge

# set up the condarc
setup_conda_rc "${FEEDSTOCK_ROOT}" "${RECIPE_ROOT}" "${CONFIG_FILE}"

# A lock sometimes occurs with incomplete builds. The lock file is stored in build_artifacts.
conda clean --lock

source run_conda_forge_build_setup

export CONDA_BLD_PATH=${FEEDSTOCK_ROOT}/build-artifacts

# make the build number clobber
make_build_number "${FEEDSTOCK_ROOT}" "${RECIPE_ROOT}" "${CONFIG_FILE}"

conda build "${RECIPE_ROOT}" -m "${CI_SUPPORT}/${CONFIG}.yaml" \
    --clobber-file "${CI_SUPPORT}/clobber_${CONFIG}.yaml" \


upload_package "${FEEDSTOCK_ROOT}" "${RECIPE_ROOT}" "${CONFIG_FILE}"


touch "${FEEDSTOCK_ROOT}/build_artifacts/conda-forge-build-done-${CONFIG}"