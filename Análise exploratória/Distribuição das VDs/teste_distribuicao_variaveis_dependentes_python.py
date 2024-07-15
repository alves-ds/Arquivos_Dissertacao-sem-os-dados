# Importação das bibliotecas necessárias
import seaborn as sns
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from scipy import stats
import statsmodels.api as sm
from scipy.special import ndtri
import matplotlib.lines as mlines
import matplotlib.transforms as mtransforms
import scipy
from distfit import distfit
import pylab as py
from scipy.stats import gamma
import math


#Importar banco de dados
dados = pd.read_excel('D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Quinto processamento/banco_dados_reestruturado.xlsx')


# Agora, vamos remover os dados faltantes, pois estes podem impactar na nossa inspeção. Para isso, usei a função dropna()
dados = dados.dropna()


# Salvar os dados do IPAQ em uma variável, framentado em intensidades de AF 
leve_IPAQ = list(dados['Caminhada_IPAQ_10'].values)
leveipaq_p_quartil_dados = pd.DataFrame(dados['Caminhada_IPAQ_10'])

mod_IPAQ = list(dados['Moderada_IPAQ_10'].values)
modipaq_p_quartil_dados = pd.DataFrame(dados['Moderada_IPAQ_10'])

vig_IPAQ = list(dados['Vigorosa_IPAQ_10'].values)
vigipaq_p_quartil_dados = pd.DataFrame(dados['Vigorosa_IPAQ_10'])


# Salvar os dados do FLEEM em uma variável, framentado em intensidades de AF 
leve_FLEEM = list(dados['Leve_FLEEM'].values)
levefleem_p_quartil_dados = pd.DataFrame(dados['Leve_FLEEM'])

mod_FLEEM = list(dados['Moderada_FLEEM_10'].values)
modfleem_p_quartil_dados = pd.DataFrame(dados['Moderada_FLEEM_10'])

vig_FLEEM = list(dados['Vigorosa_FLEEM_10'].values)
vigfleem_p_quartil_dados = pd.DataFrame(dados['Vigorosa_FLEEM_10'])




####Calcular percentis. Os percentis foram calculados, pois de início os qqplots seriam construídos manualmente
######## Caminhada IPAQ #######
df_leve_ipaq = leveipaq_p_quartil_dados.sort_values(by=['Caminhada_IPAQ_10'], ascending=True).reset_index()
df_leve_ipaq['count'] = df_leve_ipaq.index + 1
n_rows = df_leve_ipaq.shape[0]
df_leve_ipaq['percentil_area'] = (df_leve_ipaq['count'])/n_rows
df_leve_ipaq['percentil_teorico'] = ndtri(df_leve_ipaq['percentil_area'])
df_leve_ipaq['percentil_atual'] = (df_leve_ipaq['Caminhada_IPAQ_10'] - df_leve_ipaq['Caminhada_IPAQ_10'].mean())/df_leve_ipaq['Caminhada_IPAQ_10'].std(ddof=0)


######## Moderada IPAQ #######
df_mod_ipaq = modipaq_p_quartil_dados.sort_values(by=['Moderada_IPAQ_10'], ascending=True).reset_index()
df_mod_ipaq['count'] = df_mod_ipaq.index + 1
n_rows = df_mod_ipaq.shape[0]
df_mod_ipaq['percentil_area'] = (df_mod_ipaq['count'])/n_rows
df_mod_ipaq['percentil_teorico'] = ndtri(df_mod_ipaq['percentil_area'])
df_mod_ipaq['percentil_atual'] = (df_mod_ipaq['Moderada_IPAQ_10'] - df_mod_ipaq['Moderada_IPAQ_10'].mean())/df_mod_ipaq['Moderada_IPAQ_10'].std(ddof=0)


######## Vigorosa IPAQ #######
df_vig_ipaq = vigipaq_p_quartil_dados.sort_values(by=['Vigorosa_IPAQ_10'], ascending=True).reset_index()
df_vig_ipaq['count'] = df_vig_ipaq.index + 1
n_rows = df_vig_ipaq.shape[0]
df_vig_ipaq['percentil_area'] = (df_vig_ipaq['count'])/n_rows
df_vig_ipaq['percentil_teorico'] = ndtri(df_vig_ipaq['percentil_area'])
df_vig_ipaq['percentil_atual'] = (df_vig_ipaq['Vigorosa_IPAQ_10'] - df_vig_ipaq['Vigorosa_IPAQ_10'].mean())/df_vig_ipaq['Vigorosa_IPAQ_10'].std(ddof=0)


