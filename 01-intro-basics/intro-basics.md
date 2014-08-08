# Community data analysis using the vegan package in R
Naupaka Zimmerman and Gavin Simpson  
August 9, 2014 • ESA 2014  



## Introduction to **vegan**

* What is it?
* Who developed it?
* How does it differ from other alternatives?

## Workshop logistics

* Etherpad
* Red and Green Stickies

## Digging in | Prepping your data for R and vegan

* We've all heard data horror stories
* Data image

## Cleaning your data for import into R for use in vegan

* Spreadsheet example
* format of site/species matrix and environmental data matrix
* will use built-in datasets  for species `varespec` and environmental variables `varechem`

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
* `rankindex()`

## References
