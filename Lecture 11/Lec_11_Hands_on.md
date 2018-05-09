Lecture 11
================

PDB Statistics
--------------

Import our PDB stats CSV file and calculate percent structures by experimental method

``` r
p <- read.csv("Data Export Summary.csv", row.names = 1)
```

Q1:

``` r
percent <- p$Total / sum(p$Total) * 100
names(percent) <- row.names(p)
percent
```

    ##               X-Ray                 NMR Electron Microscopy 
    ##         89.51673340          8.71321614          1.51239392 
    ##               Other        Multi Method 
    ##          0.16986775          0.08778879
