## Process the ohraz-env.csv file into nice R format

env <- read.csv("ohraz-env-raw.csv", row.names = 1)

## nicer factor labels
env <- transform(env,
                 MOWING = factor(MOWING, labels = c("No","Yes")),
                 FERTIL = factor(FERTIL, labels = c("No","Yes")),
                 REMOV = factor(REMOV, labels = c("No","Yes")),
                 YEAR = factor(YEAR, labels = 1994:1997))

## keep some years
want <- c("MOWING", "FERTIL", "REMOV", "YEAR")
env <- env[, want]

## update the names
names(env) <- c("mowing", "fertilizer", "removal", "year")

## 24 plots, 1, 2, 3, ... repeated over again to number of rows
## create a nice factor for these
env <- transform(env,
                 plotid = factor(rep(sprintf("%02d", 1:24),
                 length = nrow(env))))

## write out the file
write.csv(env, file = "ohraz-env.csv", row.names = TRUE)
