source("R/sim_results.R")



estimates_unscaled <- data.table(theta_dml, theta_nonorth, theta_orth_nosplit,
  theta_dml_nocf, theta_nonorth_nosplit,
  theta_dml_underfit, theta_dml_overfit,
  theta_nonorth_underfit, theta_nonorth_nosplit_underfit, theta_nonorth_nosplit_overfit,
  theta_nonorth_overfit,
  theta_nonorth_nosplit_overfit,
  theta_dml_nosplit_overfit,
  theta_dml_nosplit_underfit,
  se_dml, se_nonorth, se_orth_nosplit,
  se_dml_nocf, se_nonorth_nosplit,
  se_dml_underfit, se_dml_overfit,
  se_nonorth_underfit, se_nonorth_nosplit_underfit,
  se_nonorth_overfit,
  se_nonorth_nosplit_overfit,
  se_dml_nosplit_overfit,
  se_dml_nosplit_underfit,
  alpha = 0.5
)


estimates_scaled <- estimates_unscaled[
  ,
  list(
    theta_dml = (theta_dml - alpha) / se_dml,
    theta_nonorth = (theta_nonorth - alpha) / se_nonorth,
    theta_orth_nosplit = (theta_orth_nosplit - alpha) / se_orth_nosplit,
    theta_dml_nocf = (theta_dml_nocf - alpha) / se_dml_nocf,
    theta_nonorth_nosplit = (theta_nonorth_nosplit - alpha) / se_nonorth_nosplit,
    theta_dml_underfit = (theta_dml_underfit - alpha) / se_dml_underfit,
    theta_dml_overfit = (theta_dml_overfit - alpha) / se_dml_overfit,
    theta_nonorth_underfit = (theta_nonorth_underfit - alpha) / se_nonorth_underfit,
    theta_nonorth_nosplit_underfit = (theta_nonorth_nosplit_underfit - alpha) / se_nonorth_nosplit_underfit,
    theta_nonorth_overfit = (theta_nonorth_overfit - alpha) / se_nonorth_overfit,
    theta_nonorth_nosplit_overfit = (theta_nonorth_nosplit_overfit - alpha) / se_nonorth_nosplit_overfit,
    theta_dml_nosplit_overfit = (theta_dml_nosplit_overfit - alpha) / se_dml_nosplit_overfit,
    theta_dml_nosplit_underfit = (theta_dml_nosplit_underfit - alpha) / se_dml_nosplit_underfit
  ),
]

estimates_scaled <- melt(estimates_scaled,
  variable.name = c("estimation"),
  value.name = c("coef"),
  measure.vars = names(estimates_scaled)
)

# Labels for plot
estimates_scaled[
  estimation == "theta_dml",
  label := "DoubleML with cross-fitting"
]
estimates_scaled[
  estimation == "theta_nonorth",
  label := "Non-orthogonal ML with sample splitting"
]
estimates_scaled[
  estimation == "theta_orth_nosplit",
  label := "Double ML (no sample splitting)"
]
estimates_scaled[
  estimation == "theta_dml_nocf",
  label := "DoubleML without cross-fitting"
]
estimates_scaled[
  estimation == "theta_nonorth_nosplit",
  label := "Non-orthogonal ML (no sample splitting)"
]
estimates_scaled[
  estimation == "theta_dml_underfit",
  label := "DoubleML with underfitting learner and cross-fitting"
]
estimates_scaled[
  estimation == "theta_dml_overfit",
  label := "DoubleML with overfitting learner and cross-fitting"
]
estimates_scaled[
  estimation == "theta_nonorth_underfit",
  label := "Non-orthogonal ML with underfitting learner with sample splitting"
]
estimates_scaled[
  estimation == "theta_nonorth_nosplit_underfit",
  label := "Non-orthogonal ML with underfitting learner (no sample splitting)"
]
estimates_scaled[
  estimation == "theta_nonorth_overfit",
  label := "Non-orthogonal ML with overfitting learner with sample splitting"
]
estimates_scaled[
  estimation == "theta_nonorth_nosplit_overfit",
  label := "Non-orthogonal ML with overfitting learner (no sample splitting)"
]
estimates_scaled[
  estimation == "theta_dml_nosplit_overfit",
  label := "Double ML with overfitting learner (no sample splitting)"
]
estimates_scaled[
  estimation == "theta_dml_nosplit_underfit",
  label := "Double ML with underfitting learner (no sample splitting)"
]

fwrite(estimates_scaled, file = "data/basics_scaled.csv")

estimates_unscaled <- estimates_unscaled[
  ,
  list(
    theta_dml = theta_dml - alpha,
    theta_nonorth = theta_nonorth - alpha,
    theta_orth_nosplit = theta_orth_nosplit - alpha,
    theta_dml_nocf = theta_dml_nocf - alpha,
    theta_nonorth_nosplit = theta_nonorth_nosplit - alpha,
    theta_dml_underfit = theta_dml_underfit - alpha,
    theta_dml_overfit = theta_dml_overfit - alpha,
    theta_nonorth_underfit = theta_nonorth_underfit - alpha,
    theta_nonorth_nosplit_underfit = theta_nonorth_nosplit_underfit - alpha,
    theta_nonorth_overfit = theta_nonorth_overfit - alpha,
    theta_dml_nosplit_overfit = theta_dml_nosplit_overfit - alpha,
    theta_dml_nosplit_underfit = theta_dml_nosplit_underfit - alpha
  ),
]

estimates_unscaled <- melt(estimates_unscaled,
  variable.name = c("estimation"),
  value.name = c("coef"),
  measure.vars = names(estimates_unscaled)
)

# Labels for plot
estimates_unscaled[
  estimation == "theta_dml",
  label := "DoubleML with cross-fitting"
]
estimates_unscaled[
  estimation == "theta_nonorth",
  label := "Non-orthogonal ML with sample splitting"
]
estimates_unscaled[
  estimation == "theta_orth_nosplit",
  label := "Double ML (no sample splitting)"
]
estimates_unscaled[
  estimation == "theta_dml_nocf",
  label := "DoubleML without cross-fitting"
]
estimates_unscaled[
  estimation == "theta_nonorth_nosplit",
  label := "Non-orthogonal ML (no sample splitting)"
]
estimates_unscaled[
  estimation == "theta_dml_underfit",
  label := "DoubleML with underfitting learner and cross-fitting"
]
estimates_unscaled[
  estimation == "theta_dml_overfit",
  label := "DoubleML with overfitting learner and cross-fitting"
]
estimates_unscaled[
  estimation == "theta_nonorth_underfit",
  label := "Non-orthogonal ML with underfitting learner with sample splitting"
]
estimates_unscaled[
  estimation == "theta_nonorth_nosplit_underfit",
  label := "Non-orthogonal ML with underfitting learner (no sample splitting)"
]
estimates_unscaled[
  estimation == "theta_nonorth_overfit",
  label := "Non-orthogonal ML with overfitting learner with sample splitting"
]
estimates_unscaled[
  estimation == "theta_nonorth_nosplit_overfit",
  label := "Non-orthogonal ML with overfitting learner (no sample splitting)"
]
estimates_unscaled[
  estimation == "theta_dml_nosplit_overfit",
  label := "Double ML with overfitting learner (no sample splitting)"
]
estimates_unscaled[
  estimation == "theta_dml_nosplit_underfit",
  label := "Double ML with underfitting learner (no sample splitting)"
]

fwrite(estimates_unscaled, file = "data/basics_unscaled.csv")
