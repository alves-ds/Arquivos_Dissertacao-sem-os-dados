# Importar bibliotecas necesarias 
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import math
from matplotlib.font_manager import FontProperties

# Este script foi construido para a geracao de um grafico que demonstra o efeito do tempo sobre a confiabilidade das estimativas de AF


# Vamos importar os valores de confiabilidade para os diferentes tempos de monitoramento

########################### Dados para caminhada #########################

# Definindo valores do eixo Y para intensidade leve

# Medida unica
ICC_leve_2_semanas_mu = 0.73
ICC_leve_3_semanas_mu = 0.75
ICC_leve_4_semanas_mu = 0.74
ICC_leve_5_semanas_mu = 0.75

# Media das medidas
ICC_leve_2_semanas_mm = 0.84
ICC_leve_3_semanas_mm = 0.90
ICC_leve_4_semanas_mm = 0.92
ICC_leve_5_semanas_mm = 0.94


# Calculando intervalos de confianca para intensidade leve

# Medida unica
asymmetric_error_icc_leve_2_semanas_mu = [[0.14], [0.09]]
asymmetric_error_icc_leve_3_semanas_mu = [[0.10], [0.08]]
asymmetric_error_icc_leve_4_semanas_mu = [[0.08], [0.08]]
asymmetric_error_icc_leve_5_semanas_mu = [[0.08], [0.07]]


# Media das medidas
asymmetric_error_icc_leve_2_semanas_mm = [[0.10], [0.06]]
asymmetric_error_icc_leve_3_semanas_mm = [[0.05], [0.04]]
asymmetric_error_icc_leve_4_semanas_mm = [[0.04], [0.03]]
asymmetric_error_icc_leve_5_semanas_mm = [[0.03], [0.02]]


# Definindo o erro padrao para as estimativas de caminhadaaf de intensidade leve
# Medidas unicas
epm_leve_2_semanas_mu = 468
epm_leve_3_semanas_mu = 451
epm_leve_4_semanas_mu = 471
epm_leve_5_semanas_mu = 465

epm_leve_mu = []


epm_leve_mu.append(epm_leve_2_semanas_mu)
epm_leve_mu.append(epm_leve_3_semanas_mu)
epm_leve_mu.append(epm_leve_4_semanas_mu)
epm_leve_mu.append(epm_leve_5_semanas_mu)



# Media das medidas
epm_leve_2_semanas_mm = 360
epm_leve_3_semanas_mm = 285
epm_leve_4_semanas_mm = 261
epm_leve_5_semanas_mm = 227


epm_leve_mm = []


epm_leve_mm.append(epm_leve_2_semanas_mm)
epm_leve_mm.append(epm_leve_3_semanas_mm)
epm_leve_mm.append(epm_leve_4_semanas_mm)
epm_leve_mm.append(epm_leve_5_semanas_mm)


########################### Dados para a intensidade moderada #########################

#Definindo valores do eixo Y para intensidade moderada

# Medida unica
ICC_moderada_2_semanas_mu = 0.73
ICC_moderada_3_semanas_mu = 0.70
ICC_moderada_4_semanas_mu = 0.72
ICC_moderada_5_semanas_mu = 0.72


# Media das medidas
ICC_moderada_2_semanas_mm = 0.84
ICC_moderada_3_semanas_mm = 0.88
ICC_moderada_4_semanas_mm = 0.91
ICC_moderada_5_semanas_mm = 0.93


#Calculando intervalos de confianca para intensidade moderada

# Medida unica
asymmetric_error_icc_moderada_2_semanas_mu = [[0.14], [0.09]]
asymmetric_error_icc_moderada_3_semanas_mu = [[0.11], [0.09]]
asymmetric_error_icc_moderada_4_semanas_mu = [[0.09], [0.08]]
asymmetric_error_icc_moderada_5_semanas_mu = [[0.09], [0.08]]


# Media das medidas
asymmetric_error_icc_moderada_2_semanas_mm = [[0.10], [0.06]]
asymmetric_error_icc_moderada_3_semanas_mm = [[0.07], [0.04]]
asymmetric_error_icc_moderada_4_semanas_mm = [[0.04], [0.03]]
asymmetric_error_icc_moderada_5_semanas_mm = [[0.04], [0.02]]


