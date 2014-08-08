## Process the medowfoo.csv files into nice R format

spp <- read.csv("meadowspp.csv", header = TRUE, row.names = 1)
colnames(spp) <- NULL
spp <- t(spp) ## transpose so spp in cols
## replace NA with 0
spp <- as.data.frame(apply(spp, 2, function(x){ x[is.na(x)] <- 0; x}))

## load and check the env data
env <- read.csv("meadowenv.csv", header = TRUE, row.names = 1)
## ok

## write out the spp & env files
write.csv(spp, file = "meadow-spp.csv", row.names = TRUE)
write.csv(env, file = "meadow-env.csv", row.names = TRUE)
