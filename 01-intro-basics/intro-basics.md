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


```r
head(varespec[,1:8], n = 3)
```

```
   Cal.vul Emp.nig Led.pal Vac.myr Vac.vit Pin.syl Des.fle Bet.pub
18    0.55   11.13       0    0.00   17.80    0.07       0       0
15    0.67    0.17       0    0.35   12.13    0.12       0       0
24    0.10    1.55       0    0.00   13.47    0.25       0       0
```

## Summarizing data with `apply()`

Sum of rows

```r
apply(varespec, 1, sum)
```

```
    18     15     24     27     23     19     22     16     28     13 
 89.20  89.82  94.21 125.61  90.46  81.27 109.76  88.52 110.70 101.89 
    14     20     25      7      5      6      3      4      2      9 
 81.65  64.11  94.06 103.38  94.77 110.90 106.67  84.83 119.13 122.60 
    12     10     11     21 
119.80 122.37 112.84  99.17 
```
Sum of columns

```r
apply(varespec, 2, sum)
```

```
Cal.vul Emp.nig Led.pal Vac.myr Vac.vit Pin.syl Des.fle Bet.pub Vac.uli 
  45.07  151.99    8.39   50.71  275.03    4.11    5.60    0.29   15.22 
Dip.mon  Dic.sp Dic.fus Dic.pol Hyl.spl Ple.sch Pol.pil Pol.jun Pol.com 
   3.24   40.50  113.52    6.06   18.04  377.97    0.61   13.85    0.71 
Poh.nut Pti.cil Bar.lyc Cla.arb Cla.ran Cla.ste Cla.unc Cla.coc Cla.cor 
   2.62   14.01    3.19  255.05  388.71  486.71   56.28    2.79    6.22 
Cla.gra Cla.fim Cla.cri Cla.chl Cla.bot Cla.ama  Cla.sp Cet.eri Cet.isl 
   5.14    3.96    7.47    1.16    0.47    0.14    0.52    3.60    2.03 
Cet.niv Nep.arc  Ste.sp Pel.aph Ich.eri Cla.cer Cla.def Cla.phy 
  11.85    5.26   17.52    0.76    0.22    0.10   10.23    0.80 
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
