# Neste arquivo, vamos construir um banco de dados fictício e gerar uma rede para representarmos o nosso modelo conceitual de atividade fisica como um sistema dinâmico

# Vamos importar bibliotecas necessárias
library("tidyverse")
library("dplyr")
library("magrittr")
library("qgraph")


# Vamos gerar uma matriz de correlações ficticia para a construção do nosso modelo conceitual


# Vamos passar aqui as variáveis do modelo de atividade física
variaveis_af <- c("passos", "aceleracao_quadril", "aceleracao_punho", "aceleracao_tornozelo", 
                     "observacao", "questionarios", "GPS", "diarios")

# Adicione os nomes das novas variáveis
variaveis_gasto_calorico <- c("calorimetria", "consumo_oxigenio", "temperatura_corporal")
todas_variaveis <- c(variaveis_af, variaveis_gasto_calorico)

# Defina o número total de variáveis
num_variables <- length(todas_variaveis)


# Gerar matriz de correlação
corr_matrix <- matrix(0, nrow = num_variables, ncol = num_variables)
diag(corr_matrix) <- 1  # Diagonal principal igual a 1 (correlação perfeita consigo mesma)

# Definir valores de correlação entre as variáveis de atividade física
corr_af <- 0.9

# Definir valores de correlação entre as variáveis de gasto calórico
corr_gc <- 0.8

# Definir valores de correlação entre as variáveis de af e gasto calórico
corr_variaveis_gerais <- 0.7

# Preencher a matriz de correlação com valores adequados
for (i in 1:num_variables) {
  for (j in 1:num_variables) {
    if (todas_variaveis[i] %in% variaveis_gasto_calorico && todas_variaveis[j] %in% variaveis_gasto_calorico) {
      corr_matrix[i, j] <- corr_gc
    } else if (todas_variaveis[i] %in% variaveis_af && todas_variaveis[j] %in% variaveis_af) {
      corr_matrix[i, j] <- corr_af
    } else {
      corr_matrix[i, j] <- corr_variaveis_gerais
    }
  }
}

# Definir nomes das colunas e linhas
colnames(corr_matrix) <- (1:11)
rownames(corr_matrix) <- (1:11)
diag(corr_matrix) <- 1  # Diagonal principal igual a 1 (correlação perfeita consigo mesma)




# Vamos estimar a rede gerada pelos dados dictícios
png(file = "D:/Projeto_mestrado/Dissertacao/MastersDissertation/Modelo conceitual de AF como sistema/modelo_conceitual3.png", width=3000, height=2000, res=300)
cornet_model <- qgraph(corr_matrix, layout = "groups", minimum = 0, graph = "cor", nodeNames = c("Passos", "Aceleração quadril", "Aceleração punho", "Aceleração tornozelo", "Observação direta", "Questionários", "GPS", "Diários", "Calorimetria", "Consumo oxigênio", "Temperatura corporal"), labels = colnames(corr_matrix), 
                       edge.labels = FALSE, legend.mode = "style1", groups = list("Atividade Fisica" = 1:8, "Gasto Calórico" = 9:11), color = c("white", "gray"), posCol = "gray", negCol = "gray", repulsion = 0.7, edge.width = 0.4)

dev.off()
