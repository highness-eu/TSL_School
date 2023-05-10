#!/usr/bin/env bash

conda tsl_env
source $CONDA_PREFIX/setup.sh
export LD_LIBRARY_PATH=
export TSL_SCHOOL_DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

