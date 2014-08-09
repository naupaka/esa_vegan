# Community data analysis using the vegan package in R
Naupaka Zimmerman and Gavin Simpson  
August 9, 2014 • ESA 2014  



<!----------------------------slide boundary--------------------------------->
## Workshop logistics

* Etherpad [[link here]]
* Red and Green Stickies

<!----------------------------slide boundary--------------------------------->
## Packages installed?


```r
install.packages("vegan", dependencies = TRUE)
install.packages("plyr")
install.packages("reshape2")
```

<!----------------------------slide boundary--------------------------------->
## Introduction to **vegan**

* What is it?
* Who developed it?
* How does it differ from other alternatives?

<!----------------------------slide boundary--------------------------------->
## Digging in | Prepping your data for R and vegan

### “The purpose of computing is insight, not numbers” 
### - Richard Hamming 

<!----------------------------slide boundary--------------------------------->
## Digging in | Prepping your data for R and vegan

We've all heard data horror stories
![](img/otherpeoplesdata.png)

<!----------------------------slide boundary--------------------------------->
## Cleaning your data for import into R for use in vegan

* Spreadsheet example

<!----------------------------slide boundary--------------------------------->
## Cleaning your data for import into R for use in vegan

* We will use built-in datasets for species `varespec` and environmental variables `varechem`
    * from: Väre, H., Ohtonen, R. and Oksanen, J. (1995)


```r
library("vegan")
data(varespec)
data(varechem)
```

<!----------------------------slide boundary--------------------------------->
## Cleaning your data for import into R for use in vegan

* We will use built-in datasets for species `varespec` and environmental variables `varechem`
    * from: Väre, H., Ohtonen, R. and Oksanen, J. (1995)


```r
library("vegan")
data(varespec)
data(varechem)
```


```r
head(varespec[,1:8], n = 3)
```

```
   Cal.vul Emp.nig Led.pal Vac.myr Vac.vit Pin.syl Des.fle Bet.pub
18    0.55   11.13       0    0.00   17.80    0.07       0       0
15    0.67    0.17       0    0.35   12.13    0.12       0       0
24    0.10    1.55       0    0.00   13.47    0.25       0       0
```

<!----------------------------slide boundary--------------------------------->
## Summarizing data with `apply()` | sums and sorting

**Sum of rows**

```r
sum.of.rows <- apply(varespec, 1, sum)
sort(sum.of.rows, decreasing = TRUE)[1:8] #top 8 rows (sites) 
```

```
   27     9    10    12     2    11     6    28 
125.6 122.6 122.4 119.8 119.1 112.8 110.9 110.7 
```

<!----------------------------slide boundary--------------------------------->
## Summarizing data with `apply()` | sums and sorting

**Sum of rows**

```r
sum.of.rows <- apply(varespec, 1, sum)
sort(sum.of.rows, decreasing = TRUE)[1:8] #top 8 rows (sites) 
```

```
   27     9    10    12     2    11     6    28 
125.6 122.6 122.4 119.8 119.1 112.8 110.9 110.7 
```
**Sum of columns**

```r
sum.of.columns <- apply(varespec, 2, sum)
sort(sum.of.columns, decreasing = TRUE)[1:8] #top 8 columns (species)
```

```
Cla.ste Cla.ran Ple.sch Vac.vit Cla.arb Emp.nig Dic.fus Cla.unc 
 486.71  388.71  377.97  275.03  255.05  151.99  113.52   56.28 
```

<!----------------------------slide boundary--------------------------------->
## Summarizing data with `apply()` | sums and sorting

**Number of plots in which each spp. occurs**

```r
spec.pres <- apply(varespec > 0, 2, sum) 
sort(spec.pres, decreasing = TRUE)[1:18]
```

```
Emp.nig Vac.vit Ple.sch Cla.arb Cla.ran Cla.unc Cla.cor Cla.cri Dic.fus 
     24      24      24      24      24      24      24      24      23 
Cla.gra Cla.def Cla.ste Cla.fim Pin.syl Pol.jun Poh.nut Cla.coc Pti.cil 
     23      23      22      22      21      20      20      19      17 
```

<!----------------------------slide boundary--------------------------------->
## Basic data transformation

**Square root transformation**

```r
head(varespec[,1:8], n = 3)
```

```
   Cal.vul Emp.nig Led.pal Vac.myr Vac.vit Pin.syl Des.fle Bet.pub
18    0.55   11.13       0    0.00   17.80    0.07       0       0
15    0.67    0.17       0    0.35   12.13    0.12       0       0
24    0.10    1.55       0    0.00   13.47    0.25       0       0
```

