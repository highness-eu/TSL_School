#!/usr/bin/env bash

#
# Install NCrystal and OpenMC in Ubuntu/Mint/etc distros
#

# Install prerequisites
sudo apt install -y git g++ cmake libhdf5-dev libpng-dev openmpi-bin libopenmpi-dev pip jupyter 

# Create installation directory
mkdir openmc_ncrystal
cd openmc_ncrystal

# Install NCrystal
git clone https://github.com/mctools/ncrystal.git
mkdir build_ncrystal
cd build_ncrystal
cmake ../ncrystal
make -j 4
sudo make install
nctool --test
cd ../

# Install OpenMC 
git clone --recurse-submodules https://github.com/highness-eu/openmc.git
cd openmc
git checkout mixed_ncrystal
cd ../
mkdir build_openmc
cd build_openmc
cmake ../openmc -DOPENMC_USE_NCRYSTAL=on
make -j 4
sudo make install
cd ../openmc
pip install .
cd ../
