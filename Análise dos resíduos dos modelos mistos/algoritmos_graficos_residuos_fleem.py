# Immportar bibliotecas necessárias
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
dados = pd.read_excel('D:/Projeto_mestrado/Dissertacao/MastersDissertation/Modelos mistos/dados_com_residuos.xlsx')


# Vamos remover os dados faltantes
dados = dados.dropna()

###############    IMPORTAR RESIDUOS E VALORES PREDITOS DOS MODELOS       ##################
###############                   AF LEVE                 ##################


# Modelo com distribuição linear
resid_leve_linear = list(dados['Residuo_leve_1'].values)
preditos_leve_linear = list(dados['Predito_leve_1'].values)

# Modelo com distribuição Gamma
resid_leve_gamma = list(dados['Residuo_leve_2'].values)
preditos_leve_gamma = list(dados['Predito_leve_2'].values)


###############                   AF MODERADA                 ##################

# Modelo com distribuição linear
resid_moderada_linear = list(dados['Residuo_fmod_1'].values)
preditos_moderada_linear = list(dados['Predito_fmod_1'].values)

# Modelo com distribuição Gamma   
resid_moderada_gamma = list(dados['Residuo_fmod_2'].values)
preditos_moderada_gamma = list(dados['Predito_fmod_1'].values)
  

###############                   AF VIGOROSA                 ##################

# Modelo com distribuição linear
resid_vigorosa_linear = list(dados['Residuo_fvig_1'].values)
preditos_vigorosa_linear = list(dados['Predito_fvig_1'].values)

# Modelo com distribuição Gamma    
resid_vigorosa_gamma = list(dados['Residuo_fvig_2'].values)
preditos_vigorosa_gamma = list(dados['Predito_fvig_2'].values)



############ ORGANIZAR OS DADOS DO MENOR PARA O MAIOR  ###########################
###############                   AF LEVE                 ##################

# Modelo com distribuição linear
leve_fleem_linear_resid = pd.DataFrame(resid_leve_linear)
leve_fleem_linear_predito = pd.DataFrame(preditos_leve_linear)


# Modelo com distribuição Gamma    
leve_fleem_gamma_resid = pd.DataFrame(resid_leve_gamma)
leve_fleem_gamma_predito = pd.DataFrame(preditos_leve_gamma)


###############                   AF MODERADA                 ##################

# Modelo com distribuição linear
moderada_fleem_linear_resid = pd.DataFrame(resid_moderada_linear)
moderada_fleem_linear_predito = pd.DataFrame(preditos_moderada_linear)

# Modelo com distribuição Gamma    
moderada_fleem_gamma_resid = pd.DataFrame(resid_moderada_gamma)
moderada_fleem_gamma_predito = pd.DataFrame(preditos_moderada_gamma)

  
###############                   AF VIGOROSA                 ##################

# Modelo com distribuição linear
vigorosa_fleem_linear_resid = pd.DataFrame(resid_vigorosa_linear)
vigorosa_fleem_linear_predito = pd.DataFrame(preditos_vigorosa_linear)

# Modelo com distribuição Gamma      
vigorosa_fleem_gamma_resid = pd.DataFrame(resid_vigorosa_gamma)
vigorosa_fleem_gamma_predito = pd.DataFrame(preditos_vigorosa_gamma)



####Calcular percentis
######## AF LEVE #######

# Modelo com distribuição linear
df_leve_linear_resid = leve_fleem_linear_resid.sort_values(by=[0], ascending=True).reset_index()
df_leve_linear_resid['count'] = df_leve_linear_resid.index + 1
n_rows = df_leve_linear_resid.shape[0]
df_leve_linear_resid['percentil_area'] = (df_leve_linear_resid['count'])/n_rows
df_leve_linear_resid['percentil_teorico'] = ndtri(df_leve_linear_resid['percentil_area'])
df_leve_linear_resid['percentil_atual'] = (df_leve_linear_resid[0] - df_leve_linear_resid[0].mean())/df_leve_linear_resid[0].std(ddof=0)

