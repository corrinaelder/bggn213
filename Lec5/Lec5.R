#' ---
#' title: "Bioinformatics Class 5"
#' author: "Corrina Elder"
#' date: "April 18th, 2018"
#' output:
#'   html_document:
#'     code_folding: hide
#' ---

#Bioinformatics Class 5
#Plots

x <- rnorm(1000, 0)

summary(x)

#let's see this data as a graph
boxplot(x)

#Good old histogram
hist(x)

# Section 1 from lab sheet
baby <- read.table("bggn213_05_rstats/weight_chart.txt", TRUE)

plot(baby, type = "b", pch = 15, cex = 1.5, lwd = 2, ylim = c(2, 10), xlab = "Age (months)", ylab = "Weight (kg)", main = "Baby weight")

#Section 1B
feat <- read.table("bggn213_05_rstats/feature_counts.txt", sep = "\t", header = TRUE)

#Barplot of count
par(mar = c(5, 11, 4, 2))
par()
barplot(feat$Count, horiz = TRUE, names.arg = feat$Feature, main = "Some title", las = 2, col = "darkturquoise")

#Section 2
#gender <- read.table("bggn213_05_rstats/male_female_counts.txt", sep = "\t", header = TRUE)
#need to use read.delim not read.table
mfcount <- read.delim("bggn213_05_rstats/male_female_counts.txt")

par(mfrow = c(1, 1)) #just one graph
mycols <- cm.colors(nrow(mfcount))

barplot(mfcount$Count, col = mycols)


#2B
up_down <- read.delim("bggn213_05_rstats/up_down_expression.txt")
palette(c("blue", "gray", "red"))
plot(up_down$Condition1, up_down$Condition2, col = up_down$State)

#How many genes went up/down/unchanged
table(up_down$State)

#2C



