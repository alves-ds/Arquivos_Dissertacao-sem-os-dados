library(statsr)
library(dplyr)
library(ggplot2)
library(readxl)
library(lubridate)
library(tidyr)
library(writexl)

dados <- read.csv("Resultado AF.csv", header = TRUE, sep = ";")


# criando banco de dados com os indivíduos incluídos
dados_incluidos <- dados

#Criar função para converter as horas em minutos
converte_para_minutos <- function(tempo) {
  partes <- strsplit(tempo, ":")[[1]]
  horas <- as.numeric(partes[1])
  minutos <- as.numeric(partes[2])
  segundos <- as.numeric(partes[3])
  
  total_minutos <- horas * 60 + minutos + segundos / 60
  return(total_minutos)
}

#aplicando a função no banco de dados
dados_transformados <- dados_incluidos %>%
  mutate(
    LeveMin = sapply(Ligth, converte_para_minutos),
    ModeradaMin = sapply(Moderate, converte_para_minutos),
    VigorosaMin = sapply(Vigorous, converte_para_minutos),
    StrongMin = sapply(Strong, converte_para_minutos)
    )

#Juntar strong e vigorous em uma só
dados_transformados <- dados_transformados %>%
  mutate(Vigorosa = VigorosaMin + StrongMin)

# Manter só os valores em minutos no dataframe
dados_analise <- dados_transformados %>%
  select(-Sleep, -Sedentary, -Ligth, -Moderate, -Vigorous, -Strong, -VigorosaMin, -StrongMin)


# Convertendo a coluna de data para o formato de data
dados_analise$Date <- dmy(dados_analise$Date)

# Agrupar e organizar os dados
dados_ordenados <- dados_analise %>%
  arrange(IDPerfil, Date)


dados_para_transpor <- dados_ordenados %>%
  group_by(IDPerfil) %>%
  arrange(Date) %>%
  mutate(observacao = row_number())


write_xlsx(dados_para_transpor, "dados_diarios_sem_transpor.xlsx")

#Posteriormente, basta importar no Jamovi e fazer a transposição
