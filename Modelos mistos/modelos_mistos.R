# Vamos baixar os pacotes necessário para as análises, caso não os tenhamos
install.packages('lme4')
install.packages("emmeans")

# Caso dê algum conflito para carregar o pacote "Matrix", podemos fazer isso manualmente com o seguinte comando:
remove.packages("Matrix")
install.packages("Matrix")


# Vamos carregar nossos pacotes
library(statsr)
library(dplyr)
library(ggplot2)
library(readxl)
library(lubridate)
library(tidyr)
library(writexl)
library(kableExtra)
library(knitr)
library(lme4)
library(emmeans)


# Vamos carregar nosso banco de dados. Primeiro, trabalharemos com o banco de dados sem a aplicação de nenhum método de identificação de outliers
dados <- read_excel("D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Quinto processamento/banco_dados_reestruturado.xlsx")


# Podemos ver que a variável "semana" está definida como uma variável numérica. Portanto, vamos convertê-la em fator
dados$Semana <- as.factor(dados$Semana)


# Para cada variável dependente, testaremos o ajuste de dois modelos lineares generalizados, que irão se diferir somente quanto à distribuição de probabilidade assumida para a variável dependente, com base nos resultados que obtemos na análise exploratória.


# Primeiro, iremos modelar os dados de caminhada obtidos através do IPAQ, baseando-se na seguinte equação teórica
# caminhada = b0 + b1*Semanas + erro, considerando os indivíduos como um fator aleatório.

# Para cada modelo, faremos a inspeção da distribuição dos resíduos e do nível de adequação por meio do AIC e QIC

# No nosso primeiro modelo, assumiremos uma distribuição de probabilidade normal
modelo_caminhada1 <- lmer(Caminhada_IPAQ_10 ~ Semana + (1 | ID), data = dados, na.action = na.exclude)
AIC_modelo_caminhada1 <- AIC(modelo_caminhada1) #Extrai o AIC do modelo
BIC(modelo_caminhada1) # Extrai o BIC do modelo
qqnorm(residuals(modelo_caminhada1)); qqline(residuals(modelo_caminhada1)) #plota a distribuição dos resíduos


# Agora, faremos um segundo modelo, assumindo uma distribuição de probabilidade Gamma e uma função de ligação identidade
modelo_caminhada2 <- glmer(Caminhada_IPAQ_10 ~ Semana + (1 | ID), data = dados, family = Gamma(link="identity"), na.action = na.exclude)
AIC_modelo_caminhada2 <- AIC(modelo_caminhada2)
BIC(modelo_caminhada2)
qqnorm(residuals(modelo_caminhada2)); qqline(residuals(modelo_caminhada2))

# Para os dados de caminhada, observamos um AIC menor e resíduos com uma distribuição mais aderente à uma distribuição normal para o modelo 2, mas, escolheremos o modelo 1 para ser interpretado, tendo em vista que o modelo 2 não convergiu. 

# Caso tenhamos interesse em acessar os resultados par a par por meio de um teste posthoc, podemos utilizar os códigos abaixo:

# Extrair médias estimadas e realizar comparações
medias_emmeans <- emmeans(modelo_caminhada1, ~ Semana)

# Comparar todas as médias entre si
comparacoes <- pairs(medias_emmeans)

# Exibir as comparações
print(comparacoes)



# Agora, vamos trabalhar com a intensidade moderada do IPAQ

# Primeiro, faremos um modelo com distribuição normal e função de ligação identidade, seguindo o seguinte modelo teórico:
# Moderada = b0 + b1*Semanas + erro, considerando os indivíduos como um fator aleatório.
modelo_IPAQ_moderada1 <- lmer(Moderada_IPAQ_10 ~ Semana + (1 | ID), data = dados, na.action = na.exclude)
AIC_modelo_IPAQ_moderada1 <- AIC(modelo_IPAQ_moderada1) #Extrai o AIC do modelo
BIC(modelo_IPAQ_moderada1)
qqnorm(residuals(modelo_IPAQ_moderada1)); qqline(residuals(modelo_IPAQ_moderada1)) #plota a distribuição dos resíduos


