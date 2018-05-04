---
title: "Bioinformatics Class 7"
author: "Corrina Elder"
date: "April 25, 2018"
output: 
  html_document: 
    keep_md: yes
---



#Functions again

We can source any file of R code with the `source`() function


```r
source("http://tinyurl.com/rescale-R")
```

Let's make sure things are here


```r
ls()
```

```
##  [1] "both_na"         "both_na2"        "both_na3"       
##  [4] "df1"             "df2"             "df3"            
##  [7] "gene_intersect"  "gene_intersect2" "gene_intersect3"
## [10] "gene_intersect4" "rescale"         "rescale2"
```

Check our `rescale()` is working


```r
rescale(1:10)
```

```
##  [1] 0.0000000 0.1111111 0.2222222 0.3333333 0.4444444 0.5555556 0.6666667
##  [8] 0.7777778 0.8888889 1.0000000
```


```r
rescale( c(1:10, "string"))
```

Let's check if `rescale2()` does any better


```r
rescale2( c(1:10, "string"))
```


## Function for finding missing values in two datasets

Write a `both_na()` function to do this...


```r
x <- c( 1, 2, NA, 3, NA) 
y <- c(NA,3,NA,3, 4)

sum(is.na(x))
```

```
## [1] 2
```


```r
x <- c( 1, 2, NA, 3, NA) 
y <- c(NA,3,NA,3, 4)

which(is.na(x))
```

```
## [1] 3 5
```


```r
x <- c( 1, 2, NA, 3, NA) 
y <- c(NA,3,NA,3, 4)

which(!is.na(x))
```

```
## [1] 1 2 4
```


```r
sum(is.na(x) & is.na(y))
```

```
## [1] 1
```

My first function can start from this snippet


```r
both_na <- function(x, y) {
  sum( is.na(x) & is.na(y))
}
```

Test it!


```r
both_na(x, y)
```

```
## [1] 1
```

Testing


```r
 x <-  c(NA, NA, NA)
y1 <- c( 1, NA, NA)
y2 <- c( 1, NA, NA, NA)

both_na(x, y2)
```

```
## Warning in is.na(x) & is.na(y): longer object length is not a multiple of
## shorter object length
```

```
## [1] 3
```



```r
# x <-  c(NA, NA, NA)
#y1 <- c( 1, NA, NA)
#y2 <- c( 1, NA, NA, NA)

#both_na2(x, y2)
```


```r
x <- c( 1, 2, NA, 3, NA) 
y <- c(NA,3,NA,3, 4)

ans <- both_na3(x, y)
```

```
## Found 1 NA's at position(s):3
```


```r
ans$which
```

```
## [1] 3
```

## And a last function that is useful


```r
x <- df1$IDs
y <- df2$IDs

x
```

```
## [1] "gene1" "gene2" "gene3"
```

```r
y
```

```
## [1] "gene2" "gene4" "gene3" "gene5"
```

```r
intersect(x, y)
```

```
## [1] "gene2" "gene3"
```

```r
x %in% y        #for each element in x, check if it's in y
```

```
## [1] FALSE  TRUE  TRUE
```

```r
x[x %in% y] 
```

```
## [1] "gene2" "gene3"
```

```r
y[y %in% x]
```

```
## [1] "gene2" "gene3"
```

```r
cbind( x[ x %in% y ], y[ y %in% x ] ) #column bind into matrix
```

```
##      [,1]    [,2]   
## [1,] "gene2" "gene2"
## [2,] "gene3" "gene3"
```

Make this into a function


```r
gene_intersect <- function(x, y) {
   cbind( x[ x %in% y ], y[ y %in% x ] )
}

x <- df1$IDs
y <- df2$IDs
gene_intersect(x, y)
```

```
##      [,1]    [,2]   
## [1,] "gene2" "gene2"
## [2,] "gene3" "gene3"
```

Let's try with data.frome input rather than vectors


```r
gene_intersect2(df1, df2)
```

```
##     IDs exp df2[df2$IDs %in% df1$IDs, "exp"]
## 2 gene2   1                               -2
## 3 gene3   1                                1
```


```r
gene_intersect3(df1, df2)
```

```
##     IDs exp exp2
## 2 gene2   1   -2
## 3 gene3   1    1
```


```r
gene_intersect4(df1, df2)
```

```
##     IDs exp exp2
## 2 gene2   1   -2
## 3 gene3   1    1
```


```r
merge(df1, df2, by="IDs")
```

```
##     IDs exp.x exp.y
## 1 gene2     1    -2
## 2 gene3     1     1
```

















