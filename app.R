library(shiny)
library(readxl)

# Carregue os dados e crie o modelo uma vez só (ao iniciar o app)
dados <- read_excel("dataset_KC1_classlevel_numdefect.xlsx")
modelo <- lm(NUMDEFECTS ~ sumLOC_TOTAL, data = dados)

ui <- fluidPage(
  titlePanel("Previsão de Defeitos de Software"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("loc", "Total de Linhas de Código (sumLOC_TOTAL):", value = 100, min = 0),
      actionButton("btn_predict", "Prever Defeitos")
    ),
    
    mainPanel(
      verbatimTextOutput("resultado")
    )
  )
)

server <- function(input, output, session) {
  
  previsao <- eventReactive(input$btn_predict, {
    req(input$loc)
    
    pred <- predict(modelo, newdata = data.frame(sumLOC_TOTAL = input$loc))
    paste0("Previsão de defeitos para sumLOC_TOTAL = ", input$loc, ": ", round(pred, 2))
  })
  
  output$resultado <- renderText({
    previsao()
  })
  
}

shinyApp(ui, server)