######## Leve FLEEM #######
df_leve_fleem = levefleem_p_quartil_dados.sort_values(by=['Leve_FLEEM'], ascending=True).reset_index()
df_leve_fleem['count'] = df_leve_fleem.index + 1
n_rows = df_leve_fleem.shape[0]
df_leve_fleem['percentil_area'] = (df_leve_fleem['count'])/n_rows
df_leve_fleem['percentil_teorico'] = ndtri(df_leve_fleem['percentil_area'])
df_leve_fleem['percentil_atual'] = (df_leve_fleem['Leve_FLEEM'] - df_leve_fleem['Leve_FLEEM'].mean())/df_leve_fleem['Leve_FLEEM'].std(ddof=0)


######## Moderada FLEEM #######
df_mod_fleem = modfleem_p_quartil_dados.sort_values(by=['Moderada_FLEEM_10'], ascending=True).reset_index()
df_mod_fleem['count'] = df_mod_fleem.index + 1
n_rows = df_mod_fleem.shape[0]
df_mod_fleem['percentil_area'] = (df_mod_fleem['count'])/n_rows
df_mod_fleem['percentil_teorico'] = ndtri(df_mod_fleem['percentil_area'])
df_mod_fleem['percentil_atual'] = (df_mod_fleem['Moderada_FLEEM_10'] - df_mod_fleem['Moderada_FLEEM_10'].mean())/df_mod_fleem['Moderada_FLEEM_10'].std(ddof=0)


######## Vigorosa FLEEM #######
df_vig_fleem = vigfleem_p_quartil_dados.sort_values(by=['Vigorosa_FLEEM_10'], ascending=True).reset_index()
df_vig_fleem['count'] = df_vig_fleem.index + 1
n_rows = df_vig_fleem.shape[0]
df_vig_fleem['percentil_area'] = (df_vig_fleem['count'])/n_rows
df_vig_fleem['percentil_teorico'] = ndtri(df_vig_fleem['percentil_area'])
df_vig_fleem['percentil_atual'] = (df_vig_fleem['Vigorosa_FLEEM_10'] - df_vig_fleem['Vigorosa_FLEEM_10'].mean())/df_vig_fleem['Vigorosa_FLEEM_10'].std(ddof=0)


################# Agora vamos testar algumas distribuições de probabilidade, e ver quais melhores se adequam aos dados #################
######## Leve IPAQ ################
dist = distfit(alpha=0.05, smooth=10)

a = np.array(leveipaq_p_quartil_dados)

dist.fit_transform(a)
best_distr = dist.model
print(best_distr)

dist.summary
dist.plot_summary()


# Dist candidatas: normal e loggamma


########### Moderada IPAQ #############
dist = distfit(alpha=0.05, smooth=10)

b = np.array(modipaq_p_quartil_dados)


dist.fit_transform(b)
best_distr = dist.model
print(best_distr)

dist.summary
dist.plot_summary()


# Dist candidatas: normal e loggamma

########### Vigorosa IPAQ #############
dist = distfit(alpha=0.05, smooth=10)

c = np.array(vigipaq_p_quartil_dados)


dist.fit_transform(c)
best_distr = dist.model
print(best_distr)

dist.summary
dist.plot_summary()


# Dist candidatas: normal e loggamma


#################Testando distribuições ######################
######## Leve FLEEM ################
dist = distfit(alpha=0.05, smooth=10)

d = np.array(levefleem_p_quartil_dados)


dist.fit_transform(d)
best_distr = dist.model
print(best_distr)

dist.summary
dist.plot_summary()


# Dist candidatas: normal e gamma 

########### Moderada FLEEM #############
dist = distfit(alpha=0.05, smooth=10)

e = np.array(modfleem_p_quartil_dados)


dist.fit_transform(e)
best_distr = dist.model
print(best_distr)

dist.summary
dist.plot_summary()



# Dist candidatas: normal, gamma e loggamma

########### Vigorosa FLEEM #############
dist = distfit(alpha=0.05, smooth=10)

f = np.array(vigfleem_p_quartil_dados)


dist.fit_transform(f)
best_distr = dist.model
print(best_distr)

dist.summary
dist.plot_summary()


# Dist candidatas: normal e loggamma


################ Construir subplots ############################
# Referência/documentação para as funções disponível em: https://docs.scipy.org/doc/scipy/reference/generated/scipy.stats.probplot.html


################# Leve IPAQ ########################
fig, ((ax1,ax2), (ax3,ax4)) = plt.subplots(nrows = 2, ncols = 2, figsize=(8,5), sharey=False)

sns.histplot(leve_IPAQ, kde=True, ax=ax1)
ax1.set_xlabel('Caminhada IPAQ')
sns.distplot(leve_IPAQ, fit=stats.norm, kde=False, ax=ax2)
ax2.set_xlabel('Caminhada IPAQ')
ax1.set_ylabel('Frequência')
ax2.set_ylabel('FDP (Normal)')