# Definindo o erro padrao para as estimativas de af moderada

# Medidas unicas
epm_moderada_2_semanas_mu = 71
epm_moderada_3_semanas_mu = 76
epm_moderada_4_semanas_mu = 72
epm_moderada_5_semanas_mu = 73


epm_moderada_mu = []


epm_moderada_mu.append(epm_moderada_2_semanas_mu)
epm_moderada_mu.append(epm_moderada_3_semanas_mu)
epm_moderada_mu.append(epm_moderada_4_semanas_mu)
epm_moderada_mu.append(epm_moderada_5_semanas_mu)



# Media das medidas
epm_moderada_2_semanas_mm = 55
epm_moderada_3_semanas_mm = 48
epm_moderada_4_semanas_mm = 41
epm_moderada_5_semanas_mm = 36

epm_moderada_mm = []


epm_moderada_mm.append(epm_moderada_2_semanas_mm)
epm_moderada_mm.append(epm_moderada_3_semanas_mm)
epm_moderada_mm.append(epm_moderada_4_semanas_mm)
epm_moderada_mm.append(epm_moderada_5_semanas_mm)


########################### Dados para a intensidade vigorosa #########################
#Definindo valores do eixo Y para intensidade vigorosa

# Medida unica
ICC_vigorosa_2_semanas_mu = 0.83
ICC_vigorosa_3_semanas_mu = 0.79
ICC_vigorosa_4_semanas_mu = 0.80
ICC_vigorosa_5_semanas_mu = 0.79


# Media das medidas
ICC_vigorosa_2_semanas_mm = 0.91
ICC_vigorosa_3_semanas_mm = 0.92
ICC_vigorosa_4_semanas_mm = 0.94
ICC_vigorosa_5_semanas_mm = 0.95


#Calculando intervalos de confianca para intensidade vigorosa

# Medida unica
asymmetric_error_icc_vigorosa_2_semanas_mu = [[0.10], [0.06]]
asymmetric_error_icc_vigorosa_3_semanas_mu = [[0.08], [0.07]]
asymmetric_error_icc_vigorosa_4_semanas_mu = [[0.08], [0.06]]
asymmetric_error_icc_vigorosa_5_semanas_mu = [[0.08], [0.06]]


# Media das medidas
asymmetric_error_icc_vigorosa_2_semanas_mm = [[0.06], [0.03]]
asymmetric_error_icc_vigorosa_3_semanas_mm = [[0.04], [0.03]]
asymmetric_error_icc_vigorosa_4_semanas_mm = [[0.03], [0.02]]
asymmetric_error_icc_vigorosa_5_semanas_mm = [[0.02], [0.02]]

# Definindo o erro padrao para as estimativas de af vigorosa

# Medidas unicas
epm_vigorosa_2_semanas_mu = 40
epm_vigorosa_3_semanas_mu = 45
epm_vigorosa_4_semanas_mu = 43
epm_vigorosa_5_semanas_mu = 44


# Medidas medias
epm_vigorosa_2_semanas_mm = 29
epm_vigorosa_3_semanas_mm = 27
epm_vigorosa_4_semanas_mm = 23
epm_vigorosa_5_semanas_mm = 21



epm_vigorosa_mu = []


epm_vigorosa_mu.append(epm_vigorosa_2_semanas_mu)
epm_vigorosa_mu.append(epm_vigorosa_3_semanas_mu)
epm_vigorosa_mu.append(epm_vigorosa_4_semanas_mu)
epm_vigorosa_mu.append(epm_vigorosa_5_semanas_mu)


epm_vigorosa_mm = []


epm_vigorosa_mm.append(epm_vigorosa_2_semanas_mm)
epm_vigorosa_mm.append(epm_vigorosa_3_semanas_mm)
epm_vigorosa_mm.append(epm_vigorosa_4_semanas_mm)
epm_vigorosa_mm.append(epm_vigorosa_5_semanas_mm)

