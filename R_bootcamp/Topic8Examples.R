
#Topic 8 Various Examples

data(mtcars)
mtcars$mpg
summary(mtcars$mpg)
quantile(mtcars$mpg,.25)
x<-seq(-3,3, length = 50)
dnorm(x)

qnorm(pnorm(3))

with(mtcars, aggregate(mpg, by = list(cyl), FUN = "mean"))

#Code below separates out the 4 cylinder and 6 cylinder cars into different columns
#Note the naming and how variables are referenced.
cyl4mpg <- subset(mtcars, cyl == "4", select = c(mpg))
cyl4mpg
cyl6 <- subset(mtcars, cyl == "6")
cyl6
boxplot(cyl4mpg$mpg, cyl6$mpg)

#Now see which is the shorter vector
length(cyl4mpg$mpg)
length(cyl6$mpg)

cyl4mpg <- sample(cyl4mpg$mpg,7)  #down to just 7 randomly selected 4 cylinder cars
cyl4mpg
cyl6mpg <- subset(cyl6, select = c(mpg))
cyl6mpg
rownames(cyl6mpg) <- NULL   # get rid of rownames

#binds the two separate columns together, they are equal length now
cyl4_6mpg <- cbind(cyl4mpg,cyl6mpg)  
cyl4_6mpg
colnames(cyl4_6mpg) <- c("cyl4", "cyl6")
boxplot(cyl4_6mpg) # with 4 randomly selected 4 cylinders removed

#Stacking the two columns back up. But without all the 4 cylinders
library(reshape2)
cylmpg_stacked <- melt(data.frame(cyl4_6mpg$cyl4,cyl4_6mpg$cyl6))
colnames(cylmpg_stacked) <- c("cyl","mpg")
cylmpg_stacked
cylmpg_stacked$cyl<-factor(ifelse(cylmpg_stacked$cyl == "cyl4_6mpg.cyl4","4","6"))
cylmpg_stacked
boxplot(mpg~cyl, data = cylmpg_stacked)

#Summarizing original mpg data by cylinder
library(plyr)
mtcars$cyl <- as.factor(mtcars$cyl)
SumStats <- ddply(mtcars, c("cyl"),summarise, 
                      n = length(mpg),
                      mean = mean(mpg), 
                      sd = sd(mpg),
                      SE = sd/sqrt(n))
SumStats
