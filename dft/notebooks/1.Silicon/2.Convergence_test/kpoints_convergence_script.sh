#!/bin/sh
NAME="kgrid"

for KGRID in  1 2 4 6 8 10
do
cat > ${NAME}_${KGRID}.in << EOF
 &control
  calculation = 'scf'
  prefix = 'si'
  outdir = './'
  pseudo_dir = './pseudo/'
  verbosity = 'high' 
 /
 &system
  ecutwfc = 30
  ecutrho = 240
  ibrav = 0
  nat = 2
  ntyp = 1

 /
 &electrons
  conv_thr =   4.0000000000d-10
  electron_maxstep = 100
  mixing_beta =   0.4
 /
ATOMIC_SPECIES
Si     28.0855 Si.pbe-n-rrkjus_psl.1.0.0.UPF
K_POINTS automatic
$KGRID $KGRID $KGRID 0 0 0
ATOMIC_POSITIONS angstrom
Si      0.0000000   0.0000000   0.0000000
Si      1.3452500   1.3452500   1.3452500
CELL_PARAMETERS angstrom
  2.6905000   2.6905000   0.0000000 
  2.6905000   0.0000000   2.6905000 
  0.0000000   2.6905000   2.6905000 
EOF

pw.x -inp ${NAME}_${KGRID}.in > ${NAME}_${KGRID}.out
echo ${NAME}_${KGRID}
E=`grep ! ${NAME}_${KGRID}.out | awk '{print $5}'`
echo $KGRID $E  >> convergence_kgrid.dat

done