# Construir subplots com o efeito das medidas sobre as estimativas de confiabilidade

semanas = ['2 Semanas', '3 Semanas', '4 Semanas', '5 Semanas']


#graficos com dados de caminhada
fig, ax = plt.subplots(nrows = 3, ncols = 2, figsize=(9, 10), sharex=True)

# Dados de ICC e intervalo de confianca
# Medida unica
ax[0,0].errorbar(['2 Semanas'], [ICC_leve_2_semanas_mu], yerr=asymmetric_error_icc_leve_2_semanas_mu, fmt='-o', color = '#228B22')
ax[0,0].errorbar(['3 Semanas'], [ICC_leve_3_semanas_mu], yerr=asymmetric_error_icc_leve_3_semanas_mu, fmt='-o', color = '#228B22')
ax[0,0].errorbar(['4 Semanas'], [ICC_leve_4_semanas_mu], yerr=asymmetric_error_icc_leve_4_semanas_mu, fmt='-o', color = '#228B22')
ax[0,0].errorbar(['5 Semanas'], [ICC_leve_5_semanas_mu], yerr=asymmetric_error_icc_leve_5_semanas_mu, fmt='-o', color = '#228B22')

# Media das medidas
ax[0,0].errorbar(['2 Semanas'], [ICC_leve_2_semanas_mm], yerr=asymmetric_error_icc_leve_2_semanas_mm, fmt='-o', color = '#228B22', marker='x')
ax[0,0].errorbar(['3 Semanas'], [ICC_leve_3_semanas_mm], yerr=asymmetric_error_icc_leve_3_semanas_mm, fmt='-o', color = '#228B22', marker='x')
ax[0,0].errorbar(['4 Semanas'], [ICC_leve_4_semanas_mm], yerr=asymmetric_error_icc_leve_4_semanas_mm, fmt='-o', color = '#228B22', marker='x')
ax[0,0].errorbar(['5 Semanas'], [ICC_leve_5_semanas_mm], yerr=asymmetric_error_icc_leve_5_semanas_mm, fmt='-o', color = '#228B22', marker='x')


ax[0,0].set_ylabel('Confiabilidade (ICC)')
ax[0,0].set_ylim(0,1)


# Inserir dados com o erro padrao da medida
ax[0,1].plot(semanas, epm_leve_mu, color = '#228B22',linestyle='-', marker = 'o', markersize = 4, label = 'Leve')
ax[0,1].plot(semanas, epm_leve_mm, color = '#228B22',linestyle='dotted', marker = 'x', markersize = 4)
ax[0,1].set_ylabel('Confiabilidade (EPM)')


#graficos com dados de atividade fisica moderada

# Dados de ICC e intervalo de confianca
# Medida unica
ax[1,0].errorbar(['2 Semanas'], [ICC_moderada_2_semanas_mu], yerr=asymmetric_error_icc_moderada_2_semanas_mu, fmt='-o', color = '#FF8C00')
ax[1,0].errorbar(['3 Semanas'], [ICC_moderada_3_semanas_mu], yerr=asymmetric_error_icc_moderada_3_semanas_mu, fmt='-o', color = '#FF8C00')
ax[1,0].errorbar(['4 Semanas'], [ICC_moderada_4_semanas_mu], yerr=asymmetric_error_icc_moderada_4_semanas_mu, fmt='-o', color = '#FF8C00')
ax[1,0].errorbar(['5 Semanas'], [ICC_moderada_5_semanas_mu], yerr=asymmetric_error_icc_moderada_5_semanas_mu, fmt='-o', color = '#FF8C00')

# Media das medidas
ax[1,0].errorbar(['2 Semanas'], [ICC_moderada_2_semanas_mm], yerr=asymmetric_error_icc_moderada_2_semanas_mm, fmt='-o', color = '#FF8C00', marker='x')
ax[1,0].errorbar(['3 Semanas'], [ICC_moderada_3_semanas_mm], yerr=asymmetric_error_icc_moderada_3_semanas_mm, fmt='-o', color = '#FF8C00', marker='x')
ax[1,0].errorbar(['4 Semanas'], [ICC_moderada_4_semanas_mm], yerr=asymmetric_error_icc_moderada_4_semanas_mm, fmt='-o', color = '#FF8C00', marker='x')
ax[1,0].errorbar(['5 Semanas'], [ICC_moderada_5_semanas_mm], yerr=asymmetric_error_icc_moderada_5_semanas_mm, fmt='-o', color = '#FF8C00', marker='x')


