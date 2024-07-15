# Vamos carregar os bancos de dados no formato long, para podermos estimar o desvio padrão de cada um dos desfechos

# Primeiro, vamos importar bibliotecas necessárias
library(readxl)
library("tidyverse")
library("dplyr")

# Dados IPAQ
dados_ipaq <- read_excel("D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Sexto processamento/banco_dados_reestruturado_sem_outliers.xlsx")

# Dados FLEEM
dados_fleem <- read_excel("D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Quinto processamento/banco_dados_reestruturado.xlsx")


# Precisaremos criar outros bancos de dados, somente com os dados de 2, 3 e 4 semanas

# IPAQ
dados_ipaq_4_semanas <- dados_ipaq[dados_ipaq$Semana >= 1 & dados_ipaq$Semana <= 4, ]
dados_ipaq_3_semanas <- dados_ipaq[dados_ipaq$Semana >= 1 & dados_ipaq$Semana <= 3, ]
dados_ipaq_2_semanas <- dados_ipaq[dados_ipaq$Semana >= 1 & dados_ipaq$Semana <= 2, ]


# FLEEM
dados_fleem_4_semanas <- dados_fleem[dados_fleem$Semana >= 1 & dados_fleem$Semana <= 4, ]
dados_fleem_3_semanas <- dados_fleem[dados_fleem$Semana >= 1 & dados_fleem$Semana <= 3, ]
dados_fleem_2_semanas <- dados_fleem[dados_fleem$Semana >= 1 & dados_fleem$Semana <= 2, ]


# Agora vamos estimar os desvios padrão para cada desfecho

# IPAQ

# 5 semanas
dp_caminhada_5_semanas <- sd(na.omit(dados_ipaq$Caminhada_IPAQ_10))
dp_ipaq_moderada_5_semanas <- sd(na.omit(dados_ipaq$Moderada_IPAQ_10))
dp_ipaq_vigorosa_5_semanas <- sd(na.omit(dados_ipaq$Vigorosa_IPAQ_10))

# 4 Semanas
dp_caminhada_4_semanas <- sd(na.omit(dados_ipaq_4_semanas$Caminhada_IPAQ_10))
dp_ipaq_moderada_4_semanas <- sd(na.omit(dados_ipaq_4_semanas$Moderada_IPAQ_10))
dp_ipaq_vigorosa_4_semanas <- sd(na.omit(dados_ipaq_4_semanas$Vigorosa_IPAQ_10))

# 3 Semanas
dp_caminhada_3_semanas <- sd(na.omit(dados_ipaq_3_semanas$Caminhada_IPAQ_10))
dp_ipaq_moderada_3_semanas <- sd(na.omit(dados_ipaq_3_semanas$Moderada_IPAQ_10))
dp_ipaq_vigorosa_3_semanas <- sd(na.omit(dados_ipaq_3_semanas$Vigorosa_IPAQ_10))

# 2 Semanas
dp_caminhada_2_semanas <- sd(na.omit(dados_ipaq_2_semanas$Caminhada_IPAQ_10))
dp_ipaq_moderada_2_semanas <- sd(na.omit(dados_ipaq_2_semanas$Moderada_IPAQ_10))
dp_ipaq_vigorosa_2_semanas <- sd(na.omit(dados_ipaq_2_semanas$Vigorosa_IPAQ_10))


# FLEEM

# 5 Semanas
dp_leve_5_semanas <- sd(na.omit(dados_fleem$Leve_FLEEM))
dp_fleem_moderada_5_semanas <- sd(na.omit(dados_fleem$Moderada_FLEEM_10))
dp_fleem_vigorosa_5_semanas <- sd(na.omit(dados_fleem$Vigorosa_FLEEM_10))

# 4 Semanas
dp_leve_4_semanas <- sd(na.omit(dados_fleem_4_semanas$Leve_FLEEM))
dp_fleem_moderada_4_semanas <- sd(na.omit(dados_fleem_4_semanas$Moderada_FLEEM_10))
dp_fleem_vigorosa_4_semanas <- sd(na.omit(dados_fleem_4_semanas$Vigorosa_FLEEM_10))