pp = sm.ProbPlot(df_leve_ipaq.Caminhada_IPAQ_10, dist=scipy.stats.distributions.norm, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax3)
sm.qqline(qq.axes[2], line='45')
ax3.set_ylabel('Dados ordenados')
ax3.set_xlabel('Quantis teóricos (normal)')
pp = sm.ProbPlot(df_leve_ipaq.Caminhada_IPAQ_10, dist=stats.gamma, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax4)
sm.qqline(qq.axes[3], line='45')
ax4.set_ylabel('Dados ordenados')
ax4.set_xlabel('Quantis teóricos (gamma)')


plt.rcParams['axes.labelsize']=12
plt.rcParams['axes.titlesize']=12


plt.tight_layout()
plt.savefig('D:/Projeto_mestrado/Dissertacao/MastersDissertation/Análise exploratória/Distribuição das VDs/Gráficos/distribuicao_caminhada_ipaq.png', bbox_inches='tight', dpi = 300)
plt.show()




################# Moderada IPAQ ########################
fig, ((ax1,ax2), (ax3,ax4)) = plt.subplots(nrows = 2, ncols = 2, figsize=(8,5), sharey=False)

sns.histplot(mod_IPAQ, kde=True, ax=ax1)
ax1.set_xlabel('AF moderada IPAQ')
sns.distplot(mod_IPAQ, fit=stats.loggamma, kde=False, ax=ax2)
ax2.set_xlabel('AF moderada IPAQ')
ax1.set_ylabel('Frequência')
ax2.set_ylabel('FDP (loggamma)')

pp = sm.ProbPlot(df_mod_ipaq.Moderada_IPAQ_10, dist=scipy.stats.distributions.norm, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax3)
sm.qqline(qq.axes[2], line='45')
ax3.set_ylabel('Dados ordenados')
ax3.set_xlabel('Quantis teóricos (normal)')
pp = sm.ProbPlot(df_mod_ipaq.Moderada_IPAQ_10, dist=stats.loggamma, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax4)
sm.qqline(qq.axes[3], line='45')
ax4.set_ylabel('Dados ordenados')
ax4.set_xlabel('Quantis teóricos (loggamma)')


plt.rcParams['axes.labelsize']=12
plt.rcParams['axes.titlesize']=12


plt.tight_layout()
plt.savefig('D:/Projeto_mestrado/Dissertacao/MastersDissertation/Análise exploratória/Distribuição das VDs/Gráficos/distribuicao_moderada_ipaq.png', bbox_inches='tight', dpi = 300)
plt.show()


################# Vigorosa IPAQ ########################
fig, ((ax1,ax2), (ax3,ax4)) = plt.subplots(nrows = 2, ncols = 2, figsize=(8,5), sharey=False)

sns.histplot(vig_IPAQ, kde=True, ax=ax1)
ax1.set_xlabel('AF vigorosa IPAQ')
sns.distplot(vig_IPAQ, fit=stats.loggamma, kde=False, ax=ax2)
ax2.set_xlabel('AF vigorosa IPAQ')
ax1.set_ylabel('Frequência')
ax2.set_ylabel('FDP (loggamma)')

pp = sm.ProbPlot(df_vig_ipaq.Vigorosa_IPAQ_10, dist=scipy.stats.distributions.norm, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax3)
sm.qqline(qq.axes[2], line='45')
ax3.set_ylabel('Dados ordenados')
ax3.set_xlabel('Quantis teóricos (normal)')
pp = sm.ProbPlot(df_vig_ipaq.Vigorosa_IPAQ_10, dist=stats.loggamma, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax4)
sm.qqline(qq.axes[3], line='45')
ax4.set_ylabel('Dados ordenados')
ax4.set_xlabel('Quantis teóricos (loggamma)')


plt.rcParams['axes.labelsize']=12
plt.rcParams['axes.titlesize']=12


plt.tight_layout()
plt.savefig('D:/Projeto_mestrado/Dissertacao/MastersDissertation/Análise exploratória/Distribuição das VDs/Gráficos/distribuicao_vigorosa_ipaq.png', bbox_inches='tight', dpi = 300)
plt.show()



################# Leve FLEEM ########################
fig, ((ax1,ax2), (ax3,ax4)) = plt.subplots(nrows = 2, ncols = 2, figsize=(8,5), sharey=False)

sns.histplot(leve_FLEEM, kde=True, ax=ax1)
ax1.set_xlabel('AF leve FLEEM')
sns.distplot(leve_FLEEM, fit=stats.gamma, kde=False, ax=ax2)
ax2.set_xlabel('AF leve FLEEM')
ax1.set_ylabel('Frequência')
ax2.set_ylabel('FDP (gamma)')

