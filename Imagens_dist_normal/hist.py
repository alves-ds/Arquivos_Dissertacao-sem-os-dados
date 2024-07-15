import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import norm
import matplotlib.patches as patches

dist_1 = np.random.normal(loc=10, scale=1, size=1000)

count, bins, ignored = plt.hist(dist_1, bins=30, density=True, alpha=0.6, color='b')
mu, std = norm.fit(dist_1)
xmin, xmax = plt.xlim()
x = np.linspace(xmin, xmax, 100)
p = norm.pdf(x, mu, std)

plt.plot(x, p, 'k', linewidth=2)
title = "Gráfico simulado de distribuição com: média = %.2f,  desvio padrão = %.2f" % (mu, std)
plt.title(title)

plt.show()
