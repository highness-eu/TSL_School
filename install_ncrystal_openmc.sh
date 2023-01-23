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
#
# More instructions here:
# https://github.com/mctools/ncrystal/blob/master/INSTALL
#
git clone https://github.com/mctools/ncrystal.git
mkdir build_ncrystal
cd build_ncrystal
cmake ../ncrystal
make -j 4
sudo make install
source /usr/local/setup.sh
nctool --test
echo "source /usr/local/setup.sh" >> ~/.bashrc
cd ../

# Install OpenMC
#
# More instructions here:
# https://docs.openmc.org/en/latest/usersguide/install.html#installing-from-source
#
git clone --recurse-submodules https://github.com/openmc-dev/openmc.git
cd openmc
git checkout develop
cd ../
mkdir build_openmc
cd build_openmc
cmake ../openmc -DOPENMC_USE_NCRYSTAL=on
make -j 4
sudo make install
cd ../openmc
pip install .
cd ../

# Install OpenMC data (ENDF/B-VIII.0 library)
wget -O endf8.xz https://anl.box.com/shared/static/uhbxlrx7hvxqw27psymfbhi7bx7s6u6a.xz
tar -xJf endf8.xz
