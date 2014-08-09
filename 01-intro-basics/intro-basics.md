# Community data analysis using the vegan package in R
Naupaka Zimmerman and Gavin Simpson  
August 9, 2014 • ESA 2014  



<!----------------------------slide boundary--------------------------------->
## Workshop logistics

* Etherpad 
    * https://etherpad.mozilla.org/ESA2014-vegan

<!----------------------------slide boundary--------------------------------->
## Workshop logistics

* Etherpad 
    * https://etherpad.mozilla.org/ESA2014-vegan
* Red and Green Stickies 
  
![](img/Green_post_it.png)&nbsp;&nbsp;&nbsp;&nbsp;![](img/Red_post_it.png)

<!----------------------------slide boundary--------------------------------->
## Packages installed?


```r
install.packages("vegan", dependencies = TRUE)
install.packages("BiodiversityR")
install.packages("plyr")
install.packages("reshape2")
```

<!----------------------------slide boundary--------------------------------->
## Introduction to **vegan**

* What is it?
* Who developed it?
* How does it differ from other alternatives?

<!----------------------------slide boundary--------------------------------->

# Cleaning and importing data

<!----------------------------slide boundary--------------------------------->

## Digging in | Prepping your data for R and vegan

### “The purpose of computing is insight, not numbers” 
### - Richard Hamming 

<!----------------------------slide boundary--------------------------------->

## Digging in | Prepping your data for R and vegan

### “The purpose of computing is insight, not numbers” 
### - Richard Hamming 
<br /><br /><br />
But you have to get through the numbers to get to the insight...

<!----------------------------slide boundary--------------------------------->

## Digging in | Prepping your data for R and vegan

We've all heard data horror stories
![](img/otherpeoplesdata.png)

<!----------------------------slide boundary--------------------------------->

## Cleaning your data for R and vegan

### Loading dirty data and then cleaning

```r
#setwd("your/working/directory/")
BCI.small.csv.in <- read.csv("data/BCI_small_fixed.csv", header = TRUE, row.names = 1)
```

<!----------------------------slide boundary--------------------------------->

## Cleaning your data for R and vegan

Then...  

```r
head(BCI.small.csv.in, n=3)
```

```
  Abarema.macradenium Acacia.melanoceras Acalypha.diversifolia
1                   0                  1                     0
2                   1                  0                     0
3                   0                  0                     0
  Acalypha.macrostachya Adelia.triloba
1                     0              0
2                     0              0
3                     1              0
```

<!----------------------------slide boundary--------------------------------->

## Cleaning your data for R and vegan

Then...  

```r
summary(BCI.small.csv.in)
```

```
 Abarema.macradenium Acacia.melanoceras Acalypha.diversifolia
 Min.   :0.0         Min.   :0.00       Min.   :0.0          
 1st Qu.:0.0         1st Qu.:0.00       1st Qu.:0.0          
 Median :0.0         Median :0.00       Median :0.0          
 Mean   :0.3         Mean   :0.25       Mean   :0.3          
 3rd Qu.:0.0         3rd Qu.:0.25       3rd Qu.:0.0          
 Max.   :2.0         Max.   :1.00       Max.   :3.0          
 Acalypha.macrostachya Adelia.triloba
 Min.   :0.00          Min.   :0.0   
 1st Qu.:0.00          1st Qu.:0.0   
 Median :0.00          Median :0.0   
 Mean   :0.05          Mean   :0.8   
 3rd Qu.:0.00          3rd Qu.:1.0   
 Max.   :1.00          Max.   :5.0   
```

<!----------------------------slide boundary--------------------------------->

## Cleaning your data for R and vegan

* We will use some of vegan's built-in datasets for species `varespec` and environmental variables `varechem`
    * from Väre, H., Ohtonen, R. and Oksanen, J. (1995)


```r
library("vegan")
data(varespec)
data(varechem)
```

<!----------------------------slide boundary--------------------------------->

## Cleaning your data for R and vegan

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

# Basic data summarizing

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

# Data Transformation

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

## Data transformation in vegan with `decostand()`

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

## Data transformation in vegan with `decostand()`

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

## Data transformation in vegan with `decostand()`

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

## Data transformation in vegan with `decostand()`

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

## Data transformation in vegan with `decostand()`

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

## Data transformation in vegan with `decostand()`

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

## Data transformation in vegan with `decostand()`

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

## Data transformation in vegan with `decostand()`

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

## Data transformation in vegan with `decostand()`

**Wisconsin double standardization**  
Shortcut function for standardizing species to maximum, then sites by totals.  

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

## Data transformation in vegan with `decostand()`

**Wisconsin double standardization**  
Shortcut function for standardizing species to maximum, then sites by totals.

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

# Calculating community distances

<!----------------------------slide boundary--------------------------------->

## Calculating distances with `vegdist()` | so many distance metrics, so little time!

### Many different community distance metrics are available in `vegdist()`    
*manhattan, euclidean, canberra, bray, kulczynski, jaccard, gower, altGower, morisita, horn, mountford, raup, binomial, chao, or cao*

<!----------------------------slide boundary--------------------------------->

## Calculating distances with `vegdist()` | so many distance metrics, so little time!

