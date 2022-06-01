#Shiny App for visualization 

#Loading the required colors and packages from the R subdirectory ####
rm(list=ls())
source("R/Packages_Colors.R")

# Estimation results saved in the next 
source("R/basics_estimation.R")

ui = dashboardPage(
  title = "Key Ingredients of Double Machine Learning",
  skin = dashboard_skin,
  dbHeader,
  dashboardSidebar(
    sidebarMenu(
      menuItem("Basics of Double Machine Learning", tabName = "basics")
    )
  ),
  dashboardBody(
    tags$head(tags$style(HTML(body_col))),
    withMathJax(),
    chooseSliderSkin(slider_skin,color = slider_color),
    # Boxes need to be put in a row (or column)
    tabItems(
      tabItem(tabName = "basics",
              h2("Key Ingredients of Double Machine Learning"),
              p("Simulated data example based on Chernozhukov et al. (2018)"),
              fluidRow(
                box(
                  title = "Key Ingredients of DoubleML",
                  checkboxInput(inputId = "orth", 
                                label = "Orthogonal Score",
                                value = FALSE),
                  checkboxInput(inputId = "samplesplit", 
                                label = "Sample Splitting",
                                value = FALSE),
                  selectInput(inputId = "hq", 
                              label = "High Quality ML",
                              choices = c("Tuned", "Underfitting", "Overfitting"),
                              selected = c("Underfitting")),
                  width = 3
                ),
                
                box(plotOutput("dens_ingrds", height = 450), widht = 9)
                
              ),
              h2("The Use of Cross-Fitting"),
              p("Simulated data example based on Chernozhukov et al. (2018)"),
              fluidRow(
                box(
                  title = "Cross-fitting and DoubleML",
                  checkboxInput(inputId = "crossfit", 
                                label = "Cross-fitting",
                                value = FALSE),
                  width = 3
                ),
                
                box(plotOutput("dens_cf", height = 450), widht = 9)
                
              )
      )
    )
  )
)

server = function(input, output) {
  
  output$dens_ingrds <- renderPlot({
    if (input$orth) {
      if (input$samplesplit) {
        if (input$hq == "Tuned") {
          est_selection = c("theta_dml")
        } else if (input$hq == "Underfitting") {
          est_selection = c("theta_dml_underfit")
        } else if (input$hq == "Overfitting") {
          est_selection = c("theta_dml_overfit")
        }
      } else {
        if (input$hq == "Tuned") {
          est_selection = c("theta_orth_nosplit")
        } else if (input$hq == "Underfitting") {
          est_selection = c("theta_dml_nosplit_underfit")
        } else if (input$hq == "Overfitting") {
          est_selection = c("theta_dml_nosplit_overfit")
        }
      }
    } else {
      if (input$samplesplit) {
        if (input$hq == "Tuned") {
          est_selection = c("theta_nonorth")
        } else if (input$hq == "Underfitting") {
          est_selection = c("theta_nonorth_underfit")
        } else if (input$hq == "Overfitting") {
          est_selection = c("theta_nonorth_overfit")
        }
      } else {
        if (input$hq == "Tuned") {
          est_selection = c("theta_nonorth_nosplit")
        } else if (input$hq == "Underfitting") {
          est_selection = c("theta_nonorth_nosplit_underfit")
        } else if (input$hq == "Overfitting") {
          est_selection = c("theta_nonorth_nosplit_overfit")
        }
      }
    }
    
    data = estimates_scaled[estimation == est_selection, ]
    
    g_dens = ggplot(data) +
      geom_histogram(aes(y=..density.., x=coef, fill = label,
                         col = label),
                     bins = 30, alpha = 0.6) +
      geom_vline(aes(xintercept = 0), col = "black") +
      suppressWarnings(geom_function(fun = dnorm, colour = "darkgrey")) +
      scale_color_manual(name = '',
                         values =  colors) +
      scale_fill_manual(name = '',
                        values = colors) +
      xlim(c(-6.0, 6.0)) + xlab("") + ylab("") + theme_minimal() + 
      theme(legend.position="none")
    
    g_dens
  })
  
  output$dens_cf <- renderPlot({
    if (!input$crossfit) {
      est_selection = c("theta_dml_nocf")
    } else {
      est_selection = c("theta_dml")
    }
    
    data = estimates_unscaled[estimation == est_selection, ]
    
    g_dens_unscaled = ggplot(data) +
      geom_histogram(aes(y=..density.., x=coef, fill = label,
                         col = label),
                     bins = 30, alpha = 0.9) +
      geom_vline(aes(xintercept = 0), col = "black") +
      # suppressWarnings(geom_function(fun = dnorm, colour = "darkgrey")) +
      scale_color_manual(name = '',
                         values =  colors) +
      scale_fill_manual(name = '',
                        values = colors) +
      xlim(c(-0.25, 0.25)) + ylim(c(0,9)) + xlab("") + ylab("") + theme_minimal() +
      theme(legend.position="none")
    
    g_dens_unscaled
    
  })
}

shinyApp(ui, server)

