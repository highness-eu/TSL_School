import numpy as np
import matplotlib.pyplot as plt
dos = np.loadtxt('./matdyn.dos')
x=dos[:,0]
y=dos[:,1]
plt.plot(x, y, "-", markersize=5, label='Phonon DOS')
plt.xlabel('Energy (cm-1)')
plt.ylabel('DOS (states/cm-1/cell)')
plt.legend(frameon=False)
plt.savefig('phonon_dos.pdf',dpi=1200, bbox_inches='tight')