pp = sm.ProbPlot(df_leve_fleem.Leve_FLEEM, dist=scipy.stats.distributions.norm, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax3)
sm.qqline(qq.axes[2], line='45')
ax3.set_ylabel('Dados ordenados')
ax3.set_xlabel('Quantis teóricos (normal)')
pp = sm.ProbPlot(df_leve_fleem.Leve_FLEEM, dist=stats.gamma, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax4)
sm.qqline(qq.axes[3], line='45')
ax4.set_ylabel('Dados ordenados')
ax4.set_xlabel('Quantis teóricos (gamma)')


plt.rcParams['axes.labelsize']=12
plt.rcParams['axes.titlesize']=12


plt.tight_layout()
plt.savefig('D:/Projeto_mestrado/Dissertacao/MastersDissertation/Análise exploratória/Distribuição das VDs/Gráficos/distribuicao_leve_fleem.png', bbox_inches='tight', dpi = 300)
plt.show()


################# Moderada FLEEM ########################
fig, ((ax1,ax2), (ax3,ax4)) = plt.subplots(nrows = 2, ncols = 2, figsize=(8,5), sharey=False)

sns.histplot(mod_FLEEM, kde=True, ax=ax1)
ax1.set_xlabel('AF moderada FLEEM')
sns.distplot(mod_FLEEM, fit=stats.gamma, kde=False, ax=ax2)
ax2.set_xlabel('AF moderada FLEEM')
ax1.set_ylabel('Frequência')
ax2.set_ylabel('FDP (gamma)')

pp = sm.ProbPlot(df_mod_fleem.Moderada_FLEEM_10, dist=scipy.stats.distributions.norm, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax3)
sm.qqline(qq.axes[2], line='45')
ax3.set_ylabel('Dados ordenados')
ax3.set_xlabel('Quantis teóricos (normal)')
pp = sm.ProbPlot(df_mod_fleem.Moderada_FLEEM_10, dist=stats.gamma, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax4)
sm.qqline(qq.axes[3], line='45')
ax4.set_ylabel('Dados ordenados')
ax4.set_xlabel('Quantis teóricos (gamma)')


plt.rcParams['axes.labelsize']=12
plt.rcParams['axes.titlesize']=12


plt.tight_layout()
plt.savefig('D:/Projeto_mestrado/Dissertacao/MastersDissertation/Análise exploratória/Distribuição das VDs/Gráficos/distribuicao_moderada_fleem.png', bbox_inches='tight', dpi = 300)
plt.show()


################# Vigorosa FLEEM ########################
fig, ((ax1,ax2), (ax3,ax4)) = plt.subplots(nrows = 2, ncols = 2, figsize=(8,5), sharey=False)

sns.histplot(vig_FLEEM, kde=True, ax=ax1)
ax1.set_xlabel('AF vigorosa FLEEM')
sns.distplot(vig_FLEEM, fit=stats.gamma, kde=False, ax=ax2)
ax2.set_xlabel('AF vigorosa FLEEM')
ax1.set_ylabel('Frequência')
ax2.set_ylabel('FDP (gamma)')

pp = sm.ProbPlot(df_vig_fleem.Vigorosa_FLEEM_10, dist=scipy.stats.distributions.norm, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax3)
sm.qqline(qq.axes[2], line='45')
ax3.set_ylabel('Dados ordenados')
ax3.set_xlabel('Quantis teóricos (normal)')
pp = sm.ProbPlot(df_vig_fleem.Vigorosa_FLEEM_10, dist=stats.gamma, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax4)
sm.qqline(qq.axes[3], line='45')
ax4.set_ylabel('Dados ordenados')
ax4.set_xlabel('Quantis teóricos (gamma)')


plt.rcParams['axes.labelsize']=12
plt.rcParams['axes.titlesize']=12


plt.tight_layout()
plt.savefig('D:/Projeto_mestrado/Dissertacao/MastersDissertation/Análise exploratória/Distribuição das VDs/Gráficos/distribuicao_vigorosa_fleem.png', bbox_inches='tight', dpi = 300)
plt.show()



##########################################################################################################################################################################################



# Como construímos um banco de dados removendo os outliers, seguindo as recomendações de processamento do IPAQ, vamos analisar se a distribuição dos dados mudou
dados_sem_outliers = pd.read_excel('D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Quinto processamento/banco_dados_reestruturado_sem_outliers.xlsx')
dados_sem_outliers = dados_sem_outliers.dropna()


# Salvar os dados do IPAQ em uma variável, framentado em intensidades de AF 
leve_IPAQ = list(dados_sem_outliers['Caminhada_IPAQ_10'].values)
leveipaq_p_quartil_dados = pd.DataFrame(dados_sem_outliers['Caminhada_IPAQ_10'])

mod_IPAQ = list(dados_sem_outliers['Moderada_IPAQ_10'].values)
modipaq_p_quartil_dados = pd.DataFrame(dados_sem_outliers['Moderada_IPAQ_10'])

