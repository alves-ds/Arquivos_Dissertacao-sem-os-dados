install.packages("knitr")
install.packages("kableExtra")

# Carregar pacotes
library(statsr)
library(dplyr)
library(ggplot2)
library(readxl)
library(lubridate)
library(tidyr)
library(writexl)
library(kableExtra)
library(knitr)



# Primeiro, vamos carregar o nosso banco de dados
dados <- read_excel('D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Quinto processamento/banco_dados_reestruturado.xlsx')


# Agora, vamos adicionar mais uma variável no banco de dados, que é o IMC dos sujeitos
dados$IMC <- dados$Massa/dados$Estatura^2


# Primeiro, vamos calcular as proporções das variáveis categóricas
proporcao_sexo <- prop.table(table(dados$Sexo))
proporcao_trabalho <- prop.table(table(dados$Trabalho))
proporcao_escolaridade <- prop.table(table(dados$Escolaridade))


# Nesta etapa, observou-se que um dos participantes preencheu o nível de escolaridade incorretamente. Contatando este participante (ID 25), foi-se possível saber o seu real nível de escolaridade, portanto, vamos corrigir nos nossos dados.
dados$Escolaridade <- ifelse(dados$Escolaridade == "Ensino fundamental incompleto", "Ensino superior completo", dados$Escolaridade)



# Agora vamos calcular média e intervalo de confiança dos dados contínuos e discretos
# Para isso, vamos definir uma função para calcular o intervalo de confiança de 95% em torno da média dos dados 
calculo_ic <- function(dados){
  media <- mean(dados)
  z <- 1.96
  dp <- sd(dados)
  rn <- sqrt(length(dados))
  
  ic_upper <- media + z*(dp/rn)
  ic_lower <- media - z*(dp/rn)
  
  intervalo_confianca <- c(ic_lower, ic_upper)
  return(intervalo_confianca)
}

# Agora vamos calcular média e intervalo de confiança de 95% para cada variável contínua ou discreta
media_idade <- mean(dados$Idade)
ic_idade <- calculo_ic(dados$Idade)

media_estatura <- mean(dados$Estatura)
ic_estatura <- calculo_ic(dados$Estatura)

media_massa <- mean(dados$Massa)
ic_massa <- calculo_ic(dados$Massa)

media_IMC <- mean(dados$IMC)
ic_imc <- calculo_ic(dados$IMC)

# Vamos salvar esses intervalos de confiança em apenas uma variável, para podermos utilizá-la na nossa tabela
ics <- c(ic_idade, ic_estatura, ic_massa, ic_imc)

# Nossa tabela possui 6 colunas contendo os intervalos inferior e superior de cada variável. Vamos concatenar esses intervalos em apenas uma variável.

# Criar um novo vetor contendo os intervalos de confiança arredondados
intervalos_confianca <- sapply(1:(length(ics)/2), function(i) {
  lower <- ics[i*2-1]
  upper <- ics[i*2]
  paste(round(lower, 2), round(upper, 2), sep = "-")
})

# Transformar o vetor em um dataframe
ics_dataframe <- data.frame(matrix(intervalos_confianca, ncol = length(intervalos_confianca), byrow = TRUE))


# Agora vamos tentar expressar esses resultados em uma tabela
tabela_esperanca <- data.frame(
  Variavel = c("Idade", "Sexo (M)", "Estatura", "Massa", "IMC", "Trabalho (S)", "Ensino médio completo", "Ensino superior completo", "Pós-graduação completa"),
  Esperanca = c(media_idade, "-", media_estatura, media_massa, media_IMC, "-", "-", "-", "-"),
  IC_95 = c(ics_dataframe$X1, "-", ics_dataframe$X2, ics_dataframe$X3, ics_dataframe$X4, "-", "-", "-", "-"),
  Contagem = c("-", 29, "-", "-", "-", 55, 24, 23, 17),
  Percentual = c("-", 45.3, "-", "-", "-", 85.9, 37.5, 35.9, 26.6)
)

# Vamos renomear algumas colunas
colnames(tabela_esperanca)[colnames(tabela_esperanca) == "Variavel"] <- " "
colnames(tabela_esperanca)[colnames(tabela_esperanca) == "IC_95"] <- "Intervalo de confiança de 95%"


# Agora vamos gerar a nossa tabela
knitr::kable(tabela_esperanca, format="markdown", align = 'c', digits = 2)