# 3 Semanas
dp_leve_3_semanas <- sd(na.omit(dados_fleem_3_semanas$Leve_FLEEM))
dp_fleem_moderada_3_semanas <- sd(na.omit(dados_fleem_3_semanas$Moderada_FLEEM_10))
dp_fleem_vigorosa_3_semanas <- sd(na.omit(dados_fleem_3_semanas$Vigorosa_FLEEM_10))

# 2 Semanas
dp_leve_2_semanas <- sd(na.omit(dados_fleem_2_semanas$Leve_FLEEM))
dp_fleem_moderada_2_semanas <- sd(na.omit(dados_fleem_2_semanas$Moderada_FLEEM_10))
dp_fleem_vigorosa_2_semanas <- sd(na.omit(dados_fleem_2_semanas$Vigorosa_FLEEM_10))


# Agora vamos estimar o erro padrão da medida para medida única e média das medidas para os dados de 2 a 5 semanas

# Primeiro, vamos criar uma função para estimar o erro padrão, precisando informar o desvio padrão da medida e o ICC dela
calcular_erro_padrao <- function(dp, icc){
  raiz_complementar_icc <- sqrt(1-icc)
  ep <- dp*raiz_complementar_icc
  
  return(ep)
}

# Primeiro, vamos trabalhar com os dados do IPAQ

# Caminhada 
ep_caminhada_2_semanas_MU <- calcular_erro_padrao(dp_caminhada_2_semanas, 0.53)
ep_caminhada_2_semanas_MM <- calcular_erro_padrao(dp_caminhada_2_semanas, 0.69)
ep_caminhada_3_semanas_MU <- calcular_erro_padrao(dp_caminhada_3_semanas, 0.68)
ep_caminhada_3_semanas_MM <- calcular_erro_padrao(dp_caminhada_3_semanas, 0.86)
ep_caminhada_4_semanas_MU <- calcular_erro_padrao(dp_caminhada_4_semanas, 0.75)
ep_caminhada_4_semanas_MM <- calcular_erro_padrao(dp_caminhada_4_semanas, 0.92)
ep_caminhada_5_semanas_MU <- calcular_erro_padrao(dp_caminhada_5_semanas, 0.72)
ep_caminhada_5_semanas_MM <- calcular_erro_padrao(dp_caminhada_5_semanas, 0.93)


# Moderada
ep_ipaq_moderada_2_semanas_MU <- calcular_erro_padrao(dp_ipaq_moderada_2_semanas, 0.82)
ep_ipaq_moderada_2_semanas_MM <- calcular_erro_padrao(dp_ipaq_moderada_2_semanas, 0.90)
ep_ipaq_moderada_3_semanas_MU <- calcular_erro_padrao(dp_ipaq_moderada_3_semanas, 0.68)
ep_ipaq_moderada_3_semanas_MM <- calcular_erro_padrao(dp_ipaq_moderada_3_semanas, 0.86)
ep_ipaq_moderada_4_semanas_MU <- calcular_erro_padrao(dp_ipaq_moderada_4_semanas, 0.75)
ep_ipaq_moderada_4_semanas_MM <- calcular_erro_padrao(dp_ipaq_moderada_4_semanas, 0.92)
ep_ipaq_moderada_5_semanas_MU <- calcular_erro_padrao(dp_ipaq_moderada_5_semanas, 0.72)
ep_ipaq_moderada_5_semanas_MM <- calcular_erro_padrao(dp_ipaq_moderada_5_semanas, 0.93)


