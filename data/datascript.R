set.seed(123)

data <- mice::boys
meth <- mice::make.method(data)
meth["bmi"] <- "~I(wgt/(hgt/100)^2)"
predmat <- mice::make.predictorMatrix(data)
predmat[c("hgt", "wgt"), "bmi"] <- 0

imp <- mice::mice(
  data,
  method = meth,
  predictorMatrix = predmat,
  maxit = 20,
  m = 1
)

data <- mice::complete(imp)

saveRDS(data, "data/boys.RDS")