# Modelo com distribuição Gamma   
df_leve_gamma_resid = leve_fleem_gamma_resid.sort_values(by=[0], ascending=True).reset_index()
df_leve_gamma_resid['count'] = df_leve_gamma_resid.index + 1
n_rows = df_leve_gamma_resid.shape[0]
df_leve_gamma_resid['percentil_area'] = (df_leve_linear_resid['count'])/n_rows
df_leve_gamma_resid['percentil_teorico'] = ndtri(df_leve_gamma_resid['percentil_area'])
df_leve_gamma_resid['percentil_atual'] = (df_leve_gamma_resid[0] - df_leve_gamma_resid[0].mean())/df_leve_gamma_resid[0].std(ddof=0)


######## AF MODERADA #######

# Modelo com distribuição linear
df_moderada_linear_resid = moderada_fleem_linear_resid.sort_values(by=[0], ascending=True).reset_index()
df_moderada_linear_resid['count'] = df_moderada_linear_resid.index + 1
n_rows = df_moderada_linear_resid.shape[0]
df_moderada_linear_resid['percentil_area'] = (df_moderada_linear_resid['count'])/n_rows
df_moderada_linear_resid['percentil_teorico'] = ndtri(df_moderada_linear_resid['percentil_area'])
df_moderada_linear_resid['percentil_atual'] = (df_moderada_linear_resid[0] - df_moderada_linear_resid[0].mean())/df_moderada_linear_resid[0].std(ddof=0)

# Modelo com distribuição Gamma 
df_moderada_gamma_resid = moderada_fleem_gamma_resid.sort_values(by=[0], ascending=True).reset_index()
df_moderada_gamma_resid['count'] = df_moderada_gamma_resid.index + 1
n_rows = df_moderada_gamma_resid.shape[0]
df_moderada_gamma_resid['percentil_area'] = (df_moderada_linear_resid['count'])/n_rows
df_moderada_gamma_resid['percentil_teorico'] = ndtri(df_moderada_gamma_resid['percentil_area'])
df_moderada_gamma_resid['percentil_atual'] = (df_moderada_gamma_resid[0] - df_moderada_gamma_resid[0].mean())/df_moderada_gamma_resid[0].std(ddof=0)


######## AF VIGOROSA  #######

# Modelo com distribuição linear
df_vigorosa_linear_resid = vigorosa_fleem_linear_resid.sort_values(by=[0], ascending=True).reset_index()
df_vigorosa_linear_resid['count'] = df_vigorosa_linear_resid.index + 1
n_rows = df_vigorosa_linear_resid.shape[0]
df_vigorosa_linear_resid['percentil_area'] = (df_vigorosa_linear_resid['count'])/n_rows
df_vigorosa_linear_resid['percentil_teorico'] = ndtri(df_vigorosa_linear_resid['percentil_area'])
df_vigorosa_linear_resid['percentil_atual'] = (df_vigorosa_linear_resid[0] - df_vigorosa_linear_resid[0].mean())/df_vigorosa_linear_resid[0].std(ddof=0)

# Modelo com distribuição Gamma 
df_vigorosa_gamma_resid = vigorosa_fleem_gamma_resid.sort_values(by=[0], ascending=True).reset_index()
df_vigorosa_gamma_resid['count'] = df_vigorosa_gamma_resid.index + 1
n_rows = df_vigorosa_gamma_resid.shape[0]
df_vigorosa_gamma_resid['percentil_area'] = (df_vigorosa_linear_resid['count'])/n_rows
df_vigorosa_gamma_resid['percentil_teorico'] = ndtri(df_vigorosa_gamma_resid['percentil_area'])
df_vigorosa_gamma_resid['percentil_atual'] = (df_vigorosa_gamma_resid[0] - df_vigorosa_gamma_resid[0].mean())/df_vigorosa_gamma_resid[0].std(ddof=0)



################ Construir subplots############################

################# AF LEVE ########################
fig, ((ax1,ax2), (ax3,ax4)) = plt.subplots(nrows = 2, ncols = 2, figsize=(8,5), sharey=False)


pp = sm.ProbPlot(df_leve_linear_resid.percentil_atual, dist=scipy.stats.distributions.norm, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax1)
sm.qqline(qq.axes[0], line='45')
ax1.set_ylabel('Quantis observados')
ax1.set_xlabel('Quantis te�ricos (normal)')
ax2.scatter(leve_fleem_linear_predito, leve_fleem_linear_resid, s=3, c='black')
ax2.set_ylabel('Res�duo do modelo')
ax2.set_xlabel('Predito pelo modelo')

