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
* Shape
* Size

<!----------------------------slide boundary--------------------------------->

## Modifying the color of points {.smaller}

```r
colors.vec <- c("red", "blue", "orange", "grey")
plot(dune.bray.ord, display = "sites", type = "n")
points(dune.bray.ord, display = "sites", cex=2, pch = 21, 
       col = colors.vec[dune.env$Management], 
       bg = colors.vec[dune.env$Management])
legend("topright", legend = levels(dune.env$Management), bty = "n",
                      col = colors.vec, pch = 21, pt.bg = colors.vec)
```

![plot of chunk unnamed-chunk-11](./ordination_files/figure-html/unnamed-chunk-11.png) 

<!----------------------------slide boundary--------------------------------->

## Modifying the shape of points
![plot of chunk unnamed-chunk-12](./ordination_files/figure-html/unnamed-chunk-12.png) 

<!----------------------------slide boundary--------------------------------->

## Modifying the shape of points {.smaller}

```r
shapes.vec <- c(21, 22, 24)
plot(dune.bray.ord, display = "sites", type = "n")
points(dune.bray.ord, display = "sites", cex=2, bg = "black", 
       pch = shapes.vec[dune.env$Use])
legend("topright", legend = levels(dune.env$Use), bty = "n",
                      col = "black", pch = shapes.vec, pt.bg = "black")
```

![plot of chunk unnamed-chunk-13](./ordination_files/figure-html/unnamed-chunk-13.png) 

<!----------------------------slide boundary--------------------------------->

## Modifying the shape and color of points {.smaller}

```r
colors.vec <- c("red", "blue", "orange", "grey")
shapes.vec <- c(21, 22, 24)
plot(dune.bray.ord, display = "sites", type = "n")
points(dune.bray.ord, display = "sites", cex=2, 
       pch = shapes.vec[dune.env$Use], 
       col = colors.vec[dune.env$Management], 
       bg = colors.vec[dune.env$Management])
legend("topright", legend = levels(dune.env$Management), bty = "n",
                      col = colors.vec, pch = 21, pt.bg = colors.vec)
legend(1.5,1.05, legend = levels(dune.env$Use), bty = "n",
                      col = "black", pch = shapes.vec, pt.bg = "black")
```

![plot of chunk unnamed-chunk-14](./ordination_files/figure-html/unnamed-chunk-14.png) 

<!----------------------------slide boundary--------------------------------->

## Adding other layers


```r
# Just points
plot(dune.bray.ord, display = "sites", cex=2)
```

![plot of chunk unnamed-chunk-15](./ordination_files/figure-html/unnamed-chunk-15.png) 

<!----------------------------slide boundary--------------------------------->

## Adding other layers


```r
plot(dune.bray.ord, display = "sites", cex=2)
ordihull(dune.bray.ord,groups = dune.env$Management, label = TRUE)
```

![plot of chunk unnamed-chunk-16](./ordination_files/figure-html/unnamed-chunk-16.png) 

<!----------------------------slide boundary--------------------------------->

## Adding other layers


```r
plot(dune.bray.ord, display = "sites", cex=2)
ordihull(dune.bray.ord,groups = dune.env$Management, label = TRUE, col = "blue")
```

![plot of chunk unnamed-chunk-17](./ordination_files/figure-html/unnamed-chunk-17.png) 

<!----------------------------slide boundary--------------------------------->

## Adding other layers


```r
plot(dune.bray.ord, display = "sites", cex=2)
ordihull(dune.bray.ord,groups = dune.env$Management, label = TRUE, col = "blue")
ordispider(dune.bray.ord,groups = dune.env$Management, label = TRUE)
```

![plot of chunk unnamed-chunk-18](./ordination_files/figure-html/unnamed-chunk-18.png) 

<!----------------------------slide boundary--------------------------------->

## Adding other layers


```r
plot(dune.bray.ord, display = "sites", cex=2)
ordispider(dune.bray.ord,groups = dune.env$Management, label = TRUE)
```