# Agora faremos um segundo modelo, assumindo uma distribuição Gamma e uma função de ligação identidade
modelo_IPAQ_moderada2 <- glmer(Moderada_IPAQ_10 ~ Semana + (1 | ID), data = dados, family = Gamma(link="identity"), na.action = na.exclude)
AIC_modelo_IPAQ_moderada2 <- AIC(modelo_IPAQ_moderada2)
BIC(modelo_IPAQ_moderada2)
qqnorm(residuals(modelo_IPAQ_moderada2)); qqline(residuals(modelo_IPAQ_moderada2))

# Novamente, o modelo 2 não convergiu. Então adotaremos o modelo 1 para a interpretação. 



# Agora, vamos trabalhar com a intensidade vigorosa do IPAQ
# Primeiro, faremos um modelo com distribuição normal
modelo_IPAQ_vigorosa1 <- lmer(Vigorosa_IPAQ_10 ~ Semana + (1 | ID), data = dados, na.action = na.exclude)
AIC_modelo_IPAQ_vigorosa1 <- AIC(modelo_IPAQ_vigorosa1) #Extrai o AIC do modelo
BIC(modelo_IPAQ_vigorosa1)
qqnorm(residuals(modelo_IPAQ_vigorosa1)); qqline(residuals(modelo_IPAQ_vigorosa1))


# Agora faremos um segundo modelo, assumindo uma distribuição Gamma para a VD
modelo_IPAQ_vigorosa2 <- glmer(Vigorosa_IPAQ_10 ~ Semana + (1 | ID), data = dados, family = Gamma(link="identity"), na.action = na.exclude)
AIC_modelo_IPAQ_vigorosa2 <- AIC(modelo_IPAQ_vigorosa2) #Extrai o AIC do modelo
BIC(modelo_IPAQ_vigorosa2)
qqnorm(residuals(modelo_IPAQ_vigorosa2)); qqline(residuals(modelo_IPAQ_vigorosa2))

# Novamente, o modelo 2 não convergiu. Então adotaremos o modelo 1 para a interpretação. 


# Agora, vamos trabalhar com as variáveis do FLEEM. Para elas também construiremos dois modelos. Um com distribuição normal, e outro com distribuição Gamma. 

# Primeiro, trabalharemos com os dados de aceleração do centro de massa de intensidade leve
# Modelo com distribuição normal
modelo_FLEEM_leve1 <- lmer(Leve_FLEEM ~ Semana + (1 | ID), data = dados, na.action = na.exclude)
AIC_modelo_FLEEM_leve1 <- AIC(modelo_FLEEM_leve1) #Extrai o AIC do modelo
BIC(modelo_FLEEM_leve1)
qqnorm(residuals(modelo_FLEEM_leve1)); qqline(residuals(modelo_FLEEM_leve1))


# Modelo com distribuição Gamma
modelo_FLEEM_leve2 <- glmer(Leve_FLEEM ~ Semana + (1 | ID), data = dados, family = Gamma(link="identity"), na.action = na.exclude)
AIC_modelo_FLEEM_leve2 <- AIC(modelo_FLEEM_leve2) #Extrai o AIC do modelo
BIC(modelo_FLEEM_leve2)
qqnorm(residuals(modelo_FLEEM_leve2)); qqline(residuals(modelo_FLEEM_leve2))

# Para essa VD, aparentemente o modelo com distribuição normal aderiu melhor aos dados, apresentando um menor AIC e resíduos com uma distribuição mais normal


# Aceleração do centro de massa de intensidade moderada
# Modelo com distribuição normal
modelo_FLEEM_moderada1 <- lmer(Moderada_FLEEM_10 ~ Semana + (1 | ID), data = dados, na.action = na.exclude)
AIC_modelo_FLEEM_moderada1 <- AIC(modelo_FLEEM_moderada1) #Extrai o AIC do modelo
BIC(modelo_FLEEM_moderada1)
qqnorm(residuals(modelo_FLEEM_moderada1)); qqline(residuals(modelo_FLEEM_moderada1))


