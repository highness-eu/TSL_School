import numpy as np
import matplotlib.pyplot as plt



# load data
data = np.loadtxt('./si_bands.dat.gnu')

k = np.unique(data[:, 0])
bands = np.reshape(data[:, 1], (-1, len(k)))

for band in range(len(bands)):
    plt.plot(k, bands[band, :], linewidth=1, alpha=0.5, color='k')
plt.xlim(min(k), max(k))


# High symmetry k-points (check bands_pp.out)
plt.axvline(0.6124, linewidth=0.75, color='k', alpha=0.5)
plt.axvline(1.3195, linewidth=0.75, color='k', alpha=0.5)
plt.axvline(1.5695, linewidth=0.75, color='k', alpha=0.5)
# text labels
plt.xticks(ticks= [0, 0.6124, 1.3195, 1.5695, 2.3195], \
           labels=['L', '$\Gamma$', 'X', 'U', '$\Gamma$'])
plt.ylabel("Energy (eV)")


plt.savefig('bands.pdf',dpi=1200, bbox_inches='tight')