<!----------------------------slide boundary--------------------------------->
## Basic data transformation

**Square root transformation**

```r
head(varespec[,1:8], n = 3)
```

```
   Cal.vul Emp.nig Led.pal Vac.myr Vac.vit Pin.syl Des.fle Bet.pub
18    0.55   11.13       0    0.00   17.80    0.07       0       0
15    0.67    0.17       0    0.35   12.13    0.12       0       0
24    0.10    1.55       0    0.00   13.47    0.25       0       0
```

```r
spec.sqrt <- sqrt(varespec)
head(spec.sqrt[,1:8], n = 3)
```

```
   Cal.vul Emp.nig Led.pal Vac.myr Vac.vit Pin.syl Des.fle Bet.pub
18  0.7416  3.3362       0  0.0000   4.219  0.2646       0       0
15  0.8185  0.4123       0  0.5916   3.483  0.3464       0       0
24  0.3162  1.2450       0  0.0000   3.670  0.5000       0       0
```

<!----------------------------slide boundary--------------------------------->
## Data transformation with `decostand()`

**Total**

```r
head(varespec[,1:8], n = 3)
```

```
   Cal.vul Emp.nig Led.pal Vac.myr Vac.vit Pin.syl Des.fle Bet.pub
18    0.55   11.13       0    0.00   17.80    0.07       0       0
15    0.67    0.17       0    0.35   12.13    0.12       0       0
24    0.10    1.55       0    0.00   13.47    0.25       0       0
```

<!----------------------------slide boundary--------------------------------->
## Data transformation with `decostand()`

**Total**

```r
head(varespec[,1:8], n = 3)
```

```
   Cal.vul Emp.nig Led.pal Vac.myr Vac.vit Pin.syl Des.fle Bet.pub
18    0.55   11.13       0    0.00   17.80    0.07       0       0
15    0.67    0.17       0    0.35   12.13    0.12       0       0
24    0.10    1.55       0    0.00   13.47    0.25       0       0
```

```r
spec.total <- decostand(varespec, method = "total", MARGIN = 1) # by rows (sites)
head(spec.total[,1:8], n = 3)
```

```
    Cal.vul  Emp.nig Led.pal  Vac.myr Vac.vit   Pin.syl Des.fle Bet.pub
18 0.006166 0.124776       0 0.000000  0.1996 0.0007848       0       0
15 0.007459 0.001893       0 0.003897  0.1350 0.0013360       0       0
24 0.001061 0.016453       0 0.000000  0.1430 0.0026536       0       0
```

<!----------------------------slide boundary--------------------------------->
## Data transformation with `decostand()`

**Maximum**

```r
head(varespec[,1:8], n = 3)
```

```
   Cal.vul Emp.nig Led.pal Vac.myr Vac.vit Pin.syl Des.fle Bet.pub
18    0.55   11.13       0    0.00   17.80    0.07       0       0
15    0.67    0.17       0    0.35   12.13    0.12       0       0
24    0.10    1.55       0    0.00   13.47    0.25       0       0
```

<!----------------------------slide boundary--------------------------------->
## Data transformation with `decostand()`

**Maximum** 

```r
head(varespec[,1:8], n = 3)
```

```
   Cal.vul Emp.nig Led.pal Vac.myr Vac.vit Pin.syl Des.fle Bet.pub
18    0.55   11.13       0    0.00   17.80    0.07       0       0
15    0.67    0.17       0    0.35   12.13    0.12       0       0
24    0.10    1.55       0    0.00   13.47    0.25       0       0
```

```r
spec.max <- decostand(varespec, method = "max", MARGIN = 2) # by columns (species)
head(spec.max[,1:8], n = 3)
```

```
    Cal.vul Emp.nig Led.pal Vac.myr Vac.vit Pin.syl Des.fle Bet.pub
18 0.022793 0.69563       0 0.00000  0.7120 0.05833       0       0
15 0.027766 0.01063       0 0.01916  0.4852 0.10000       0       0
24 0.004144 0.09688       0 0.00000  0.5388 0.20833       0       0
```

<!----------------------------slide boundary--------------------------------->
## Data transformation with `decostand()`

**Presence-Absence**

```r
head(varespec[,1:8], n = 3)
```

```
   Cal.vul Emp.nig Led.pal Vac.myr Vac.vit Pin.syl Des.fle Bet.pub
18    0.55   11.13       0    0.00   17.80    0.07       0       0
15    0.67    0.17       0    0.35   12.13    0.12       0       0
24    0.10    1.55       0    0.00   13.47    0.25       0       0
```

