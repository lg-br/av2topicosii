library(readxl)
library(ggpubr)
library(dplyr)

# Carregar o dataset
dados <- read_excel("/Users/luisgustavobrito/Downloads/dataset_KC1_classlevel_numdefect.xlsx")

# Função para calcular moda
moda <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

# Lista de colunas numéricas
colunas <- names(dados)

# Análise para cada coluna
for (coluna in colunas) {
  cat("\n\n==========", coluna, "==========\n")
  valores <- dados[[coluna]]
  
  cat("Média:", mean(valores), "\n")
  cat("Mediana:", median(valores), "\n")
  cat("Moda:", moda(valores), "\n")
  cat("Mínimo:", min(valores), "\n")
  cat("Máximo:", max(valores), "\n")
  cat("Amplitude:", max(valores) - min(valores), "\n")
  cat("Desvio Padrão:", sd(valores), "\n")
  
  if (length(valores) < 5000) {
    cat("Teste de Normalidade (Shapiro-Wilk): p-valor =", shapiro.test(valores)$p.value, "\n")
  }
  
  # Histograma com densidade
  print(ggdensity(dados, x = coluna, fill = "skyblue", add = "mean", title = paste("Histograma:", coluna)))
  
  # Boxplot
  print(ggboxplot(dados, y = coluna, fill = "orange", title = paste("Boxplot:", coluna)))
}