# Modelo com distribuição Gamma
modelo_FLEEM_moderada2 <- glmer(Moderada_FLEEM_10 ~ Semana + (1 | ID), data = dados, family = Gamma(link="identity"), na.action = na.exclude)
AIC_modelo_FLEEM_moderada2 <- AIC(modelo_FLEEM_moderada2) #Extrai o AIC do modelo
BIC(modelo_FLEEM_moderada2)
qqnorm(residuals(modelo_FLEEM_moderada2)); qqline(residuals(modelo_FLEEM_moderada2))


# Agora, por fim, trabalharemos com os dados de intensidade vigorosa
# Modelo com distribuição normal
modelo_FLEEM_vigorosa1 <- lmer(Vigorosa_FLEEM_10 ~ Semana + (1| ID), data = dados, na.action = na.exclude)
AIC_modelo_FLEEM_vigorosa1 <- AIC(modelo_FLEEM_vigorosa1)
BIC(modelo_FLEEM_vigorosa1)
qqnorm(residuals(modelo_FLEEM_vigorosa1)); qqline(residuals(modelo_FLEEM_vigorosa1))


# Modelo com distribuição Gamma
modelo_FLEEM_vigorosa2 <- glmer(Vigorosa_FLEEM_10 ~ Semana + (1| ID), data = dados, family = Gamma(link="identity"), na.action = na.exclude)
AIC_modelo_FLEEM_vigorosa2 <- AIC(modelo_FLEEM_vigorosa2)
BIC(modelo_FLEEM_vigorosa2)
qqnorm(residuals(modelo_FLEEM_vigorosa2)); qqline(residuals(modelo_FLEEM_vigorosa2))


# Agora, vamos salvar os resíduos e o predito para cada modelo, para posteriormente fazermos gráficos para analisar melhor qual modelo aderiu melhor à cada VD. 
dados$Predito_cam_1 <- predict(modelo_caminhada1)
dados$Residuo_cam_1 <- residuals(modelo_caminhada1)
dados$Predito_mod_1 <- predict(modelo_IPAQ_moderada1)
dados$Residuo_mod_1 <- residuals(modelo_IPAQ_moderada1)
dados$Predito_vig_1 <- predict(modelo_IPAQ_vigorosa1)
dados$Residuo_vig_1 <- residuals(modelo_IPAQ_vigorosa1)
dados$Predito_vig_2 <- predict(modelo_IPAQ_vigorosa2)
dados$Residuo_vig_2 <- residuals(modelo_IPAQ_vigorosa2)
dados$Predito_leve_1 <- predict(modelo_FLEEM_leve1)
dados$Residuo_leve_1 <- residuals(modelo_FLEEM_leve1)
dados$Predito_leve_2 <- predict(modelo_FLEEM_leve2)
dados$Residuo_leve_2 <- residuals(modelo_FLEEM_leve2)
dados$Predito_fmod_1 <- predict(modelo_FLEEM_moderada1)
dados$Residuo_fmod_1 <- residuals(modelo_FLEEM_moderada1)
dados$Predito_fmod_2 <- predict(modelo_FLEEM_moderada2)
dados$Residuo_fmod_2 <- residuals(modelo_FLEEM_moderada2)
dados$Predito_fvig_1 <- predict(modelo_FLEEM_vigorosa1)
dados$Residuo_fvig_1 <- residuals(modelo_FLEEM_vigorosa1)
dados$Predito_fvig_2 <- predict(modelo_FLEEM_vigorosa2)
dados$Residuo_fvig_2 <- residuals(modelo_FLEEM_vigorosa2)


# Agora vamos salvar esses dados para podermos analisar os resíduos graficamente em Python
write_xlsx(dados,"D:/Projeto_mestrado/Dissertacao/MastersDissertation/Modelos mistos/dados_com_residuos.xlsx")


##################################################################################################################################


# Agora, vamos fazer as análises também com o banco de dados sem outliers, baseando-se no método de limpeza dos dados sugerido pelos desenvolvedores do IPAQ
dados_sem_outliers <- read_excel("D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Quinto processamento/banco_dados_reestruturado_sem_outliers.xlsx")


# Podemos ver que a variável "semana" está definida como uma variável numérica. Portanto, vamos convertê-la em fator
dados_sem_outliers$Semana <- as.factor(dados_sem_outliers$Semana)


# Agora vamos contruir os modelos