vig_IPAQ = list(dados_sem_outliers['Vigorosa_IPAQ_10'].values)
vigipaq_p_quartil_dados = pd.DataFrame(dados_sem_outliers['Vigorosa_IPAQ_10'])


# Salvar os dados do FLEEM em uma variável, framentado em intensidades de AF 
leve_FLEEM = list(dados_sem_outliers['Leve_FLEEM'].values)
levefleem_p_quartil_dados = pd.DataFrame(dados_sem_outliers['Leve_FLEEM'])

mod_FLEEM = list(dados_sem_outliers['Moderada_FLEEM_10'].values)
modfleem_p_quartil_dados = pd.DataFrame(dados_sem_outliers['Moderada_FLEEM_10'])

vig_FLEEM = list(dados_sem_outliers['Vigorosa_FLEEM_10'].values)
vigfleem_p_quartil_dados = pd.DataFrame(dados_sem_outliers['Vigorosa_FLEEM_10'])




####Calcular percentis. Os percentis foram calculados, pois de início os qqplots seriam construídos manualmente
######## Caminhada IPAQ #######
df_leve_ipaq = leveipaq_p_quartil_dados.sort_values(by=['Caminhada_IPAQ_10'], ascending=True).reset_index()
df_leve_ipaq['count'] = df_leve_ipaq.index + 1
n_rows = df_leve_ipaq.shape[0]
df_leve_ipaq['percentil_area'] = (df_leve_ipaq['count'])/n_rows
df_leve_ipaq['percentil_teorico'] = ndtri(df_leve_ipaq['percentil_area'])
df_leve_ipaq['percentil_atual'] = (df_leve_ipaq['Caminhada_IPAQ_10'] - df_leve_ipaq['Caminhada_IPAQ_10'].mean())/df_leve_ipaq['Caminhada_IPAQ_10'].std(ddof=0)


######## Moderada IPAQ #######
df_mod_ipaq = modipaq_p_quartil_dados.sort_values(by=['Moderada_IPAQ_10'], ascending=True).reset_index()
df_mod_ipaq['count'] = df_mod_ipaq.index + 1
n_rows = df_mod_ipaq.shape[0]
df_mod_ipaq['percentil_area'] = (df_mod_ipaq['count'])/n_rows
df_mod_ipaq['percentil_teorico'] = ndtri(df_mod_ipaq['percentil_area'])
df_mod_ipaq['percentil_atual'] = (df_mod_ipaq['Moderada_IPAQ_10'] - df_mod_ipaq['Moderada_IPAQ_10'].mean())/df_mod_ipaq['Moderada_IPAQ_10'].std(ddof=0)


######## Vigorosa IPAQ #######
df_vig_ipaq = vigipaq_p_quartil_dados.sort_values(by=['Vigorosa_IPAQ_10'], ascending=True).reset_index()
df_vig_ipaq['count'] = df_vig_ipaq.index + 1
n_rows = df_vig_ipaq.shape[0]
df_vig_ipaq['percentil_area'] = (df_vig_ipaq['count'])/n_rows
df_vig_ipaq['percentil_teorico'] = ndtri(df_vig_ipaq['percentil_area'])
df_vig_ipaq['percentil_atual'] = (df_vig_ipaq['Vigorosa_IPAQ_10'] - df_vig_ipaq['Vigorosa_IPAQ_10'].mean())/df_vig_ipaq['Vigorosa_IPAQ_10'].std(ddof=0)



################# Agora vamos testar algumas distribuições de probabilidade, e ver quais melhores se adequam aos dados #################
######## Leve IPAQ ################
dist = distfit(alpha=0.05, smooth=10)

a = np.array(leveipaq_p_quartil_dados)

dist.fit_transform(a)
best_distr = dist.model
print(best_distr)

dist.summary
dist.plot_summary()


# Dist candidatas: normal e loggamma


########### Moderada IPAQ #############
dist = distfit(alpha=0.05, smooth=10)

b = np.array(modipaq_p_quartil_dados)


dist.fit_transform(b)
best_distr = dist.model
print(best_distr)

dist.summary
dist.plot_summary()


# Dist candidatas: normal e loggamma

########### Vigorosa IPAQ #############
dist = distfit(alpha=0.05, smooth=10)

c = np.array(vigipaq_p_quartil_dados)


dist.fit_transform(c)
best_distr = dist.model
print(best_distr)

dist.summary
dist.plot_summary()


# Dist candidatas: normal e loggamma


################ Construir subplots ############################
# Referência/documentação para as funções disponível em: https://docs.scipy.org/doc/scipy/reference/generated/scipy.stats.probplot.html


