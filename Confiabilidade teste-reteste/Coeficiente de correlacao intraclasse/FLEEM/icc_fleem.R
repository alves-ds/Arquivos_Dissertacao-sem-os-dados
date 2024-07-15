# Primeiro, vamos carregar os nossos pacotes
library(psych)
library("tidyverse")
library("dplyr")


# Agora, vamos carregar o nosso banco de dados
dados <- read.csv('D:/Projeto_mestrado/Dissertacao/MastersDissertation/Confiabilidade teste-reteste/Coeficiente de correlação intraclasse/FLEEM/dados_fleem_wide.csv')


# Primeiro, vamos trabalhar com os dados de todas as 5 semanas

# Agora, vamos separar o nosso banco de dados nas 3 diferentes intensidades
dados_leve <- dados[2:6]
dados_moderada <- dados[7:11]
dados_vigorosa <- dados[12:16]

# Agora vamos estimar o coeficiente de correlação intraclasse para cada uma das intensidades

icc_leve <- ICC(dados_leve, missing=TRUE, alpha = .05, lmer=TRUE)
icc_moderada <- ICC(dados_moderada, missing=TRUE, alpha = .05, lmer=TRUE)
icc_vigorosa <- ICC(dados_vigorosa, missing=TRUE, alpha = .05, lmer = TRUE)


# Agora vamos reproduzir as mesmas análises, porém, utilizando dados somente de 4 semanas

# Primeiramente, vamos filtrar nossos bancos de dados para que fique somente com medidas de 4 semanas
dados_leve_4_semanas <- dados_leve %>%
  select(-Leve_FLEEM.5)

dados_moderada_4_semanas <- dados_moderada %>%
  select(-Moderada_FLEEM_10.5)

dados_vigorosa_4_semanas <- dados_vigorosa %>%
  select(-Vigorosa_FLEEM_10.5)


icc_leve_4_semanas <- ICC(dados_leve_4_semanas, missing=TRUE, alpha = .05, lmer=TRUE)
icc_moderada_4_semanas <- ICC(dados_moderada_4_semanas, missing=TRUE, alpha = .05, lmer=TRUE)
icc_vigorosa_4_semanas <- ICC(dados_vigorosa_4_semanas, missing=TRUE, alpha = .05, lmer = TRUE)



# Agora vamos reproduzir as mesmas análises, porém, utilizando dados somente de 3 semanas

# Primeiramente, vamos filtrar nossos bancos de dados para que fique somente com medidas de 3 semanas
dados_leve_3_semanas <- dados_leve %>%
  select(-Leve_FLEEM.5, -Leve_FLEEM.4)

dados_moderada_3_semanas <- dados_moderada %>%
  select(-Moderada_FLEEM_10.5, -Moderada_FLEEM_10.4)

dados_vigorosa_3_semanas <- dados_vigorosa %>%
  select(-Vigorosa_FLEEM_10.5, -Vigorosa_FLEEM_10.4)


icc_leve_3_semanas <- ICC(dados_leve_3_semanas, missing=TRUE, alpha = .05, lmer=TRUE)
icc_moderada_3_semanas <- ICC(dados_moderada_3_semanas, missing=TRUE, alpha = .05, lmer=TRUE)
icc_vigorosa_3_semanas <- ICC(dados_vigorosa_3_semanas, missing=TRUE, alpha = .05, lmer = TRUE)



# Agora vamos reproduzir as mesmas análises, porém, utilizando dados somente de 2 semanas

# Primeiramente, vamos filtrar nossos bancos de dados para que fique somente com medidas de 2 semanas
dados_leve_2_semanas <- dados_leve %>%
  select(-Leve_FLEEM.5, -Leve_FLEEM.4, -Leve_FLEEM.3)

dados_moderada_2_semanas <- dados_moderada %>%
  select(-Moderada_FLEEM_10.5, -Moderada_FLEEM_10.4, -Moderada_FLEEM_10.3)

dados_vigorosa_2_semanas <- dados_vigorosa %>%
  select(-Vigorosa_FLEEM_10.5, -Vigorosa_FLEEM_10.4, -Vigorosa_FLEEM_10.3)


icc_leve_2_semanas <- ICC(dados_leve_2_semanas, missing=TRUE, alpha = .05, lmer=TRUE)
icc_moderada_2_semanas <- ICC(dados_moderada_2_semanas, missing=TRUE, alpha = .05, lmer=TRUE)
icc_vigorosa_2_semanas <- ICC(dados_vigorosa_2_semanas, missing=TRUE, alpha = .05, lmer = TRUE)



