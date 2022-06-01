# Loading the required packages ####
packages <- c(
  "shiny", "ggplot2", "EnvStats", "shinyWidgets", "shinydashboard",
  "latex2exp", "dplyr", "plotly", "MASS", "mvtnorm",
  "data.table", "RColorBrewer"
)
# installing new packages
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())))
}
# load and attach packages
if (length(setdiff(packages, names(sessionInfo()$otherPkgs))) > 0) {
  lapply(setdiff(packages, names(sessionInfo()$otherPkgs)),
    require,
    character.only = TRUE
  )
}

# defining certain colors and methods ####
dashboard_skin <- "black"
loading_method <- "cube-grid"
loading_color <- "#2980B9"
slider_color <- "#E74C3C"
slider_skin <- "Modern"
PAGE_TITLE <- "Approximation"

linecol1 <- "black"
linecol2 <- "Forestgreen"
linecol3 <- "blue"
linecol4 <- "red"

boxcol_1 <- "danger"
boxcol_2 <- "primary"

# logo ####
dbHeader <- dashboardHeader()
dbHeader$children[[2]]$children <- tags$a(
  href = "https://docs.doubleml.org",
  tags$img(src = "DoubleML_Rhino_1000x1000.png", height = "40", width = "40")
)

# define the body ####
body_col <- "/* logo */
.skin-blue .main-header .logo {
background-color: #f4b943;
}
/* logo when hovered */
.skin-blue .main-header .logo:hover {
background-color: #f4b943;
}
/* navbar (rest of the header) */
.skin-blue .main-header .navbar {
background-color: #f4b943;
}
/* main sidebar */
.skin-blue .main-sidebar {
background-color: #f4b943;
}
/* active selected tab in the sidebarmenu */
.skin-blue .main-sidebar .sidebar .sidebar-menu .active a{
background-color: #ff0000;
}
/* other links in the sidebarmenu */
.skin-blue .main-sidebar .sidebar .sidebar-menu a{
background-color: #00ff00;
color: #000000;
}
/* other links in the sidebarmenu when hovered */
.skin-blue .main-sidebar .sidebar .sidebar-menu a:hover{
background-color: #ff69b4;
}
/* toggle button when hovered  */
.skin-blue .main-header .navbar .sidebar-toggle:hover{
background-color: #ff69b4;
}
/* body */
.content-wrapper, .right-side {
background-color: #EAEDED;
}"


# Colors for plot
col_palette <- RColorBrewer::brewer.pal(11, "Spectral")
colors <- c(
  "Non-orthogonal ML with sample splitting" = col_palette[1],
  "Double ML (no sample splitting)" = col_palette[2],
  "Non-orthogonal ML (no sample splitting)" = col_palette[3],
  "DoubleML with underfitting learner and cross-fitting" = col_palette[4],
  "Non-orthogonal ML with underfitting learner with sample splitting" = col_palette[5],
  "Non-orthogonal ML with overfitting learner with sample splitting" = col_palette[6],
  "Non-orthogonal ML with underfitting learner (no sample splitting)" = col_palette[9],
  "DoubleML without cross-fitting" = col_palette[8],
  "DoubleML with cross-fitting" = col_palette[9],
  "Double ML with overfitting learner (no sample splitting)" = col_palette[10],
  "Double ML with underfitting learner (no sample splitting)" = col_palette[11]
)
