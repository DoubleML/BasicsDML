# Shiny App for visualization

# Loading the required colors and packages from the R subdirectory ####
source("R/Packages_Colors.R")

# Estimation results saved in the next
source("R/basics_estimation.R")

dashboardPage(
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
    chooseSliderSkin(slider_skin, color = slider_color),
    # Boxes need to be put in a row (or column)
    tabItems(
      tabItem(
        tabName = "basics",
        h2("Key Ingredients of Double Machine Learning"),
        p("Simulated data example based on Chernozhukov et al. (2018)"),
        fluidRow(
          box(
            title = "Key Ingredients of DoubleML",
            checkboxInput(
              inputId = "orth",
              label = "Orthogonal Score",
              value = FALSE
            ),
            checkboxInput(
              inputId = "samplesplit",
              label = "Sample Splitting",
              value = FALSE
            ),
            selectInput(
              inputId = "hq",
              label = "High Quality ML",
              choices = c("Tuned", "Underfitting", "Overfitting"),
              selected = c("Underfitting")
            ),
            width = 3
          ),
          box(plotOutput("dens_ingrds", height = 450), widht = 9)
        ),
        h2("The Use of Cross-Fitting"),
        p("Simulated data example based on Chernozhukov et al. (2018)"),
        fluidRow(
          box(
            title = "Cross-fitting and DoubleML",
            checkboxInput(
              inputId = "crossfit",
              label = "Cross-fitting",
              value = FALSE
            ),
            width = 3
          ),
          box(plotOutput("dens_cf", height = 450), widht = 9)
        )
      )
    )
  )
)
