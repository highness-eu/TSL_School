import numpy as np
import matplotlib.pyplot as plt
x, y = np.loadtxt('./convergence_kgrid.dat', delimiter=' ', unpack=True)
plt.plot(x, y, "o-", markersize=5, label='Etot vs Kgrid')
plt.xlabel('Kgrid')
plt.ylabel('Etot (Ry)')
plt.legend(frameon=False)
plt.savefig('kgrid_convergence.pdf',dpi=1200, bbox_inches='tight')