# Primeiramente, vamos construir modelos para a caminhada obtida através do IPAQ
# Modelo com distribuição normal
modelo_caminhada_sem_outliers_1 <- lmer(Caminhada_IPAQ_10 ~ Semana + (1 | ID), data = dados_sem_outliers, na.action = na.exclude)
AIC_modelo_caminhada_sem_outliers_1 <- AIC(modelo_caminhada_sem_outliers_1) #Extrai o AIC do modelo
BIC(modelo_caminhada_sem_outliers_1)
qqnorm(residuals(modelo_caminhada_sem_outliers_1)); qqline(residuals(modelo_caminhada_sem_outliers_1)) #plota a distribuição dos resíduos


# Modelo com distribuição Gamma
modelo_caminhada_sem_outliers_2 <- glmer(Caminhada_IPAQ_10 ~ Semana + (1 | ID), data = dados_sem_outliers, family = Gamma(link="identity"), na.action = na.exclude)
AIC_modelo_caminhada_sem_outliers_2 <- AIC(modelo_caminhada_sem_outliers_2)
BIC(modelo_caminhada_sem_outliers_2)
qqnorm(residuals(modelo_caminhada_sem_outliers_2)); qqline(residuals(modelo_caminhada_sem_outliers_2))

# Mesmo após a remoção dos outliers pelo método de limpeza sugerido pelos desenvolvedores do IPAQ, o modelo com distribuição Gamma ainda não convergiu.  



# Agora, vamos trabalhar com a intensidade moderada do IPAQ
# Modelo com distribuição normal
modelo_IPAQ_moderada_sem_outliers_1 <- lmer(Moderada_IPAQ_10 ~ Semana + (1 | ID), data = dados_sem_outliers, na.action = na.exclude)
AIC_modelo_IPAQ_moderada_sem_outliers_1 <- AIC(modelo_IPAQ_moderada_sem_outliers_1) #Extrai o AIC do modelo
BIC(modelo_IPAQ_moderada_sem_outliers_1)
qqnorm(residuals(modelo_IPAQ_moderada_sem_outliers_1)); qqline(residuals(modelo_IPAQ_moderada_sem_outliers_1)) #plota a distribuição dos resíduos



# Modelo com distribuição Gamma
modelo_IPAQ_moderada_sem_outliers_2 <- glmer(Moderada_IPAQ_10 ~ Semana + (1 | ID), data = dados_sem_outliers, family = Gamma(link="identity"), na.action = na.exclude)
AIC_modelo_IPAQ_moderada_sem_outliers_2 <- AIC(modelo_IPAQ_moderada_sem_outliers_2)
BIC(modelo_IPAQ_moderada_sem_outliers_2)
qqnorm(residuals(modelo_IPAQ_moderada_sem_outliers_2)); qqline(residuals(modelo_IPAQ_moderada_sem_outliers_2))

# Novamente, o modelo 2 não convergiu. Então adotaremos o modelo 1 para a interpretação. 



# Agora, vamos trabalhar com a intensidade vigorosa do IPAQ
# Modelo com distribuição normal
modelo_IPAQ_vigorosa_sem_outliers_1 <- lmer(Vigorosa_IPAQ_10 ~ Semana + (1 | ID), data = dados_sem_outliers, na.action = na.exclude)
AIC_modelo_IPAQ_vigorosa_sem_outliers_1 <- AIC(modelo_IPAQ_vigorosa_sem_outliers_1) #Extrai o AIC do modelo
BIC(modelo_IPAQ_vigorosa_sem_outliers_1)
qqnorm(residuals(modelo_IPAQ_vigorosa_sem_outliers_1)); qqline(residuals(modelo_IPAQ_vigorosa_sem_outliers_1))



# Modelo com distribuição Gamma
modelo_IPAQ_vigorosa_sem_outliers_2 <- glmer(Vigorosa_IPAQ_10 ~ Semana + (1 | ID), data = dados_sem_outliers, family = Gamma(link="identity"), na.action = na.exclude)
AIC_modelo_IPAQ_vigorosa_sem_outliers_2 <- AIC(modelo_IPAQ_vigorosa_sem_outliers_2) #Extrai o AIC do modelo
BIC(modelo_IPAQ_vigorosa_sem_outliers_2)
qqnorm(residuals(modelo_IPAQ_vigorosa_sem_outliers_2)); qqline(residuals(modelo_IPAQ_vigorosa_sem_outliers_2))