### Many different community distance metrics are available in `vegdist()`   
*manhattan, euclidean, canberra, bray, kulczynski, jaccard, gower, altGower, morisita, horn, mountford, raup, binomial, chao, or cao*


```r
spec.jaccpa <- vegdist(varespec, method = "jaccard", binary = TRUE)
# returns an object of class 'dist'
str(spec.jaccpa) 
```

```
Class 'dist'  atomic [1:276] 0.333 0.471 0.5 0.333 0.417 ...
  ..- attr(*, "Size")= int 24
  ..- attr(*, "Labels")= chr [1:24] "18" "15" "24" "27" ...
  ..- attr(*, "Diag")= logi FALSE
  ..- attr(*, "Upper")= logi FALSE
  ..- attr(*, "method")= chr "binary jaccard"
  ..- attr(*, "call")= language vegdist(x = varespec, method = "jaccard", binary = TRUE)
```

<!----------------------------slide boundary--------------------------------->

## Calculating distances with `vegdist()` | so many distance metrics, so little time!


```r
as.matrix(spec.jaccpa)[1:4,1:4]
```

```
       18     15     24     27
18 0.0000 0.3333 0.4706 0.5000
15 0.3333 0.0000 0.2500 0.5429
24 0.4706 0.2500 0.0000 0.5882
27 0.5000 0.5429 0.5882 0.0000
```


<!----------------------------slide boundary--------------------------------->

## Calculating distances with `vegdist()` | so many distance metrics, so little time!

### How to choose a good one for your data set?  
### First step, read the help for vegdist

```r
?vegdist
```

<!----------------------------slide boundary--------------------------------->

## Calculating distances with `vegdist()` | so many distance metrics, so little time!

### Second, try `rankindex()`    
Higher rank correlations indicate better separation along gradients

```r
rank.all <- rankindex(varechem, varespec, indices = 
              c("bray", "euclid", "manhattan", "horn"), method = "spearman")
rank.all
```

```
     bray    euclid manhattan      horn 
   0.2241    0.1469    0.2262    0.1785 
```

<!----------------------------slide boundary--------------------------------->

## Calculating distances with `vegdist()` | so many distance metrics, so little time!

### Second, try `rankindex()`    
Or across a single, selected gradient

```r
rank.Ca <- rankindex(varechem$Ca, varespec, indices = 
              c("bray", "euclid", "manhattan", "horn"), method = "spearman")
rank.Ca
```

```
     bray    euclid manhattan      horn 
  0.12707   0.08922   0.14425   0.10210 
```

<!----------------------------slide boundary--------------------------------->

## Calculating distances with `vegdist()` | so many distance metrics, so little time!

### Second, try `rankindex()`    
Can also use on standardized data

```r
rank.Ca.wisc <- rankindex(varechem$Ca, wisconsin(varespec), indices = 
              c("bray", "euclid", "manhattan", "horn"), method = "spearman")
rank.Ca.wisc
```

```
     bray    euclid manhattan      horn 
   0.2228    0.1745    0.2228    0.2058 
```

<!----------------------------slide boundary--------------------------------->

## Calculating distances with `vegdist()` | comparison


```r
sort(rank.all, decreasing = TRUE)
```

```
manhattan      bray      horn    euclid 
   0.2262    0.2241    0.1785    0.1469 
```

```r
sort(rank.Ca, decreasing = TRUE)
```

```
manhattan      bray      horn    euclid 
  0.14425   0.12707   0.10210   0.08922 
```

```r
sort(rank.Ca.wisc, decreasing = TRUE)
```

```
     bray manhattan      horn    euclid 
   0.2228    0.2228    0.2058    0.1745 
```

<!----------------------------slide boundary--------------------------------->

# Diversity metrics

<!----------------------------slide boundary--------------------------------->

## Alpha diversity

Basic counts of richness for each plot or site

```r
site.richness <- apply(varespec > 0, 1, sum)
site.richness
```

```
18 15 24 27 23 19 22 16 28 13 14 20 25  7  5  6  3  4  2  9 12 10 11 21 
29 26 23 25 26 28 27 27 27 31 25 27 30 26 23 24 25 26 19 27 18 24 23 28 
```

<!----------------------------slide boundary--------------------------------->

## Alpha diversity | Other metrics

Fisher's alpha

```r
# site.richness <- fisher.alpha(varespec)
site.richness
```

```
18 15 24 27 23 19 22 16 28 13 14 20 25  7  5  6  3  4  2  9 12 10 11 21 
29 26 23 25 26 28 27 27 27 31 25 27 30 26 23 24 25 26 19 27 18 24 23 28 
```

<!----------------------------slide boundary--------------------------------->

## Alpha diversity | Other metrics

Shannon diversity

```r
site.richness <- apply(varespec > 0, 1, sum)
site.richness
```

```
18 15 24 27 23 19 22 16 28 13 14 20 25  7  5  6  3  4  2  9 12 10 11 21 
29 26 23 25 26 28 27 27 27 31 25 27 30 26 23 24 25 26 19 27 18 24 23 28 
```

<!----------------------------slide boundary--------------------------------->

## Rarefaction

## Beta diversity

E.g. distance metrics discussed earlier.
### Within vs between group similarities

* `betadisper()`

## References
