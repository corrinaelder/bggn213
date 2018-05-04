---
title: "Bioinformatics Lecture 9 Mini-Project"
author: "Corrina Elder"
date: "May 2, 2018"
output: 
  html_document: 
    keep_md: yes
---



# Section 1

Let's read our input data:


```r
url <- "https://bioboot.github.io/bggn213_S18/class-material/WisconsinCancer.csv"

# Complete the following code to input the data and store as wisc.df
wisc.df <- read.csv(url)
head(wisc.df)
```

```
##         id diagnosis radius_mean texture_mean perimeter_mean area_mean
## 1   842302         M       17.99        10.38         122.80    1001.0
## 2   842517         M       20.57        17.77         132.90    1326.0
## 3 84300903         M       19.69        21.25         130.00    1203.0
## 4 84348301         M       11.42        20.38          77.58     386.1
## 5 84358402         M       20.29        14.34         135.10    1297.0
## 6   843786         M       12.45        15.70          82.57     477.1
##   smoothness_mean compactness_mean concavity_mean concave.points_mean
## 1         0.11840          0.27760         0.3001             0.14710
## 2         0.08474          0.07864         0.0869             0.07017
## 3         0.10960          0.15990         0.1974             0.12790
## 4         0.14250          0.28390         0.2414             0.10520
## 5         0.10030          0.13280         0.1980             0.10430
## 6         0.12780          0.17000         0.1578             0.08089
##   symmetry_mean fractal_dimension_mean radius_se texture_se perimeter_se
## 1        0.2419                0.07871    1.0950     0.9053        8.589
## 2        0.1812                0.05667    0.5435     0.7339        3.398
## 3        0.2069                0.05999    0.7456     0.7869        4.585
## 4        0.2597                0.09744    0.4956     1.1560        3.445
## 5        0.1809                0.05883    0.7572     0.7813        5.438
## 6        0.2087                0.07613    0.3345     0.8902        2.217
##   area_se smoothness_se compactness_se concavity_se concave.points_se
## 1  153.40      0.006399        0.04904      0.05373           0.01587
## 2   74.08      0.005225        0.01308      0.01860           0.01340
## 3   94.03      0.006150        0.04006      0.03832           0.02058
## 4   27.23      0.009110        0.07458      0.05661           0.01867
## 5   94.44      0.011490        0.02461      0.05688           0.01885
## 6   27.19      0.007510        0.03345      0.03672           0.01137
##   symmetry_se fractal_dimension_se radius_worst texture_worst
## 1     0.03003             0.006193        25.38         17.33
## 2     0.01389             0.003532        24.99         23.41
## 3     0.02250             0.004571        23.57         25.53
## 4     0.05963             0.009208        14.91         26.50
## 5     0.01756             0.005115        22.54         16.67
## 6     0.02165             0.005082        15.47         23.75
##   perimeter_worst area_worst smoothness_worst compactness_worst
## 1          184.60     2019.0           0.1622            0.6656
## 2          158.80     1956.0           0.1238            0.1866
## 3          152.50     1709.0           0.1444            0.4245
## 4           98.87      567.7           0.2098            0.8663
## 5          152.20     1575.0           0.1374            0.2050
## 6          103.40      741.6           0.1791            0.5249
##   concavity_worst concave.points_worst symmetry_worst
## 1          0.7119               0.2654         0.4601
## 2          0.2416               0.1860         0.2750
## 3          0.4504               0.2430         0.3613
## 4          0.6869               0.2575         0.6638
## 5          0.4000               0.1625         0.2364
## 6          0.5355               0.1741         0.3985
##   fractal_dimension_worst  X
## 1                 0.11890 NA
## 2                 0.08902 NA
## 3                 0.08758 NA
## 4                 0.17300 NA
## 5                 0.07678 NA
## 6                 0.12440 NA
```

How many diagnosis are cancer (M) vs non cancer (B)


```r
table(wisc.df$diagnosis)
```

```
## 
##   B   M 
## 357 212
```

Remove id and diagnosis columns


```r
# Convert the features of the data: wisc.data
#Also remove the problem 'X' column in position 33
wisc.data <- as.matrix(wisc.df[,-c(1:2, 33)])

# Set the row names of wisc.data
row.names(wisc.data) <- wisc.df$id
#head(wisc.data)
```


Finally, setup a separate new vector called diagnosis to be 1 if a diagnosis is malignant ("M") and 0 otherwise. Note that R coerces TRUE to 1 and FALSE to 0.


```r
# Create diagnosis vector by completing the missing code
diagnosis <- as.numeric(wisc.df$diagnosis == "M")
```

Explore the data you created before (wisc.data and diagnosis) to answer the following questions:

Q1. How many observations are in this dataset? 
    wisc.data has 569 observations (use nrow(wisc.data)).
Q2. How many variables/features in the data are suffixed with _mean? 
    dim(wisc.data) gives 31 columns
    

```r
length(grep("_mean", colnames(wisc.data)))
```

```
## [1] 10
```
    
Q3. How many of the observations have a malignant diagnosis?
    212 (table(wisc.df))