ax[1,0].set_ylabel('Confiabilidade (ICC)')
ax[1,0].set_ylim(0,1)

# Inserir dados com o erro padrao da medida
ax[1,1].plot(semanas, epm_moderada_mu, color = '#FF8C00',linestyle='-', marker = 'o', markersize = 4, label = 'Moderada')
ax[1,1].plot(semanas, epm_moderada_mm, color = '#FF8C00',linestyle='dotted', marker = 'x', markersize = 4)
ax[1,1].set_ylabel('Confiabilidade (EPM)')



#graficos com dados de atividade fisica vigorosa

# Dados de ICC e intervalo de confianca

# Medida unica
ax[2,0].errorbar(['2 Semanas'], [ICC_vigorosa_2_semanas_mu], yerr=asymmetric_error_icc_vigorosa_2_semanas_mu, fmt='-o', color = '#FF0000')
ax[2,0].errorbar(['3 Semanas'], [ICC_vigorosa_3_semanas_mu], yerr=asymmetric_error_icc_vigorosa_3_semanas_mu, fmt='-o', color = '#FF0000')
ax[2,0].errorbar(['4 Semanas'], [ICC_vigorosa_4_semanas_mu], yerr=asymmetric_error_icc_vigorosa_4_semanas_mu, fmt='-o', color = '#FF0000')
ax[2,0].errorbar(['5 Semanas'], [ICC_vigorosa_5_semanas_mu], yerr=asymmetric_error_icc_vigorosa_5_semanas_mu, fmt='-o', color = '#FF0000')

# Media das medidas
ax[2,0].errorbar(['2 Semanas'], [ICC_vigorosa_2_semanas_mm], yerr=asymmetric_error_icc_vigorosa_2_semanas_mm, fmt='-o', color = '#FF0000', marker='x')
ax[2,0].errorbar(['3 Semanas'], [ICC_vigorosa_3_semanas_mm], yerr=asymmetric_error_icc_vigorosa_3_semanas_mm, fmt='-o', color = '#FF0000', marker='x')
ax[2,0].errorbar(['4 Semanas'], [ICC_vigorosa_4_semanas_mm], yerr=asymmetric_error_icc_vigorosa_4_semanas_mm, fmt='-o', color = '#FF0000', marker='x')
ax[2,0].errorbar(['5 Semanas'], [ICC_vigorosa_5_semanas_mm], yerr=asymmetric_error_icc_vigorosa_5_semanas_mm, fmt='-o', color = '#FF0000', marker='x')


ax[2,0].set_ylabel('Confiabilidade (ICC)')
ax[2,0].set_ylim(0,1)

# Inserir dados com o erro padrao da medida
ax[2,1].plot(semanas, epm_vigorosa_mu, color = '#FF0000',linestyle='-', marker = 'o', markersize = 4, label = 'Vigorosa')
ax[2,1].plot(semanas, epm_vigorosa_mm, color = '#FF0000',linestyle='dotted', marker = 'x', markersize = 4)
ax[2,1].set_ylabel('Confiabilidade (EPM)')


plt.rcParams['axes.labelsize']=12
plt.rcParams['axes.titlesize']=12


plt.tight_layout()
fontP = FontProperties()
fontP.set_size('small')
#fig.autofmt_xdate(rotation=45)
fig.legend(loc='lower center', bbox_to_anchor=(0.5, -0.05), fancybox=True, shadow=True, ncol=3)
plt.savefig('D:/Projeto_mestrado/Dissertacao/MastersDissertation/Confiabilidade teste-reteste/Grafico efeito tempo confiabilidade/confiabilidade_em_fun_do_tempo_fleem.png', bbox_inches='tight', dpi = 300)
plt.show()

