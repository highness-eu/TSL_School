import numpy as np
import matplotlib.pyplot as plt



# load data
data = np.loadtxt('./aln.freq.gp')

k = data[:, 0]
nmodes=12

for band in range(1,nmodes+1):
    plt.plot(k, data[:, band], linewidth=1, alpha=0.5, color='k')
plt.xlim(min(k), max(k))


# High symmetry k-points (check bands_pp.out)
plt.axvline(0.3119, linewidth=0.75, color='k', alpha=0.5)
plt.axvline(0.8892, linewidth=0.75, color='k', alpha=0.5)
plt.axvline(1.2225, linewidth=0.75, color='k', alpha=0.5)
# text labels
plt.xticks(ticks= [0, 0.3119, 0.8892, 1.2225, 1.8892], \
           labels=['A', '$\Gamma$', 'M', 'K', '$\Gamma$'])
plt.ylabel("Energy (eV)")


plt.savefig('phonons.pdf',dpi=1200, bbox_inches='tight')
