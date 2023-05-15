import numpy as np
import matplotlib.pyplot as plt



# load data
data = np.loadtxt('./si.freq.gp')

k = data[:, 0]
nmodes=6

for band in range(1,nmodes+1):
    plt.plot(k, data[:, band], linewidth=1, alpha=0.5, color='k')
plt.xlim(min(k), max(k))

data = np.loadtxt('../2x2x2/si.freq.gp')

k = data[:, 0]
nmodes=6

for band in range(1,nmodes+1):
    plt.plot(k, data[:, band], linewidth=1, alpha=0.5, color='r')
plt.xlim(min(k), max(k))


# High symmetry k-points (check bands_pp.out)
plt.axvline(0.6124, linewidth=0.75, color='k', alpha=0.5)
plt.axvline(1.3195, linewidth=0.75, color='k', alpha=0.5)
plt.axvline(1.5695, linewidth=0.75, color='k', alpha=0.5)
# text labels
plt.xticks(ticks= [0, 0.6124, 1.3195, 1.5695, 2.3195], \
           labels=['L', '$\Gamma$', 'X', 'U', '$\Gamma$'])
plt.ylabel("Energy (eV)")


plt.savefig('grid_comparison.pdf',dpi=1200, bbox_inches='tight')
