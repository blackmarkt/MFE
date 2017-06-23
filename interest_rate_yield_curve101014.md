Interest Rate Yield Curve
================
Mark Black
10/10/2014

### R Code

``` r
# Author: Mark Black
# Subject: Interest Rates
# Date: 100914

## libraries
library(Quandl)

# setwd("C:/Users/blackmarkt/Google Drive/R/Interest Rates")
setwd("~/Google Drive/R/Interest Rates")

# Load interest rates ds via Quandl as df
IR <- Quandl("USTREASURY/YIELD", trim_start="2011-10-08",
                       authcode="Wp68Bux85C874pBHCnNC")

# Rename columns of IR df
colnames(IR) <- c("Date", "Mo.1","Mo.3","MO.6","Yr.1","Yr.2","Yr.3","Yr.5","Yr.7","Yr.10",
                             "Yr.20","Yr.30")

# Remove unnecessary columns
IR$Mo.1 <- NULL
IR$Mo.2 <- NULL
IR$Yr.3 <- NULL
IR$Yr.7 <- NULL

# Subset yesterday's IR curve, yesterday's, 1 week ago & 1 month ago
IR.today <- IR[1,]
IR.yesterday <- IR[2,]
IR.week <- IR[6,]
IR.month <- IR[22,]
IR.year <- IR[251,]

# Transpose the subset IR df's from columns into rows
IR.today.t <- t(IR.today)
IR.yesterday.t <- t(IR.yesterday)
IR.week.t <- t(IR.week)
IR.month.t <- t(IR.month)
IR.year.t <- t(IR.year)

# Remove 1st column out of IR. ds'
IR.today.l <- IR.today.t[-1,]
IR.yesterday.l <- IR.yesterday.t[-1,]
IR.week.l <- IR.week.t[-1,]
IR.month.l <- IR.month.t[-1,]
IR.year.l <- IR.year.t[-1,]

# Convert IR. matrixes back to df's
IR.today.l <- data.frame(IR.today.l)
IR.yesterday.l <- data.frame(IR.yesterday.l)
IR.week.l <- data.frame(IR.week.l)
IR.month.l <- data.frame(IR.month.l)
IR.year.l <- data.frame(IR.year.l)

# Convert the IR's to numeric type from factors
IR.today.l$IR.today.l <- as.numeric(as.character(IR.today.l$IR.today.l))
IR.yesterday.l$IR.yesterday.l <- as.numeric(as.character(IR.yesterday.l$IR.yesterday.l))
IR.week.l$IR.week.l <- as.numeric(as.character(IR.week.l$IR.week.l))
IR.month.l$IR.month.l <- as.numeric(as.character(IR.month.l$IR.month.l))
IR.year.l$IR.year.l <- as.numeric(as.character(IR.year.l$IR.year.l))

# Open export print device
# jpeg(filename="interest_rates.jpg", width=1024, height=768)
png(filename="interest_rates.png", width=1024, height=768)

# Plot the IR's
# Set the par's
par(bg="black", col="white", col.axis="white", col.lab="white", col.main="white", cex=1)
# Set the colors in a colors
col=c("white","blue","magenta","yellow", "red")

# Note: use xaxt to remove the index along the bottom
plot(IR.today.l$IR.today.l, type="l", main="UST Yield Curve", 
     xlab="UST Duration", ylab="Rate", xaxt="n", col=col[1])
points(IR.today.l$IR.today.l, col=col[1], pch=19)
# text(IR.today.l$IR.today.l,pos=3,cex=.8)

# Add axis with appropriate labels
axis(1, at=1:8, labels=c("3Mo","6Mo","1Yr", "2Yr","5Yr","10Yr","20Yr","30Yr"), col="white", cex=1)
# Add other IR's
lines(IR.yesterday.l, col=col[2])
points(IR.yesterday.l$IR.yesterday.l, col=col[2], pch=19)

lines(IR.week.l, col=col[3])
points(IR.week.l$IR.week.l, col=col[3], pch=19)

lines(IR.month.l, col=col[4])
points(IR.month.l$IR.month.l, col=col[4], pch=19)

lines(IR.year.l, col=col[5])
points(IR.year.l$IR.year.l, col=col[5], pch=19)

# Create date for yesterday using Sys.Date()
legend.date <- IR.today$Date
# Convert to character from POSIXlt to use in c function
legend.date <- as.character(legend.date)
# Create legend
legend("topleft", col=col, lwd=.5, box.col="white", cex=1,
       legend=c(legend.date, "2 Days Ago", "1 Week Ago", "1 Month Ago", "1 Year Ago"))

# Close jpeg device
dev.off()

# gvisLineChart
suppressPackageStartupMessages(library(googleVis))

# Create df
rownames(IR.today.l) <- c("3 Month","6 Month","1 Year","2 Year","5 Year","10 Year","20 Year","30 Year")
IR.df <- data.frame(label=rownames(IR.today.l),IR.today.l,IR.yesterday.l,IR.week.l,IR.month.l,IR.year.l)
colnames(IR.df) <- c("label","Today","Yesterday","1 Week Ago","1 Month Ago","1 Year Ago")
rownames(IR.df) <- c(1,2,3,4,5,6,7,8)

IR.linechart <- gvisLineChart(IR.df,xvar="label",yvar=c("Today","Yesterday","1 Week Ago","1 Month Ago","1 Year Ago"),
                              options=list(title="Yield Curve", vAxis="[{title:'Bond Duration'}]",
                                           hAxis="[{title:'Yield'}]", width=1024,height=768))

plot(IR.linechart)
```

!['Yield Curve'](https://blackmarkt.files.wordpress.com/2014/11/interest_rates.png)
