import numpy as np
import matplotlib.pyplot as plt
x, y = np.loadtxt('./convergence_cutoff.dat', delimiter=' ', unpack=True)
plt.plot(x, y, "o-", markersize=5, label='Etot vs cutoff')
plt.xlabel('Cutoff (Ry)')
plt.ylabel('Etot (Ry)')
plt.legend(frameon=False)
plt.savefig('ecut_convergence.pdf',dpi=1200, bbox_inches='tight')