# Section 2

The next step in your analysis is to perform principal component analysis (PCA) on  wisc.data.

It is important to check if the data need to be scaled before performing PCA. Recall two common reasons for scaling data include:

The input variables use different units of measurement.
The input variables have significantly different variances.
Check the mean and standard deviation of the features (i.e. columns) of the wisc.data to determine if the data should be scaled. Use the colMeans() and apply() functions like you’ve done before.


```r
# Check column means and standard deviations
plot(colMeans(wisc.data), type = "h")
```

![](Lecture_9_Mini-Project_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

```r
apply(wisc.data, 2, sd)
```

```
##             radius_mean            texture_mean          perimeter_mean 
##            3.524049e+00            4.301036e+00            2.429898e+01 
##               area_mean         smoothness_mean        compactness_mean 
##            3.519141e+02            1.406413e-02            5.281276e-02 
##          concavity_mean     concave.points_mean           symmetry_mean 
##            7.971981e-02            3.880284e-02            2.741428e-02 
##  fractal_dimension_mean               radius_se              texture_se 
##            7.060363e-03            2.773127e-01            5.516484e-01 
##            perimeter_se                 area_se           smoothness_se 
##            2.021855e+00            4.549101e+01            3.002518e-03 
##          compactness_se            concavity_se       concave.points_se 
##            1.790818e-02            3.018606e-02            6.170285e-03 
##             symmetry_se    fractal_dimension_se            radius_worst 
##            8.266372e-03            2.646071e-03            4.833242e+00 
##           texture_worst         perimeter_worst              area_worst 
##            6.146258e+00            3.360254e+01            5.693570e+02 
##        smoothness_worst       compactness_worst         concavity_worst 
##            2.283243e-02            1.573365e-01            2.086243e-01 
##    concave.points_worst          symmetry_worst fractal_dimension_worst 
##            6.573234e-02            6.186747e-02            1.806127e-02
```


Execute PCA with the prcomp() function on the wisc.data, scaling if appropriate, and assign the output model to wisc.pr.


```r
# Perform PCA on wisc.data by completing the following code
wisc.pr <- prcomp(wisc.data, scale = TRUE)
```


```r
# Look at summary of results
summary(wisc.pr)
```

```
## Importance of components:
##                           PC1    PC2     PC3     PC4     PC5     PC6
## Standard deviation     3.6444 2.3857 1.67867 1.40735 1.28403 1.09880
## Proportion of Variance 0.4427 0.1897 0.09393 0.06602 0.05496 0.04025
## Cumulative Proportion  0.4427 0.6324 0.72636 0.79239 0.84734 0.88759
##                            PC7     PC8    PC9    PC10   PC11    PC12
## Standard deviation     0.82172 0.69037 0.6457 0.59219 0.5421 0.51104
## Proportion of Variance 0.02251 0.01589 0.0139 0.01169 0.0098 0.00871
## Cumulative Proportion  0.91010 0.92598 0.9399 0.95157 0.9614 0.97007
##                           PC13    PC14    PC15    PC16    PC17    PC18
## Standard deviation     0.49128 0.39624 0.30681 0.28260 0.24372 0.22939
## Proportion of Variance 0.00805 0.00523 0.00314 0.00266 0.00198 0.00175
## Cumulative Proportion  0.97812 0.98335 0.98649 0.98915 0.99113 0.99288
##                           PC19    PC20   PC21    PC22    PC23   PC24
## Standard deviation     0.22244 0.17652 0.1731 0.16565 0.15602 0.1344
## Proportion of Variance 0.00165 0.00104 0.0010 0.00091 0.00081 0.0006
## Cumulative Proportion  0.99453 0.99557 0.9966 0.99749 0.99830 0.9989
##                           PC25    PC26    PC27    PC28    PC29    PC30
## Standard deviation     0.12442 0.09043 0.08307 0.03987 0.02736 0.01153
## Proportion of Variance 0.00052 0.00027 0.00023 0.00005 0.00002 0.00000
## Cumulative Proportion  0.99942 0.99969 0.99992 0.99997 1.00000 1.00000
```

Q4. From your results, what proportion of the original variance is captured by the first principal components (PC1)?
    0.4427 (PC1 Proportion of Variance)
Q5. How many principal components (PCs) are required to describe at least 70% of the original variance in the data?
    3 (Cumulative Proportion)
Q6. How many principal components (PCs) are required to describe at least 90% of the original variance in the data?
    7 (Cumulative Proportion)
    

```r
biplot(wisc.pr)
```

![](Lecture_9_Mini-Project_files/figure-html/unnamed-chunk-9-1.png)<!-- -->
Q7. What stands out to you about this plot? Is it easy or difficult to understand? Why?
    It's difficult to read because of the names and the points are not well spread out.

Scatter plot

```r
plot(wisc.pr$x[,1], wisc.pr$x[,2], col = diagnosis + 1)
```

![](Lecture_9_Mini-Project_files/figure-html/unnamed-chunk-10-1.png)<!-- -->


```r
# Repeat for components 1 and 3
plot(wisc.pr$x[, c(1, 3)], col = (diagnosis + 1), 
     xlab = "PC1", ylab = "PC3")
```

![](Lecture_9_Mini-Project_files/figure-html/unnamed-chunk-11-1.png)<!-- -->

Variance explained


```r
# Variance explained by each principal component: pve
pve <- wisc.pr$sdev^2 / sum(wisc.pr$sdev^2)

# Plot variance explained for each principal component
plot(pve, xlab = "Principal Component", 
     ylab = "Proportion of Variance Explained", 
     ylim = c(0, 1), type = "o")
```

![](Lecture_9_Mini-Project_files/figure-html/unnamed-chunk-12-1.png)<!-- -->

```r
# Barplot
barplot(pve, names.arg = paste("PC", 1:length(pve)), las = 2, axes = FALSE, ylab = "Proportion of Variance")
axis(2, at = pve, labels = round(pve, 2) * 100)
```

![](Lecture_9_Mini-Project_files/figure-html/unnamed-chunk-12-2.png)<!-- -->


```r
# Plot cumulative proportion of variance explained
plot(cumsum(pve), xlab = "Principal Component", 
     ylab = "Cumulative Proportion of Variance Explained", 
     ylim = c(0, 1), type = "o")
```

![](Lecture_9_Mini-Project_files/figure-html/unnamed-chunk-13-1.png)<!-- -->


```r
# Plot cumulative proportion of variance explained
# plot( ___ , xlab = "Principal Component", 
#      ylab = "Cumulative Proportion of Variance Explained", 
#      ylim = c(0, 1), type = "o")
```

Q9. For the first principal component, what is the component of the loading vector (i.e. wisc.pr$rotation[,1]) for the feature concave.points_mean?

Q10. What is the minimum number of principal components required to explain 80% of the variance of the data?


# Section 3
Hierarchical clustering of case data


```r
# Scale the wisc.data data: data.scaled
data.scaled <- scale(wisc.data)

data.dist <- dist(data.scaled)

wisc.hclust <- hclust(data.dist, method = "complete")

plot(wisc.hclust)

abline(h = 20, col = "red", lwd = 3)
```

![](Lecture_9_Mini-Project_files/figure-html/unnamed-chunk-15-1.png)<!-- -->



```r
wisc.hclust.clusters <- cutree(wisc.hclust, k = 4)

table(wisc.hclust.clusters, diagnosis)
```

```
##                     diagnosis
## wisc.hclust.clusters   0   1
##                    1  12 165
##                    2   2   5
##                    3 343  40
##                    4   0   2
```

Q12. Can you find a better cluster vs diagnoses match with by cutting into a different number of clusters between 2 and 10?

No. Fewer clusters loses distinction, more splits it too much.


```r
#wisc.hclust.clusters <- cutree(wisc.hclust, k = 5)

#table(wisc.hclust.clusters, diagnosis)
```


# Section 4
K-means clustering and comparing results


```r
wisc.km <- kmeans(wisc.data, centers = 2, nstart = 20)

table(wisc.km$cluster, diagnosis)
```

```
##    diagnosis
##       0   1
##   1 356  82
##   2   1 130
```
Q13. How well does k-means separate the two diagnoses? How does it compare to your hclust results?
     It does a good job separating benign, but the malignant is not as good as hclust.
     

```r
table(wisc.hclust.clusters, wisc.km$cluster)
```

```
##                     
## wisc.hclust.clusters   1   2
##                    1  68 109
##                    2   5   2
##                    3 365  18
##                    4   0   2
```
     

# Section 5
Clustering on PCA results


```r
# Use the distance along the first 7 PCs for clustering i.e. wisc.pr$x[, 1:7]
wisc.pr.hclust <- hclust(dist(wisc.pr$x[, 1:3]), method = "ward.D2")

plot(wisc.pr.hclust)
```

![](Lecture_9_Mini-Project_files/figure-html/unnamed-chunk-20-1.png)<!-- -->

```r
wisc.pr.hclust.clusters <- cutree(wisc.pr.hclust, k = 2)

table(wisc.pr.hclust.clusters, diagnosis)
```

```
##                        diagnosis
## wisc.pr.hclust.clusters   0   1
##                       1  24 179
##                       2 333  33
```

```r
plot(wisc.pr$x[, 1:2], col = wisc.pr.hclust.clusters)
```

![](Lecture_9_Mini-Project_files/figure-html/unnamed-chunk-20-2.png)<!-- -->



```r
#install.packages("rgl")
```


```r
#plot3d(wisc.pr$x[, 1:3], type = "s", col = wisc.pr.hclust.clusters)
```



```r
#url <- "https://tinyurl.com/new-samples-CSV"
#new <- read.csv(url)
#npc <- predict(wisc.pr, newdata = new)

#plot(wisc.pr$x[ , 1:2], col = wisc.pr.hclust.clusters)
#points(npc[ , 1], npc[ , 2], col = c("blue", "purple"), pch = 16, cex = 2)
```






