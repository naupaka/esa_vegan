# Community data analysis using the vegan package in R
Naupaka Zimmerman and Gavin Simpson  
August 9, 2014 • ESA 2014  



## Workshop logistics

* Etherpad [[link here]]
* Red and Green Stickies

## Packages installed?


```r
install.packages("vegan", dependencies = TRUE)
install.packages("plyr")
install.packages("reshape2")
```

## Introduction to **vegan**

* What is it?
* Who developed it?
* How does it differ from other alternatives?

## Digging in | Prepping your data for R and vegan

### “The purpose of computing is insight, not numbers” 
### - Richard Hamming 

## Digging in | Prepping your data for R and vegan

We've all heard data horror stories
![](img/otherpeoplesdata.png)

## Cleaning your data for import into R for use in vegan

* Spreadsheet example

## Cleaning your data for import into R for use in vegan

* We will use built-in datasets for species `varespec` and environmental variables `varechem`
    * from: Väre, H., Ohtonen, R. and Oksanen, J. (1995)


```r
library("vegan")
data(varespec)
data(varechem)
```

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


## Data transformation with `decostand()`

* total
* max
* pa
* hellinger
* `wisconsin()`
    * this is the same as first standardizing species by `max` and sites by `total`
* Etc

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
