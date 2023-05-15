#!/bin/sh
NAME="ecut"

for CUTOFF in  10 15 20 25 30 35 40
do
CUTOFFRHO=$((8*$CUTOFF))
cat > ${NAME}_${CUTOFF}.in << EOF
 &control
  calculation = 'scf'
  prefix = 'si'
  outdir = './'
  pseudo_dir = './pseudo/'
  verbosity = 'high' 
 /
 &system
  ecutwfc = $CUTOFF
  ecutrho = $CUTOFFRHO
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
8 8 8 0 0 0
ATOMIC_POSITIONS angstrom
Si      0.0000000   0.0000000   0.0000000
Si      1.3452500   1.3452500   1.3452500
CELL_PARAMETERS angstrom
  2.6905000   2.6905000   0.0000000 
  2.6905000   0.0000000   2.6905000 
  0.0000000   2.6905000   2.6905000 
EOF

pw.x -inp ${NAME}_${CUTOFF}.in > ${NAME}_${CUTOFF}.out
echo ${NAME}_${CUTOFF}
E=`grep ! ${NAME}_${CUTOFF}.out | awk '{print $5}'`
echo $CUTOFF $E  >> convergence_cutoff.dat

done