![plot of chunk unnamed-chunk-19](./ordination_files/figure-html/unnamed-chunk-19.png) 

<!----------------------------slide boundary--------------------------------->

## Adding other layers - axes scaling


```r
plot(dune.bray.ord, type = "n")
```

![plot of chunk unnamed-chunk-20](./ordination_files/figure-html/unnamed-chunk-20.png) 

<!----------------------------slide boundary--------------------------------->

## Adding other layers - axes scaling


```r
plot(dune.bray.ord, type = "n")
points(dune.bray.ord,display = "sites", cex = 2)
```

![plot of chunk unnamed-chunk-21](./ordination_files/figure-html/unnamed-chunk-21.png) 

<!----------------------------slide boundary--------------------------------->

## Adding other layers - axes scaling


```r
plot(dune.bray.ord, display = "sites", type = "n")
```

![plot of chunk unnamed-chunk-22](./ordination_files/figure-html/unnamed-chunk-22.png) 

<!----------------------------slide boundary--------------------------------->

## Adding other layers - axes scaling


```r
plot(dune.bray.ord, display = "sites", type = "n")
points(dune.bray.ord, display = "sites", cex = 2)
```

![plot of chunk unnamed-chunk-23](./ordination_files/figure-html/unnamed-chunk-23.png) 

<!----------------------------slide boundary--------------------------------->

## Adding other layers


```r
plot(dune.bray.ord, display = "sites", type = "n")
points(dune.bray.ord,display = "sites", cex = 2)
ordispider(dune.bray.ord,groups = dune.env$Management, label = TRUE)
```

![plot of chunk unnamed-chunk-24](./ordination_files/figure-html/unnamed-chunk-24.png) 

<!----------------------------slide boundary--------------------------------->

## Adding other layers


```r
plot(dune.bray.ord, display = "sites", type = "n")
points(dune.bray.ord, display = "sites", cex = 2)
ordiellipse(dune.bray.ord,groups = dune.env$Management, label = TRUE)
```

![plot of chunk unnamed-chunk-25](./ordination_files/figure-html/unnamed-chunk-25.png) 

<!----------------------------slide boundary--------------------------------->

## Adding other layers

```r
plot(dune.bray.ord, display = "sites", type = "n")
points(dune.bray.ord,display = "sites", cex = 2)
ordisurf(dune.bray.ord,dune.env$A1, add = TRUE)
```

![plot of chunk unnamed-chunk-26](./ordination_files/figure-html/unnamed-chunk-26.png) 

```

Family: gaussian 
Link function: identity 

Formula:
y ~ s(x1, x2, k = 10, bs = "tp", fx = FALSE)
<environment: 0x7fae16f1aa68>

Estimated degrees of freedom:
1.62  total = 2.62 

REML score: 41.43     
```

<!----------------------------slide boundary--------------------------------->

## Vectors in ordination space


```r
dune.bray.ord.A1.fit <- envfit(dune.bray.ord,dune.env$A1, permutations = 1000)
dune.bray.ord.A1.fit
```

```

***VECTORS

     NMDS1 NMDS2   r2 Pr(>r)  
[1,]  0.99  0.14 0.38   0.02 *
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
P values based on 1000 permutations.
```

<!----------------------------slide boundary--------------------------------->

## Vectors in ordination space


```r
plot(dune.bray.ord, display = "sites", type = "n")
points(dune.bray.ord,display = "sites", cex = 2)
plot(dune.bray.ord.A1.fit, add = TRUE)
ordisurf(dune.bray.ord,dune.env$A1, add = TRUE)
```

![plot of chunk unnamed-chunk-28](./ordination_files/figure-html/unnamed-chunk-28.png) 

```

Family: gaussian 
Link function: identity 

Formula:
y ~ s(x1, x2, k = 10, bs = "tp", fx = FALSE)
<environment: 0x7fae13bb2fc0>

Estimated degrees of freedom:
1.62  total = 2.62 

REML score: 41.43     
```


<!----------------------------slide boundary--------------------------------->

## References