################# Leve IPAQ ########################
fig, ((ax1,ax2), (ax3,ax4)) = plt.subplots(nrows = 2, ncols = 2, figsize=(8,5), sharey=False)

sns.histplot(leve_IPAQ, kde=True, ax=ax1)
ax1.set_xlabel('Caminhada IPAQ')
sns.distplot(leve_IPAQ, fit=stats.loggamma, kde=False, ax=ax2)
ax2.set_xlabel('Caminhada IPAQ')
ax1.set_ylabel('Frequência')
ax2.set_ylabel('FDP (loggamma)')

pp = sm.ProbPlot(df_leve_ipaq.Caminhada_IPAQ_10, dist=scipy.stats.distributions.norm, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax3)
sm.qqline(qq.axes[2], line='45')
ax3.set_ylabel('Dados ordenados')
ax3.set_xlabel('Quantis teóricos (normal)')
pp = sm.ProbPlot(df_leve_ipaq.Caminhada_IPAQ_10, dist=stats.gamma, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax4)
sm.qqline(qq.axes[3], line='45')
ax4.set_ylabel('Dados ordenados')
ax4.set_xlabel('Quantis teóricos (gamma)')


plt.rcParams['axes.labelsize']=12
plt.rcParams['axes.titlesize']=12


plt.tight_layout()
plt.savefig('D:/Projeto_mestrado/Dissertacao/MastersDissertation/Análise exploratória/Distribuição das VDs/Gráficos/distribuicao_caminhada_ipaq_sem_outliers.png', bbox_inches='tight', dpi = 300)
plt.show()




################# Moderada IPAQ ########################
fig, ((ax1,ax2), (ax3,ax4)) = plt.subplots(nrows = 2, ncols = 2, figsize=(8,5), sharey=False)

sns.histplot(mod_IPAQ, kde=True, ax=ax1)
ax1.set_xlabel('AF moderada IPAQ')
sns.distplot(mod_IPAQ, fit=stats.loggamma, kde=False, ax=ax2)
ax2.set_xlabel('AF moderada IPAQ')
ax1.set_ylabel('Frequência')
ax2.set_ylabel('FDP (loggamma)')

pp = sm.ProbPlot(df_mod_ipaq.Moderada_IPAQ_10, dist=scipy.stats.distributions.norm, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax3)
sm.qqline(qq.axes[2], line='45')
ax3.set_ylabel('Dados ordenados')
ax3.set_xlabel('Quantis teóricos (normal)')
pp = sm.ProbPlot(df_mod_ipaq.Moderada_IPAQ_10, dist=stats.loggamma, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax4)
sm.qqline(qq.axes[3], line='45')
ax4.set_ylabel('Dados ordenados')
ax4.set_xlabel('Quantis teóricos (loggamma)')


plt.rcParams['axes.labelsize']=12
plt.rcParams['axes.titlesize']=12


plt.tight_layout()
plt.savefig('D:/Projeto_mestrado/Dissertacao/MastersDissertation/Análise exploratória/Distribuição das VDs/Gráficos/distribuicao_moderada_ipaq_sem_outliers.png', bbox_inches='tight', dpi = 300)
plt.show()


################# Vigorosa IPAQ ########################
fig, ((ax1,ax2), (ax3,ax4)) = plt.subplots(nrows = 2, ncols = 2, figsize=(8,5), sharey=False)

sns.histplot(vig_IPAQ, kde=True, ax=ax1)
ax1.set_xlabel('AF vigorosa IPAQ')
sns.distplot(vig_IPAQ, fit=stats.gamma, kde=False, ax=ax2)
ax2.set_xlabel('AF vigorosa IPAQ')
ax1.set_ylabel('Frequência')
ax2.set_ylabel('FDP (gamma)')

pp = sm.ProbPlot(df_vig_ipaq.Vigorosa_IPAQ_10, dist=scipy.stats.distributions.norm, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax3)
sm.qqline(qq.axes[2], line='45')
ax3.set_ylabel('Dados ordenados')
ax3.set_xlabel('Quantis teóricos (normal)')
pp = sm.ProbPlot(df_vig_ipaq.Vigorosa_IPAQ_10, dist=stats.gamma, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax4)
sm.qqline(qq.axes[3], line='45')
ax4.set_ylabel('Dados ordenados')
ax4.set_xlabel('Quantis teóricos (gamma)')


plt.rcParams['axes.labelsize']=12
plt.rcParams['axes.titlesize']=12


plt.tight_layout()
plt.savefig('D:/Projeto_mestrado/Dissertacao/MastersDissertation/Análise exploratória/Distribuição das VDs/Gráficos/distribuicao_vigorosa_ipaq_sem_outliers.png', bbox_inches='tight', dpi = 300)
plt.show()






##########################################################################################################################################################################################






