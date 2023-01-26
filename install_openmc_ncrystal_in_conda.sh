#!/usr/bin/env bash

#
# Install NCrystal and OpenMC in a conda environment in Ubuntu/Mint/etc distros
#

# Install prerequisites
sudo apt install -y git g++ cmake libhdf5-dev libpng-dev openmpi-bin libopenmpi-dev

# Create installation directory
mkdir openmc_ncrystal_conda
cd openmc_ncrystal_conda

conda create -y --name openmc_ncrystal_develop python=3.9
conda activate openmc_ncrystal_develop
conda install -y pip

# Install NCrystal
git clone https://github.com/mctools/ncrystal.git
mkdir build_ncrystal
cd build_ncrystal
cmake ../ncrystal -DCMAKE_INSTALL_PREFIX=$CONDA_PREFIX
make -j 8
make install
source $CONDA_PREFIX/setup.sh
nctool --test
cd ../

# Install OpenMC
git clone --recurse-submodules https://github.com/openmc-dev/openmc.git
cd openmc
git checkout develop
cd ../
mkdir build_openmc
cd build_openmc
cmake ../openmc -DOPENMC_USE_NCRYSTAL=on -DCMAKE_INSTALL_PREFIX=$CONDA_PREFIX
make -j 8
make install
cd ../openmc
pip install .
cd ../

conda install -y pip jupyter

# Install OpenMC data (ENDF/B-VIII.0 library)
wget -O endf8.xz https://anl.box.com/shared/static/uhbxlrx7hvxqw27psymfbhi7bx7s6u6a.xz
tar -xJf endf8.xz