pp = sm.ProbPlot(df_leve_gamma_resid.percentil_atual, dist=scipy.stats.distributions.norm, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax3)
sm.qqline(qq.axes[2], line='45')
ax3.set_ylabel('Quantis observados')
ax3.set_xlabel('Quantis te�ricos (normal)')
ax4.scatter(leve_fleem_gamma_predito, leve_fleem_gamma_resid, s=3, c='black')
ax4.set_ylabel('Res�duo do modelo')
ax4.set_xlabel('Predito pelo modelo')


plt.rcParams['axes.labelsize']=12
plt.rcParams['axes.titlesize']=12


plt.tight_layout()
plt.savefig('D:/Projeto_mestrado/Dissertacao/MastersDissertation/An�lise dos res�duos dos modelos mistos/FLEEM/residuo_leve_fleem.png', bbox_inches='tight', dpi = 300)
plt.show()


################# AF MODERADA ########################
fig, ((ax1,ax2), (ax3,ax4)) = plt.subplots(nrows = 2, ncols = 2, figsize=(8,5), sharey=False)


pp = sm.ProbPlot(df_moderada_linear_resid.percentil_atual, dist=scipy.stats.distributions.norm, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax1)
sm.qqline(qq.axes[0], line='45')
ax1.set_ylabel('Quantis observados')
ax1.set_xlabel('Quantis te�ricos (normal)')
ax2.scatter(moderada_fleem_linear_predito, moderada_fleem_linear_resid, s=3, c='black')
ax2.set_ylabel('Res�duo do modelo')
ax2.set_xlabel('Predito pelo modelo')

pp = sm.ProbPlot(df_moderada_gamma_resid.percentil_atual, dist=scipy.stats.distributions.norm, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax3)
sm.qqline(qq.axes[2], line='45')
ax3.set_ylabel('Quantis observados')
ax3.set_xlabel('Quantis te�ricos (normal)')
ax4.scatter(moderada_fleem_gamma_predito, moderada_fleem_gamma_resid, s=3, c='black')
ax4.set_ylabel('Res�duo do modelo')
ax4.set_xlabel('Predito pelo modelo')


plt.rcParams['axes.labelsize']=12
plt.rcParams['axes.titlesize']=12


plt.tight_layout()
plt.savefig('D:/Projeto_mestrado/Dissertacao/MastersDissertation/An�lise dos res�duos dos modelos mistos/FLEEM/residuo_moderada_fleem.png', bbox_inches='tight', dpi = 300)
plt.show()


################# AF VIGOROSA ########################
fig, ((ax1,ax2), (ax3,ax4)) = plt.subplots(nrows = 2, ncols = 2, figsize=(8,5), sharey=False)


pp = sm.ProbPlot(df_vigorosa_linear_resid.percentil_atual, dist=scipy.stats.distributions.norm, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax1)
sm.qqline(qq.axes[0], line='45')
ax1.set_ylabel('Quantis observados')
ax1.set_xlabel('Quantis te�ricos (normal)')
ax2.scatter(vigorosa_fleem_linear_predito, vigorosa_fleem_linear_resid, s=3, c='black')
ax2.set_ylabel('Res�duo do modelo')
ax2.set_xlabel('Predito pelo modelo')

pp = sm.ProbPlot(df_vigorosa_gamma_resid.percentil_atual, dist=scipy.stats.distributions.norm, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax3)
sm.qqline(qq.axes[2], line='45')
ax3.set_ylabel('Quantis observados')
ax3.set_xlabel('Quantis te�ricos (normal)')
ax4.scatter(vigorosa_fleem_gamma_predito, vigorosa_fleem_gamma_resid, s=3, c='black')
ax4.set_ylabel('Res�duo do modelo')
ax4.set_xlabel('Predito pelo modelo')


plt.rcParams['axes.labelsize']=12
plt.rcParams['axes.titlesize']=12


plt.tight_layout()
plt.savefig('D:/Projeto_mestrado/Dissertacao/MastersDissertation/An�lise dos res�duos dos modelos mistos/FLEEM/residuo_vigorosa_fleem.png', bbox_inches='tight', dpi = 300)
plt.show()

