#!/usr/bin/env bash

source ~/anaconda3/etc/profile.d/conda.sh
conda activate openmc_ncrystal_vm
source $CONDA_PREFIX/setup.sh
export LD_LIBRARY_PATH=

cd ~/openmc_ncrystal_vm
cd mcpl
git pull
cd ../build_mcpl
make -j 2 
make install
cd ..

cd ncrystal
git checkout develop
git pull
cd ../build_ncrystal
make -j 2 
make install
cd ..

cd openmc
git pull
cd ../build_openmc
make -j 2
make install
cd ../openmc
pip install .
cd ..