<!----------------------------slide boundary--------------------------------->
## Data transformation with `decostand()`

**Presence-Absence**

```r
head(varespec[,1:8], n = 3)
```

```
   Cal.vul Emp.nig Led.pal Vac.myr Vac.vit Pin.syl Des.fle Bet.pub
18    0.55   11.13       0    0.00   17.80    0.07       0       0
15    0.67    0.17       0    0.35   12.13    0.12       0       0
24    0.10    1.55       0    0.00   13.47    0.25       0       0
```

```r
spec.pa <- decostand(varespec, method = "pa")
head(spec.pa[,1:8], n = 3)
```

```
   Cal.vul Emp.nig Led.pal Vac.myr Vac.vit Pin.syl Des.fle Bet.pub
18       1       1       0       0       1       1       0       0
15       1       1       0       1       1       1       0       0
24       1       1       0       0       1       1       0       0
```

<!----------------------------slide boundary--------------------------------->
## Data transformation with `decostand()`

**Hellinger (Legendre & Gallagher 2001)**
Square root of method "total"

```r
head(varespec[,1:8], n = 3)
```

```
   Cal.vul Emp.nig Led.pal Vac.myr Vac.vit Pin.syl Des.fle Bet.pub
18    0.55   11.13       0    0.00   17.80    0.07       0       0
15    0.67    0.17       0    0.35   12.13    0.12       0       0
24    0.10    1.55       0    0.00   13.47    0.25       0       0
```

<!----------------------------slide boundary--------------------------------->
## Data transformation with `decostand()`

**Hellinger (Legendre & Gallagher 2001)**
Square root of method "total"

```r
head(varespec[,1:8], n = 3)
```

```
   Cal.vul Emp.nig Led.pal Vac.myr Vac.vit Pin.syl Des.fle Bet.pub
18    0.55   11.13       0    0.00   17.80    0.07       0       0
15    0.67    0.17       0    0.35   12.13    0.12       0       0
24    0.10    1.55       0    0.00   13.47    0.25       0       0
```

```r
spec.hellinger <- decostand(varespec, method = "hellinger", MARGIN = 1) # on rows (sites)
head(spec.hellinger[,1:8], n = 3)
```

```
   Cal.vul Emp.nig Led.pal Vac.myr Vac.vit Pin.syl Des.fle Bet.pub
18 0.07852  0.3532       0 0.00000  0.4467 0.02801       0       0
15 0.08637  0.0435       0 0.06242  0.3675 0.03655       0       0
24 0.03258  0.1283       0 0.00000  0.3781 0.05151       0       0
```

<!----------------------------slide boundary--------------------------------->
## Data transformation with `decostand()`

**Wisconsin double standardization**  
Species standardized to maximum, then sites by totals.  

```r
head(varespec[,1:8], n = 3)
```

```
   Cal.vul Emp.nig Led.pal Vac.myr Vac.vit Pin.syl Des.fle Bet.pub
18    0.55   11.13       0    0.00   17.80    0.07       0       0
15    0.67    0.17       0    0.35   12.13    0.12       0       0
24    0.10    1.55       0    0.00   13.47    0.25       0       0
```

<!----------------------------slide boundary--------------------------------->
## Data transformation with `decostand()`

**Wisconsin double standardization**  
Species standardized to maximum, then sites by totals.

```r
head(varespec[,1:8], n = 3)
```

```
   Cal.vul Emp.nig Led.pal Vac.myr Vac.vit Pin.syl Des.fle Bet.pub
18    0.55   11.13       0    0.00   17.80    0.07       0       0
15    0.67    0.17       0    0.35   12.13    0.12       0       0
24    0.10    1.55       0    0.00   13.47    0.25       0       0
```

```r
spec.wisc <- wisconsin(varespec)
head(spec.wisc[,1:8], n = 3)
```

```
     Cal.vul  Emp.nig Led.pal  Vac.myr Vac.vit Pin.syl Des.fle Bet.pub
18 0.0027900 0.085149       0 0.000000 0.08715 0.00714       0       0
15 0.0047127 0.001803       0 0.003251 0.08235 0.01697       0       0
24 0.0005565 0.013008       0 0.000000 0.07235 0.02797       0       0
```

<!----------------------------slide boundary--------------------------------->
## Types of distance metrics | and why you might want to use one instead of another

* Presence/absence
* Abundance based
* Probabilistic

## Calculating community distances with `vegdist()` | so many distance metrics, so little time!

Examples: 

* Bray
* Jaccard
* Morisita
* How to choose a good one for your data set?
    * `rankindex()`

## Rarefaction

## Within vs between group similarities

* `betadisper()`

## References