# Como construímos outro banco de dados, removendo aqueles que foram considerados outliers baseando-se nos valores de z-score, vamos observar o impacto deste processamento na distribuição dos dados
dados_sem_outliers_z_score = pd.read_excel('D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Sexto processamento/banco_dados_reestruturado_sem_outliers.xlsx')



# Salvar os dados do IPAQ em uma variável, framentado em intensidades de AF 
leve_IPAQ = list(dados_sem_outliers_z_score['Caminhada_IPAQ_10'].values)
leveipaq_p_quartil_dados = pd.DataFrame(dados_sem_outliers_z_score['Caminhada_IPAQ_10'].dropna())

mod_IPAQ = list(dados_sem_outliers_z_score['Moderada_IPAQ_10'].values)
modipaq_p_quartil_dados = pd.DataFrame(dados_sem_outliers_z_score['Moderada_IPAQ_10'].dropna())

vig_IPAQ = list(dados_sem_outliers_z_score['Vigorosa_IPAQ_10'].values)
vigipaq_p_quartil_dados = pd.DataFrame(dados_sem_outliers_z_score['Vigorosa_IPAQ_10'].dropna())





####Calcular percentis. Os percentis foram calculados, pois de início os qqplots seriam construídos manualmente
######## Caminhada IPAQ #######
df_leve_ipaq = leveipaq_p_quartil_dados.sort_values(by=['Caminhada_IPAQ_10'], ascending=True).reset_index()
df_leve_ipaq['count'] = df_leve_ipaq.index + 1
n_rows = df_leve_ipaq.shape[0]
df_leve_ipaq['percentil_area'] = (df_leve_ipaq['count'])/n_rows
df_leve_ipaq['percentil_teorico'] = ndtri(df_leve_ipaq['percentil_area'])
df_leve_ipaq['percentil_atual'] = (df_leve_ipaq['Caminhada_IPAQ_10'] - df_leve_ipaq['Caminhada_IPAQ_10'].mean())/df_leve_ipaq['Caminhada_IPAQ_10'].std(ddof=0)


######## Moderada IPAQ #######
df_mod_ipaq = modipaq_p_quartil_dados.sort_values(by=['Moderada_IPAQ_10'], ascending=True).reset_index()
df_mod_ipaq['count'] = df_mod_ipaq.index + 1
n_rows = df_mod_ipaq.shape[0]
df_mod_ipaq['percentil_area'] = (df_mod_ipaq['count'])/n_rows
df_mod_ipaq['percentil_teorico'] = ndtri(df_mod_ipaq['percentil_area'])
df_mod_ipaq['percentil_atual'] = (df_mod_ipaq['Moderada_IPAQ_10'] - df_mod_ipaq['Moderada_IPAQ_10'].mean())/df_mod_ipaq['Moderada_IPAQ_10'].std(ddof=0)


######## Vigorosa IPAQ #######
df_vig_ipaq = vigipaq_p_quartil_dados.sort_values(by=['Vigorosa_IPAQ_10'], ascending=True).reset_index()
df_vig_ipaq['count'] = df_vig_ipaq.index + 1
n_rows = df_vig_ipaq.shape[0]
df_vig_ipaq['percentil_area'] = (df_vig_ipaq['count'])/n_rows
df_vig_ipaq['percentil_teorico'] = ndtri(df_vig_ipaq['percentil_area'])
df_vig_ipaq['percentil_atual'] = (df_vig_ipaq['Vigorosa_IPAQ_10'] - df_vig_ipaq['Vigorosa_IPAQ_10'].mean())/df_vig_ipaq['Vigorosa_IPAQ_10'].std(ddof=0)



################# Agora vamos testar algumas distribuições de probabilidade, e ver quais melhores se adequam aos dados #################
######## Leve IPAQ ################
dist = distfit(alpha=0.05, smooth=10)

a = np.array(leveipaq_p_quartil_dados)

dist.fit_transform(a)
best_distr = dist.model
print(best_distr)

dist.summary
dist.plot_summary()


# Dist candidatas: normal e loggamma


########### Moderada IPAQ #############
dist = distfit(alpha=0.05, smooth=10)

b = np.array(modipaq_p_quartil_dados)


dist.fit_transform(b)
best_distr = dist.model
print(best_distr)

dist.summary
dist.plot_summary()


# Dist candidatas: normal e loggamma

########### Vigorosa IPAQ #############
dist = distfit(alpha=0.05, smooth=10)

c = np.array(vigipaq_p_quartil_dados)


dist.fit_transform(c)
best_distr = dist.model
print(best_distr)

dist.summary
dist.plot_summary()


# Dist candidatas: normal e loggamma


################ Construir subplots ############################
# Referência/documentação para as funções disponível em: https://docs.scipy.org/doc/scipy/reference/generated/scipy.stats.probplot.html