# Mesmo após o processamento e remoção inicial de outliers, o modelo com distribuição Gamma não convergiu. 


# Agora, vamos salvar os resíduos e o predito para cada modelo, para posteriormente fazermos gráficos para analisar melhor qual modelo aderiu melhor à cada VD. 
dados_sem_outliers$Predito_cam__SO_1 <- predict(modelo_caminhada_sem_outliers_1)
dados_sem_outliers$Residuo_cam__SO_1 <- residuals(modelo_caminhada_sem_outliers_1)
dados_sem_outliers$Predito_mod__SO_1 <- predict(modelo_IPAQ_moderada_sem_outliers_1)
dados_sem_outliers$Residuo_mod_SO_1 <- residuals(modelo_IPAQ_moderada_sem_outliers_1)
dados_sem_outliers$Predito_vig_SO_1 <- predict(modelo_IPAQ_vigorosa_sem_outliers_1)
dados_sem_outliers$Residuo_vig_SO_1 <- residuals(modelo_IPAQ_vigorosa_sem_outliers_1)


# Agora vamos salvar esses dados para podermos analisar os resíduos graficamente em Python
write_xlsx(dados_sem_outliers,"D:/Projeto_mestrado/Dissertacao/MastersDissertation/Modelos mistos/dados__sem_outliers_com_residuos.xlsx")



####################################################################################################################################################



# Por fim, faremos as mesmas análises, porém com os dados com outliers removidos, considerando como outliers, valores cujo z-score é maior ou inferior à 3. 
dados_sem_outliers_z_score <- read_excel("D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Sexto processamento/banco_dados_reestruturado_sem_outliers.xlsx")

# Podemos ver que a variável "semana" está definida como uma variável numérica. Portanto, vamos convertê-la em fator
dados_sem_outliers_z_score$Semana <- as.factor(dados_sem_outliers_z_score$Semana)


# Agora vamos contruir os modelos

# Primeiro, trabalharemos com os dados de caminhada
# Modelo com distribuição normal
modelo_caminhada_sem_outliers_z_scor_1 <- lmer(Caminhada_IPAQ_10 ~ Semana + (1 | ID), data = dados_sem_outliers_z_score, na.action = na.exclude)
AIC_modelo_caminhada_sem_outliers_z_scor_1 <- AIC(modelo_caminhada_sem_outliers_z_scor_1) #Extrai o AIC do modelo
BIC(modelo_caminhada_sem_outliers_z_scor_1)
qqnorm(residuals(modelo_caminhada_sem_outliers_z_scor_1)); qqline(residuals(modelo_caminhada_sem_outliers_z_scor_1)) #plota a distribuição dos resíduos



# Modelo com distribuição Gamma
modelo_caminhada_sem_outliers_z_scor_2 <- glmer(Caminhada_IPAQ_10 ~ Semana + (1 | ID), data = dados_sem_outliers_z_score, family = Gamma(link="identity"), na.action = na.exclude)
AIC_modelo_caminhada_sem_outliers_z_scor_2 <- AIC(modelo_caminhada_sem_outliers_z_scor_2)
BIC(modelo_caminhada_sem_outliers_z_scor_2)
qqnorm(residuals(modelo_caminhada_sem_outliers_z_scor_2)); qqline(residuals(modelo_caminhada_sem_outliers_z_scor_2))

# O modelo 2 não convergiu mesmo após a remoção dos outliers por meio do processamento padrão do IPAQ e por meio da análise dos z-scores. Portanto, reteremos o modelo 1



# Agora, trabalharemos com os dados de intensidade moderada do IPAQ
# Modelo com distribuição normal
modelo_moderada_sem_outliers_z_scor_1 <- lmer(Moderada_IPAQ_10 ~ Semana + (1 | ID), data = dados_sem_outliers_z_score, na.action = na.exclude)
AIC_modelo_moderada_sem_outliers_z_scor_1 <- AIC(modelo_moderada_sem_outliers_z_scor_1) #Extrai o AIC do modelo
BIC(modelo_moderada_sem_outliers_z_scor_1)
qqnorm(residuals(modelo_moderada_sem_outliers_z_scor_1)); qqline(residuals(modelo_moderada_sem_outliers_z_scor_1)) #plota a distribuição dos resíduos



