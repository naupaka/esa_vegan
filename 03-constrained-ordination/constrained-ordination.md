# Constrained Ordination & Permutation Tests



# Constrained Ordination

## Canonical Correspondence Analysis

CCA is the constrained form of CA; fitted using `cca()`.

Two interfaces for specifying models

 * basic; `cca1 <- cca(X = varespec, Y = varechem)`
 * formula; `cca1 <- cca(varespec ~ ., data = varechem)`

Formula interface is the more powerful --- *recommended*

## Canonical Correspondence Analysis


```r
cca1 <- cca(varespec ~ ., data = varechem)
cca1
```

```
Call: cca(formula = varespec ~ N + P + K + Ca + Mg + S + Al + Fe +
Mn + Zn + Mo + Baresoil + Humdepth + pH, data = varechem)

              Inertia Proportion Rank
Total           2.083      1.000     
Constrained     1.441      0.692   14
Unconstrained   0.642      0.308    9
Inertia is mean squared contingency coefficient 

Eigenvalues for constrained axes:
   CCA1    CCA2    CCA3    CCA4    CCA5    CCA6    CCA7    CCA8    CCA9 
0.43887 0.29178 0.16285 0.14213 0.11795 0.08903 0.07029 0.05836 0.03114 
  CCA10   CCA11   CCA12   CCA13   CCA14 
0.01329 0.00836 0.00654 0.00616 0.00473 

Eigenvalues for unconstrained axes:
    CA1     CA2     CA3     CA4     CA5     CA6     CA7     CA8     CA9 
0.19776 0.14193 0.10117 0.07079 0.05330 0.03330 0.01887 0.01510 0.00949 
```