################# Leve IPAQ ########################
fig, ((ax1,ax2), (ax3,ax4)) = plt.subplots(nrows = 2, ncols = 2, figsize=(8,5), sharey=False)

sns.histplot(leve_IPAQ, kde=True, ax=ax1)
ax1.set_xlabel('Caminhada IPAQ')
sns.distplot(leve_IPAQ, fit=stats.gamma, kde=False, ax=ax2)
ax2.set_xlabel('Caminhada IPAQ')
ax1.set_ylabel('Frequência')
ax2.set_ylabel('FDP (gamma)')

pp = sm.ProbPlot(df_leve_ipaq.Caminhada_IPAQ_10, dist=scipy.stats.distributions.norm, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax3)
sm.qqline(qq.axes[2], line='45')
ax3.set_ylabel('Dados ordenados')
ax3.set_xlabel('Quantis teóricos (normal)')
pp = sm.ProbPlot(df_leve_ipaq.Caminhada_IPAQ_10, dist=stats.gamma, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax4)
sm.qqline(qq.axes[3], line='45')
ax4.set_ylabel('Dados ordenados')
ax4.set_xlabel('Quantis teóricos (gamma)')


plt.rcParams['axes.labelsize']=12
plt.rcParams['axes.titlesize']=12


plt.tight_layout()
plt.savefig('D:/Projeto_mestrado/Dissertacao/MastersDissertation/Análise exploratória/Distribuição das VDs/Gráficos/distribuicao_caminhada_ipaq_sem_outliers_z_score.png', bbox_inches='tight', dpi = 300)
plt.show()




################# Moderada IPAQ ########################
fig, ((ax1,ax2), (ax3,ax4)) = plt.subplots(nrows = 2, ncols = 2, figsize=(8,5), sharey=False)

sns.histplot(mod_IPAQ, kde=True, ax=ax1)
ax1.set_xlabel('AF moderada IPAQ')
sns.distplot(mod_IPAQ, fit=stats.gamma, kde=False, ax=ax2)
ax2.set_xlabel('AF moderada IPAQ')
ax1.set_ylabel('Frequência')
ax2.set_ylabel('FDP (gamma)')

pp = sm.ProbPlot(df_mod_ipaq.Moderada_IPAQ_10, dist=scipy.stats.distributions.norm, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax3)
sm.qqline(qq.axes[2], line='45')
ax3.set_ylabel('Dados ordenados')
ax3.set_xlabel('Quantis teóricos (normal)')
pp = sm.ProbPlot(df_mod_ipaq.Moderada_IPAQ_10, dist=stats.gamma, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax4)
sm.qqline(qq.axes[3], line='45')
ax4.set_ylabel('Dados ordenados')
ax4.set_xlabel('Quantis teóricos (gamma)')


plt.rcParams['axes.labelsize']=12
plt.rcParams['axes.titlesize']=12


plt.tight_layout()
plt.savefig('D:/Projeto_mestrado/Dissertacao/MastersDissertation/Análise exploratória/Distribuição das VDs/Gráficos/distribuicao_moderada_ipaq_sem_outliers_z_score.png', bbox_inches='tight', dpi = 300)
plt.show()


################# Vigorosa IPAQ ########################
fig, ((ax1,ax2), (ax3,ax4)) = plt.subplots(nrows = 2, ncols = 2, figsize=(8,5), sharey=False)

sns.histplot(vig_IPAQ, kde=True, ax=ax1)
ax1.set_xlabel('AF vigorosa IPAQ')
sns.distplot(vig_IPAQ, fit=stats.gamma, kde=False, ax=ax2)
ax2.set_xlabel('AF vigorosa IPAQ')
ax1.set_ylabel('Frequência')
ax2.set_ylabel('FDP (gamma)')

pp = sm.ProbPlot(df_vig_ipaq.Vigorosa_IPAQ_10, dist=scipy.stats.distributions.norm, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax3)
sm.qqline(qq.axes[2], line='45')
ax3.set_ylabel('Dados ordenados')
ax3.set_xlabel('Quantis teóricos (normal)')
pp = sm.ProbPlot(df_vig_ipaq.Vigorosa_IPAQ_10, dist=stats.gamma, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax4)
sm.qqline(qq.axes[3], line='45')
ax4.set_ylabel('Dados ordenados')
ax4.set_xlabel('Quantis teóricos (gamma)')


plt.rcParams['axes.labelsize']=12
plt.rcParams['axes.titlesize']=12


plt.tight_layout()
plt.savefig('D:/Projeto_mestrado/Dissertacao/MastersDissertation/Análise exploratória/Distribuição das VDs/Gráficos/distribuicao_vigorosa_ipaq_sem_outliers_z_score.png', bbox_inches='tight', dpi = 300)
plt.show()