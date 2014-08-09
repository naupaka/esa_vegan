# Ordination with vegan
Naupaka Zimmerman and Gavin Simpson  
August 9, 2014 • ESA 2014  



<!----------------------------slide boundary--------------------------------->

# Ordination plots

<!----------------------------slide boundary--------------------------------->

## Unconstrained ordination

**What does it mean?**

* First we look for major variation, then try to attribute it to environmental variation
* vs. constrained ordination, where we only want to see what can be explained by environmental variables of interest

<!----------------------------slide boundary--------------------------------->

## Unconstrained ordination

**What does it mean?**

* First we look for major variation, then try to attribute it to environmental variation
* vs. constrained ordination, where we only want to see what can be explained by environmental variables of interest

**Examples of unconstrained ordination:**

* Principal Components Analysis - PCA
* Nonmetric Multidimensional Scaling - NMDS

<!----------------------------slide boundary--------------------------------->

## Unconstrained ordination

**What does it mean?**

* First we look for major variation, then try to attribute it to environmental variation
* vs. constrained ordination, where we only want to see what can be explained by environmental variables of interest

**Examples of unconstrained ordination:**

* Principal Components Analysis - PCA
* **Nonmetric Multidimensional Scaling - NMDS**

<!----------------------------slide boundary--------------------------------->

## Before we get started

Housekeeping

```r
setwd("your/working/dir")
```


```r
library("vegan")
data(dune)
data(dune.env)
```
Data from : Jongman, R.H.G, ter Braak, C.J.F & van Tongeren, O.F.R. (1987). Data Analysis in Community and Landscape Ecology. Pudoc, Wageningen.

<!----------------------------slide boundary--------------------------------->

## Before we get started


```r
head(dune[,1:10], n=3)
```

```
   Belper Empnig Junbuf Junart Airpra Elepal Rumace Viclat Brarut Ranfla
2       3      0      0      0      0      0      0      0      0      0
13      0      0      3      0      0      0      0      0      0      2
4       2      0      0      0      0      0      0      0      2      0
```

<!----------------------------slide boundary--------------------------------->

## Before we get started


```r
head(dune.env, n=3)
```

```
    A1 Moisture Management      Use Manure
2  3.5        1         BF Haypastu      2
13 6.0        5         SF Haypastu      3
4  4.2        2         SF Haypastu      4
```

<!----------------------------slide boundary--------------------------------->

## Basic ordination and plotting

There are two more basic NMDS ordination functions:

* `isoMDS()` from the MASS package
* `monoMDS()` in vegan

Vegan also has a wrapper function for doing NMDS ordinations using best practices:

* `metaMDS()`

<!----------------------------slide boundary--------------------------------->

## Basic ordination and plotting


```r
dune.bray.ord <- metaMDS(dune, distance = "bray", k = 2, trymax = 50)
```

**Show in RStudio**

<!----------------------------slide boundary--------------------------------->

## Basic ordination and plotting (using all defaults)


```r
plot(dune.bray.ord)
```

![plot of chunk unnamed-chunk-6](./ordination_files/figure-html/unnamed-chunk-6.png) 


<!----------------------------slide boundary--------------------------------->

## Basic ordination and plotting (just plots)


```r
plot(dune.bray.ord, display = "sites")
```

![plot of chunk unnamed-chunk-7](./ordination_files/figure-html/unnamed-chunk-7.png) 

<!----------------------------slide boundary--------------------------------->

## Basic ordination and plotting (just species)


```r
plot(dune.bray.ord, display = "species")
```

![plot of chunk unnamed-chunk-8](./ordination_files/figure-html/unnamed-chunk-8.png) 

<!----------------------------slide boundary--------------------------------->

## Site names instead of points


```r
plot(dune.bray.ord, display = "sites", type = "t")
```

![plot of chunk unnamed-chunk-9](./ordination_files/figure-html/unnamed-chunk-9.png) 

<!----------------------------slide boundary--------------------------------->

## Larger points


```r
plot(dune.bray.ord, display = "sites", cex=2)
```

![plot of chunk unnamed-chunk-10](./ordination_files/figure-html/unnamed-chunk-10.png) 

<!----------------------------slide boundary--------------------------------->

## Modifying the display of the points with environmental data 

* Color
    * Discrete
    * Continuous
* Shape
* Size


<!----------------------------slide boundary--------------------------------->

## Adding other layers


```r
# Just points
plot(dune.bray.ord, display = "sites", cex=2)
```

![plot of chunk unnamed-chunk-11](./ordination_files/figure-html/unnamed-chunk-11.png) 

<!----------------------------slide boundary--------------------------------->

## Adding other layers


```r
plot(dune.bray.ord, display = "sites", cex=2)
ordihull(dune.bray.ord,groups = dune.env$Management, label = TRUE)
```

![plot of chunk unnamed-chunk-12](./ordination_files/figure-html/unnamed-chunk-12.png) 

<!----------------------------slide boundary--------------------------------->

## Adding other layers


```r
plot(dune.bray.ord, display = "sites", cex=2)
ordihull(dune.bray.ord,groups = dune.env$Management, label = TRUE, col = "blue")
```

![plot of chunk unnamed-chunk-13](./ordination_files/figure-html/unnamed-chunk-13.png) 

<!----------------------------slide boundary--------------------------------->

## Adding other layers


```r
plot(dune.bray.ord, display = "sites", cex=2)
ordihull(dune.bray.ord,groups = dune.env$Management, label = TRUE, col = "blue")
ordispider(dune.bray.ord,groups = dune.env$Management, label = TRUE)
```

![plot of chunk unnamed-chunk-14](./ordination_files/figure-html/unnamed-chunk-14.png) 

<!----------------------------slide boundary--------------------------------->

## Adding other layers


```r
plot(dune.bray.ord, display = "sites", cex=2)
ordispider(dune.bray.ord,groups = dune.env$Management, label = TRUE)
```

![plot of chunk unnamed-chunk-15](./ordination_files/figure-html/unnamed-chunk-15.png) 

<!----------------------------slide boundary--------------------------------->

## Adding other layers


```r
plot(dune.bray.ord, type = "n")
```

![plot of chunk unnamed-chunk-16](./ordination_files/figure-html/unnamed-chunk-16.png) 

<!----------------------------slide boundary--------------------------------->

## Adding other layers


```r
plot(dune.bray.ord, type = "n")
points(dune.bray.ord,display = "sites", cex = 2)
```

![plot of chunk unnamed-chunk-17](./ordination_files/figure-html/unnamed-chunk-17.png) 

<!----------------------------slide boundary--------------------------------->

## Adding other layers


```r
plot(dune.bray.ord, type = "n")
points(dune.bray.ord,display = "sites", cex = 2)
ordispider(dune.bray.ord,groups = dune.env$Management, label = TRUE)
```

![plot of chunk unnamed-chunk-18](./ordination_files/figure-html/unnamed-chunk-18.png) 

<!----------------------------slide boundary--------------------------------->

## Adding other layers

<!----------------------------slide boundary--------------------------------->

## Fitting environmental data to vectors in ordination space

<!----------------------------slide boundary--------------------------------->

## Fitting environmental data to vectors in ordination space


<!----------------------------slide boundary--------------------------------->

## References
