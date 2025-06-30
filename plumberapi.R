library(plumber)
library(readxl)

# Carrega os dados
dados <- read_excel("/Users/luisgustavobrito/Downloads/dataset_KC1_classlevel_numdefect.xlsx")

# Cria o modelo
modelo <- lm(NUMDEFECTS ~ sumLOC_TOTAL, data = dados)

# Cria API
pr <- Plumber$new()

pr$handle("GET", "/predict", function(sumLOC_TOTAL) {
  sumLOC_TOTAL_num <- as.numeric(sumLOC_TOTAL)
  
  if (is.na(sumLOC_TOTAL_num)) {
    return(list(error = "sumLOC_TOTAL deve ser numérico."))
  }
  
  previsao <- predict(modelo, newdata = data.frame(sumLOC_TOTAL = sumLOC_TOTAL_num))
  list(NUMDEFECTS_Previsto = round(as.numeric(previsao), 2))
})

pr$run(port = 8000)

