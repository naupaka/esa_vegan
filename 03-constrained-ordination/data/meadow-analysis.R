## Analyse the Meadow data Case Study 2 of Leps & Smilauer

## load vegan
library("vegan")

## load the data
spp <- read.csv("meadow-spp.csv", header = TRUE, row.names = 1)
env <- read.csv("meadow-env.csv", header = TRUE, row.names = 1)

## full model
m1 <- cca(spp ~ ., data = env)

set.seed(32)
anova(m1)

plot(m1) ## horrible arch , detrend? nope, looks like too many vars

# step
set.seed(67)
lwr <- cca(spp ~ 1, data = env)
m2 <- ordistep(lwr, scope = formula(m1), perm.max = 499)

m2

plot(m2)

m2$anova

spph <- decostand(spp, method = "hellinger")
m3 <- rda(spph ~ ., data = env)
plot(m3)
lwr <- rda(spph ~ 1, data = env)
m4 <- ordistep(lwr, scope = formula(m3), perm.max = 499)
plot(m4)

m5 <- ordiR2step(lwr, scope = formula(m3))