# Vigorosa
ep_ipaq_vigorosa_2_semanas_MU <- calcular_erro_padrao(dp_ipaq_vigorosa_2_semanas, 0.76)
ep_ipaq_vigorosa_2_semanas_MM <- calcular_erro_padrao(dp_ipaq_vigorosa_2_semanas, 0.86)
ep_ipaq_vigorosa_3_semanas_MU <- calcular_erro_padrao(dp_ipaq_vigorosa_3_semanas, 0.70)
ep_ipaq_vigorosa_3_semanas_MM <- calcular_erro_padrao(dp_ipaq_vigorosa_3_semanas, 0.87)
ep_ipaq_vigorosa_4_semanas_MU <- calcular_erro_padrao(dp_ipaq_vigorosa_4_semanas, 0.71)
ep_ipaq_vigorosa_4_semanas_MM <- calcular_erro_padrao(dp_ipaq_vigorosa_4_semanas, 0.91)
ep_ipaq_vigorosa_5_semanas_MU <- calcular_erro_padrao(dp_ipaq_vigorosa_5_semanas, 0.73)
ep_ipaq_vigorosa_5_semanas_MM <- calcular_erro_padrao(dp_ipaq_vigorosa_5_semanas, 0.93)



# Agora, vamos trabalhar com os dados do FLEEM SYSTEM

# Intensidade leve
ep_fleem_leve_2_semanas_MU <- calcular_erro_padrao(dp_leve_2_semanas, 0.73)
ep_fleem_leve_2_semanas_MM <- calcular_erro_padrao(dp_leve_2_semanas, 0.84)
ep_fleem_leve_3_semanas_MU <- calcular_erro_padrao(dp_leve_3_semanas, 0.75)
ep_fleem_leve_3_semanas_MM <- calcular_erro_padrao(dp_leve_3_semanas, 0.90)
ep_fleem_leve_4_semanas_MU <- calcular_erro_padrao(dp_leve_4_semanas, 0.74)
ep_fleem_leve_4_semanas_MM <- calcular_erro_padrao(dp_leve_4_semanas, 0.92)
ep_fleem_leve_5_semanas_MU <- calcular_erro_padrao(dp_leve_5_semanas, 0.75)
ep_fleem_leve_5_semanas_MM <- calcular_erro_padrao(dp_leve_5_semanas, 0.94)


# Intensidade moderada
ep_fleem_moderada_2_semanas_MU <- calcular_erro_padrao(dp_fleem_moderada_2_semanas, 0.73)
ep_fleem_moderada_2_semanas_MM <- calcular_erro_padrao(dp_fleem_moderada_2_semanas, 0.84)
ep_fleem_moderada_3_semanas_MU <- calcular_erro_padrao(dp_fleem_moderada_3_semanas, 0.70)
ep_fleem_moderada_3_semanas_MM <- calcular_erro_padrao(dp_fleem_moderada_3_semanas, 0.88)
ep_fleem_moderada_4_semanas_MU <- calcular_erro_padrao(dp_fleem_moderada_4_semanas, 0.72)
ep_fleem_moderada_4_semanas_MM <- calcular_erro_padrao(dp_fleem_moderada_4_semanas, 0.91)
ep_fleem_moderada_5_semanas_MU <- calcular_erro_padrao(dp_fleem_moderada_5_semanas, 0.72)
ep_fleem_moderada_5_semanas_MM <- calcular_erro_padrao(dp_fleem_moderada_5_semanas, 0.93)


# Intensidade vigorosa
ep_fleem_vigorosa_2_semanas_MU <- calcular_erro_padrao(dp_fleem_vigorosa_2_semanas, 0.83)
ep_fleem_vigorosa_2_semanas_MM <- calcular_erro_padrao(dp_fleem_vigorosa_2_semanas, 0.91)
ep_fleem_vigorosa_3_semanas_MU <- calcular_erro_padrao(dp_fleem_vigorosa_3_semanas, 0.79)
ep_fleem_vigorosa_3_semanas_MM <- calcular_erro_padrao(dp_fleem_vigorosa_3_semanas, 0.92)
ep_fleem_vigorosa_4_semanas_MU <- calcular_erro_padrao(dp_fleem_vigorosa_4_semanas, 0.80)
ep_fleem_vigorosa_4_semanas_MM <- calcular_erro_padrao(dp_fleem_vigorosa_4_semanas, 0.94)
ep_fleem_vigorosa_5_semanas_MU <- calcular_erro_padrao(dp_fleem_vigorosa_5_semanas, 0.79)
ep_fleem_vigorosa_5_semanas_MM <- calcular_erro_padrao(dp_fleem_vigorosa_5_semanas, 0.95)
