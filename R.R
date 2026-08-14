library(meta)
library(metafor)
library(readxl)
library(dplyr)
library(metaviz)
d1<- read_excel("cold spell.xlsx", sheet = "all-cause mortality")
d1$es <- as.numeric(d1$effect)
d1$uci <- as.numeric(d1$uci)
d1$lci <- as.numeric(d1$lci)
d1$logRR <- log(d1$es)
d1$SE_logRR <- (log(d1$uci) - log(d1$lci)) / (2 * 1.96)

dat <- escalc(measure="GEN", yi=logRR, sei=SE_logRR, data=d1)
dat <- dat[order(-dat$yi), ]
res <- rma.mv(
  yi,
  V = vi,
  random = ~ 1 | Study/ID,                   
  data = dat,
  method = "REML"
)
forest(res, atransf=exp,digits = 3)  
res

tau2_level1 <- res$sigma2[1]
tau2_level2 <- res$sigma2[2]


W <- diag(1/res$vi) 

X <- model.matrix(res)

P <- W - W %*% X %*% solve(t(X) %*% W %*% X) %*% t(X) %*% W

vt <- (res$k - res$p) / sum(diag(P))

I2_total <- 100 * sum(res$sigma2) / (sum(res$sigma2) + vt)

I2_Study <- 100 * res$sigma2[1] / (sum(res$sigma2) + vt) 
I2_ID    <- 100 * res$sigma2[2] / (sum(res$sigma2) + vt) 

list(I2_Total = I2_total, I2_Between_Study = I2_Study, I2_Within_Study = I2_ID)

reg_test <- rma.mv(
  yi = yi,
  V = vi,
  mods = ~ SE_logRR, 
  random = ~ 1 | Study/ID,
  data = dat,
  
)
print(reg_test) 

funnel(res, level=c(90, 95, 99), shade=c("white", "gray55", "gray75"), refline=0, legend=FALSE)

res_simple <- rma(yi, vi, data = dat, method = "REML")

tf_res <- trimfill(res_simple)

print(tf_res)

funnel(tf_res, legend = FALSE, main = "Trim-and-Fill Funnel Plot")
forest(tf_res, atransf=exp,digits = 3) 


d1<- read_excel("cold spell.xlsx", sheet = "all-cause mortality")
d1$es <- as.numeric(d1$effect)
d1$uci <- as.numeric(d1$uci)
d1$lci <- as.numeric(d1$lci)
d1$logRR <- log(d1$es)
d1$SE_logRR <- (log(d1$uci) - log(d1$lci)) / (2 * 1.96)


dat <- escalc(measure="GEN", yi=logRR, sei=SE_logRR, data=d1)

res <- rma.mv(
  yi,
  V = vi,
  mods = ~ ClimateZone+ IncomeGroup+ Lagmid +LagTape, 
  random = ~ 1 | Study/ID,                  
  data = dat,
  method = "REML"
)
summary(res, transf = exp)