# Modelo com distribuição Gamma
modelo_moderada_sem_outliers_z_scor_2 <- glmer(Moderada_IPAQ_10 ~ Semana + (1 | ID), data = dados_sem_outliers_z_score, family = Gamma(link="identity"), na.action = na.exclude)
AIC_modelo_moderada_sem_outliers_z_scor_2 <- AIC(modelo_moderada_sem_outliers_z_scor_2)
BIC(modelo_moderada_sem_outliers_z_scor_2)
qqnorm(residuals(modelo_moderada_sem_outliers_z_scor_2)); qqline(residuals(modelo_moderada_sem_outliers_z_scor_2))


# Agora o modelo 2 convergiu, após o processamento e limpeza ter sido feito de acordo com as recomendações, e removendo dados considerados outliers segundo o critério do z-score


# Por fim, trabalharemos com os dados de intensidade vigorosa
# Modelo com distribuição normal
modelo_vigorosa_sem_outliers_z_scor_1 <- lmer(Vigorosa_IPAQ_10 ~ Semana + (1 | ID), data = dados_sem_outliers_z_score, na.action = na.exclude)
AIC_modelo_vigorosa_sem_outliers_z_scor_1 <- AIC(modelo_vigorosa_sem_outliers_z_scor_1) #Extrai o AIC do modelo
BIC(modelo_vigorosa_sem_outliers_z_scor_1)
qqnorm(residuals(modelo_vigorosa_sem_outliers_z_scor_1)); qqline(residuals(modelo_vigorosa_sem_outliers_z_scor_1)) #plota a distribuição dos resíduos



# Modelo com distribuição Gamma
modelo_vigorosa_sem_outliers_z_scor_2 <- glmer(Vigorosa_IPAQ_10 ~ Semana + (1 | ID), data = dados_sem_outliers_z_score, family = Gamma(link="identity"), na.action = na.exclude)
AIC_modelo_vigorosa_sem_outliers_z_scor_2 <- AIC(modelo_vigorosa_sem_outliers_z_scor_2)
qqnorm(residuals(modelo_vigorosa_sem_outliers_z_scor_2)); qqline(residuals(modelo_vigorosa_sem_outliers_z_scor_2))

# Modelo 2 não convergiu mesmo com a remoção dos outliers pelo processamento recomendado do IPAQ e pelo critério do z-score


# Agora, vamos salvar os resíduos e o predito para cada modelo, para posteriormente fazermos gráficos para analisar melhor qual modelo aderiu melhor à cada VD. 
dados_sem_outliers_z_score$Predito_cam__SO_1 <- predict(modelo_caminhada_sem_outliers_z_scor_1)
dados_sem_outliers_z_score$Residuo_cam__SO_1 <- residuals(modelo_caminhada_sem_outliers_z_scor_1)
dados_sem_outliers_z_score$Predito_mod__SO_1 <- predict(modelo_moderada_sem_outliers_z_scor_1)
dados_sem_outliers_z_score$Residuo_mod_SO_1 <- residuals(modelo_moderada_sem_outliers_z_scor_1)
dados_sem_outliers_z_score$Predito_mod__SO_2 <- predict(modelo_moderada_sem_outliers_z_scor_2)
dados_sem_outliers_z_score$Residuo_mod_SO_2 <- residuals(modelo_moderada_sem_outliers_z_scor_2)
dados_sem_outliers_z_score$Predito_vig_SO_1 <- predict(modelo_vigorosa_sem_outliers_z_scor_1)
dados_sem_outliers_z_score$Residuo_vig_SO_1 <- residuals(modelo_vigorosa_sem_outliers_z_scor_1)


# Agora vamos salvar esses dados para podermos analisar os resíduos graficamente em Python
write_xlsx(dados_sem_outliers_z_score,"D:/Projeto_mestrado/Dissertacao/MastersDissertation/Modelos mistos/dados__sem_outliers_z_score_com_residuos.xlsx")
