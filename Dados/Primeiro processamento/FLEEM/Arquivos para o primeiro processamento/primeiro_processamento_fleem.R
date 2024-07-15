# Carregar pacotes necessários
library(statsr)
library(dplyr)
library(ggplot2)
library(readxl)
library(lubridate)

# Carregar arquivo com os dados anteriores à aquisição do domínio (xlsx)
dados <- read_excel("1.xlsx")

# Carregar arquivo com os dados posteriores à aquisição do domínio (csv)
dados <- read.csv("D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Sem nenhum processamento/FLEEM/Arquivos de aceleração extraídos do site/79.csv")

### Código para operações com arquivo xlsx
# Converter os dados da coluna de data em um formato 'Date'
dados$Data <- as.Date(dados$datahora_app)

# Separar os dados de data em ano, mês, dia, hora, minuto e segundo
dados$Ano <- as.double(format(dados$datahora_app, "%Y"))
dados$Mes <- as.double(format(dados$datahora_app, "%m"))
dados$Dia <- as.double(format(dados$datahora_app, "%d"))
dados$hora <- as.double(format(dados$datahora_app,"%H"))
dados$minuto <- as.double(format(dados$datahora_app,"%M"))
dados$segundo <- as.double(format(dados$datahora_app,"%S"))


### Código para operações com arquivo csv
# Converter os dados da coluna de data em um formato 'Date'
dados$Data <- as.Date(dados$datahora_app)

# Separar os dados de data em ano, mês, dia, hora, minuto e segundo
dados$Ano <- year(dados$datahora_app)
dados$Mes <- month(dados$datahora_app)
dados$Dia <- day(dados$datahora_app)
dados$hora <- hour(dados$datahora_app)
dados$minuto <- minute(dados$datahora_app)
dados$segundo <- second(dados$datahora_app)


# Filtrar os dados para manter somente aqueles que são necessários para serem analisados em ambiente Matlab
dados = dados %>%
  select(count, Data, Ano, Mes, Dia, hora, minuto, segundo)


# Separar os dados em um arquivo diferente para cada dia de monitoramento
dia <- 0

dados_split <- split(dados, dados$Data) # Separar o banco de dados, com base na data de coleta

# Especificar o diretório onde os arquivos para esse sujeito serão salvos
diretorio_destino <- "D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Primeiro processamento/FLEEM/Arquivos em csv após o primeiro processamento/763" # O número corresponde à identificação única para esse sujeito

# Percorrer as diferentes datas, para salvar um arquivo csv para cada data
for(i in dados_split){
  i <- i %>%
    select(count, Ano, Mes, Dia, hora, minuto, segundo)
  dia <- dia + 1
  
  # Criar o caminho completo do arquivo com file.path
  caminho_arquivo <- file.path(diretorio_destino, paste("dia", as.character(dia), "csv", sep = "."))
  
  # Verificar se o diretório de destino existe, se não, criar
  if (!dir.exists(diretorio_destino)) {
    dir.create(diretorio_destino, recursive = TRUE)
  }
  
  write.table(i, caminho_arquivo, sep = ",", col.names = FALSE, row.names = FALSE)
}
