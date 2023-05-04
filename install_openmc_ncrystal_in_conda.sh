#!/usr/bin/env bash

#
# Install NCrystal and OpenMC in a conda environment in Ubuntu/Mint/etc distros
#

# Install prerequisites
# sudo apt install -y git g++ cmake libhdf5-dev libpng-dev curl xcrysden
# 
# curl --output anaconda.sh https://repo.anaconda.com/archive/Anaconda3-2023.03-Linux-x86_64.sh
# chmod +x anaconda.sh
# ./anaconda.sh

conda update -y -n base conda
conda install -y -n base conda-libmamba-solver
conda config --set solver libmamba

# Create installation directory
mkdir openmc_ncrystal_vm
cd openmc_ncrystal_vm

conda create -y --name openmc_ncrystal_vm python=3.9
conda activate openmc_ncrystal_vm
conda install -y pip
conda install -y -c conda-forge pyside2 jupyterlab qe

# Install NCrystal
git clone https://github.com/mctools/ncrystal.git
mkdir build_ncrystal && cd build_ncrystal
cmake ../ncrystal -DCMAKE_INSTALL_PREFIX=$CONDA_PREFIX  -DNCRYSTAL_BUILTIN_PLUGINS="XuShuqi7:MagScat::main;highness-eu:SANSND::main"
make -j 2
make install
source $CONDA_PREFIX/setup.sh
export LD_LIBRARY_PATH=
ncrystal_inspectfile --test
cd ../

# Install MCPL
git clone https://github.com/mctools/mcpl.git 
mkdir build_mcpl && cd build_mcpl
cmake ../mcpl  -DCMAKE_INSTALL_PREFIX=$CONDA_PREFIX
make -j 2
make install
cd ../


# Install OpenMC
git clone --recurse-submodules https://github.com/openmc-dev/openmc.git
cd openmc
git checkout develop
cd ../
mkdir build_openmc && cd build_openmc
cmake ../openmc -DOPENMC_USE_NCRYSTAL=on -DOPENMC_USE_MCPL=on -DCMAKE_INSTALL_PREFIX=$CONDA_PREFIX
make -j 2 && make install
cd ../openmc
pip install .
python -c "import openmc; print(openmc.Material.from_ncrystal('Al_sg225.ncmat'))"
cd ../

pip install openmc-plotter

pip install ipympl matplotlib spglib gemmi ase pymatgen cif2cell

# Install OpenMC data (ENDF/B-VIII.0 library)
wget -O endf8.xz https://anl.box.com/shared/static/uhbxlrx7hvxqw27psymfbhi7bx7s6u6a.xz && tar -xJf endf8.xz
