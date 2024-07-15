# Primeiro, vamos carregar os nossos pacotes
library(psych)
library("tidyverse")
library("dplyr")


# Agora, vamos carregar o nosso banco de dados
dados <- read.csv('D:/Projeto_mestrado/Dissertacao/MastersDissertation/Confiabilidade teste-reteste/Coeficiente de correlacao intraclasse/IPAQ/dados_ipaq_icc_wide.csv')

# Primeiro, vamos trabalhar com os dados de todas as 5 semanas

# Agora, vamos separar o nosso banco de dados nas 3 diferentes intensidades
dados_moderada <- dados[2:6]
dados_vigorosa <- dados[c(7:11)]
dados_caminhada <- dados[c(12:16)]

# Agora vamos estimar o coeficiente de correlação intraclasse para cada uma das intensidades

icc_caminhada <- ICC(dados_caminhada, missing=TRUE, alpha = .05, lmer=TRUE)
icc_moderada <- ICC(dados_moderada, missing=TRUE, alpha = .05, lmer=TRUE)
icc_vigorosa <- ICC(dados_vigorosa, missing=TRUE, alpha = .05, lmer = TRUE)


# Agora vamos reproduzir as mesmas análises, porém, utilizando dados somente de 4 semanas

# Primeiramente, vamos filtrar nossos bancos de dados para que fique somente com medidas de 4 semanas
dados_moderada_4_semanas <- dados_moderada %>%
  select(-Moderada_IPAQ_10.5)

dados_vigorosa_4_semanas <- dados_vigorosa %>%
  select(-Vigorosa_IPAQ_10.5)

dados_caminhada_4_semanas <- dados_caminhada %>%
  select(-Caminhada_IPAQ_10.5)


# Agora vamos estimar o coeficiente de correlação intraclasse para cada uma das intensidades

icc_caminhada_4_semanas <- ICC(dados_caminhada_4_semanas, missing=TRUE, alpha = .05, lmer=TRUE)
icc_moderada_4_semanas <- ICC(dados_moderada_4_semanas, missing=TRUE, alpha = .05, lmer=TRUE)
icc_vigorosa_4_semanas <- ICC(dados_vigorosa_4_semanas, missing=TRUE, alpha = .05, lmer = TRUE)



# Agora vamos reproduzir as mesmas análises, porém, utilizando dados somente de 3 semanas

# Primeiramente, vamos filtrar nossos bancos de dados para que fique somente com medidas de 3 semanas
dados_moderada_3_semanas <- dados_moderada %>%
  select(-Moderada_IPAQ_10.4, -Moderada_IPAQ_10.5)

dados_vigorosa_3_semanas <- dados_vigorosa %>%
  select(-Vigorosa_IPAQ_10.4, -Vigorosa_IPAQ_10.5)

dados_caminhada_3_semanas <- dados_caminhada %>%
  select(-Caminhada_IPAQ_10.4, -Caminhada_IPAQ_10.5)


# Agora vamos estimar o coeficiente de correlação intraclasse para cada uma das intensidades

icc_caminhada_3_semanas <- ICC(dados_caminhada_3_semanas, missing=TRUE, alpha = .05, lmer=TRUE)
icc_moderada_3_semanas <- ICC(dados_moderada_3_semanas, missing=TRUE, alpha = .05, lmer=TRUE)
icc_vigorosa_3_semanas <- ICC(dados_vigorosa_3_semanas, missing=TRUE, alpha = .05, lmer = TRUE)



# Primeiramente, vamos filtrar nossos bancos de dados para que fique somente com medidas de 2 semanas
dados_moderada_2_semanas <- dados_moderada %>%
  select(-Moderada_IPAQ_10.4, -Moderada_IPAQ_10.5, -Moderada_IPAQ_10.3)

dados_vigorosa_2_semanas <- dados_vigorosa %>%
  select(-Vigorosa_IPAQ_10.4, -Vigorosa_IPAQ_10.5, -Vigorosa_IPAQ_10.3)

dados_caminhada_2_semanas <- dados_caminhada %>%
  select(-Caminhada_IPAQ_10.4, -Caminhada_IPAQ_10.5, -Caminhada_IPAQ_10.3)


# Agora vamos estimar o coeficiente de correlação intraclasse para cada uma das intensidades

icc_caminhada_2_semanas <- ICC(dados_caminhada_2_semanas, missing=TRUE, alpha = .05, lmer=TRUE)
icc_moderada_2_semanas <- ICC(dados_moderada_2_semanas, missing=TRUE, alpha = .05, lmer=TRUE)
icc_vigorosa_2_semanas <- ICC(dados_vigorosa_2_semanas, missing=TRUE, alpha = .05, lmer = TRUE)

