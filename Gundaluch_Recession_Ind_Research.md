IS THE UNEMPLOYMENT RATE SIMPLE MOVING AVERAGE A RELIABLE RECESSION INDICATOR FOR THE STOCK MARKET?
================
Mark Black
10/18/2016

------------------------------------------------------------------------

### Load the necessary libraries

``` r
require(quantstrat)
require(FinancialInstrument)
require(blotter)
require(Quandl)
require(quantmod)
require(PerformanceAnalytics)
```

### Import the Unemployment Rate from the St. Louis Federal Reserve

``` r
UNRATE = getSymbols('UNRATE', src='FRED', auto.assign=F)
names(UNRATE) <- "UNRATE"
UNRATE$UNRATE.12SMA <- SMA(UNRATE,12)
UNRATE <- na.omit(UNRATE)
UNRATE$SIGNAL <- ifelse(UNRATE$UNRATE>UNRATE$UNRATE.12SMA,1,0)
```

### Custom Functions

``` r
osFixedDollar <- function(timestamp,orderqty, portfolio, symbol, ruletype, ...) 
{ 
  #logwarn("started osFixedDollar") 
  ClosePrice <- as.numeric(Cl(mktdata[timestamp,])) 
  orderqty <- sign(orderqty)*round(tradeSize/ClosePrice) 
  return(orderqty) 
} 
```

### Setting up the Portfolio

``` r
# Modified maCross 
ttz <- Sys.getenv('TZ')
Sys.setenv(TZ='UTC')

stock.str <- 'SPY'
currency('USD')
stock(stock.str, currency='USD', multiplier=1)

initDate <- "2000-01-01"
endDate <- Sys.Date()

tradeSize <- 1000000
initEq <- tradeSize

portfolio.st <- 'model'
account.st <- 'model'

suppressWarnings({
  rm(list=paste("order_book",portfolio.st,sep="."),pos=.strategy)
  rm(list=c(paste("account",account.st,sep="."),
            paste("portfolio",portfolio.st,sep=".")),pos=.blotter)
  rm("strat")
})
initPortf(portfolio.st,symbols=stock.str, initDate=initDate)
initAcct(account.st,portfolios=portfolio.st, initDate=initDate,initEq=initEq)
initOrders(portfolio=portfolio.st,initDate=initDate)

strat <- strategy(portfolio.st)
```

### Pulling the Data

``` r
# Pull SPY data from Yahoo Finance
getSymbols.google(stock.str, from=initDate, to=endDateenv=.GlobalEnv)
colnames(SPY) = c("Open", "High", "Low", "Adjusted", "Volume")
# Add model indicator to SPY data
SPY <- na.omit(merge(SPY, UNRATE$SIGNAL, fill=na.locf))
```

### Trade Signals and Rules

``` r
# signals
# not sure what the model values are, so I assume a long signal
# Short
strat <- add.signal(strat, "sigThreshold",
                    arguments = list(column = "SIGNAL",
                                     threshold = 1,
                                     relationship = "eq",
                                     cross = TRUE),
                    label = "pred.gt.03")
strat <- add.signal(strat, "sigThreshold",
                    arguments = list(column = "SIGNAL",
                                     threshold = 0,
                                     relationship = "eq",
                                     cross = TRUE),
                    label = "pred.lt.04")

# Long
strat <- add.signal(strat, "sigThreshold",
                    arguments = list(column = "SIGNAL",
                                     threshold = 1,
                                     relationship = "eq",
                                     cross = TRUE),
                    label = "pred.gt.02")
strat <- add.signal(strat, "sigThreshold",
                    arguments = list(column = "SIGNAL",
                                     threshold = 0,
                                     relationship = "eq",
                                     cross = TRUE),
                    label = "pred.lt.01")



## RULES
# Short 
strat <- add.rule(strat, 'ruleSignal',
                  arguments = list(sigcol = "pred.gt.03",
                                   sigval = TRUE,
                                   orderqty = -1,
                                   ordertype = 'market',
                                   orderside = 'short',
                                   osFUN=osFixedDollar,
                                   prefer="Close",
                                   TxnFees=-30,
                                   replace=FALSE),
                  type = 'enter',
                  label = 'enter.shot')

strat <- add.rule(strat, 'ruleSignal',
                  arguments = list(sigcol = "pred.lt.04",
                                   sigval = TRUE,
                                   orderqty = 'all',
                                   ordertype = 'market',
                                   orderside = 'short',
                                   TxnFees=-30,
                                   replace=TRUE),
                  type = 'exit',
                  label = 'exit.short')

# Long
strat <- add.rule(strat, 'ruleSignal',
                  arguments = list(sigcol = "pred.lt.01",
                                   sigval = TRUE,
                                   orderqty = 1,
                                   ordertype = 'market',
                                   orderside = 'long',
                                   osFUN=osFixedDollar,
                                   prefer="Close",
                                   TxnFees=-30,
                                   replace=FALSE),
                  type = 'enter',
                  label = 'enter.long')

strat <- add.rule(strat, 'ruleSignal',
                  arguments = list(sigcol = "pred.gt.02",
                                   sigval = TRUE,
                                   orderqty = 'all',
                                   ordertype = 'market',
                                   orderside = 'long',
                                   TxnFees=-30,
                                   replace=TRUE),
                  type = 'exit',
                  label = 'exit.long')
```

### Results of the Backtest

``` r
# run backtest
out <- applyStrategy(strategy=strat, portfolios=portfolio.st)
updatePortf(Portfolio='model', Dates=paste('::',as.Date(Sys.time()),sep=''))

par(lwd=3)
chart.Posn(Portfolio='model',Symbol=stock.str)

book    <- getOrderBook('model')
stats   <- tradeStats('model')
ptstats <- perTradeStats('model')
rets    <- PortfReturns('model')
table.AnnualizedReturns(rets)
SharpeRatio.annualized(rets)
maxDrawdown(rets)
txns    <- getTxns('model', stock.str)

# SPY rets v Model rets
SPYrets <- Return.calculate(Ad(SPY))
model.spy.rets <- merge(rets, SPYrets, join='inner')
names(model.spy.rets) <- c("Model","SPY")

charts.PerformanceSummary(model.spy.rets)

#Date workaround, remove later
Sys.setenv(TZ=ttz)
```

![Model Signals](/Users/markblack/Google%20Drive/R/Fundamental%20Indicators/NFP/UR_backtest_image100616.jpeg) ![Model Performance](/Users/markblack/Google%20Drive/R/Fundamental%20Indicators/NFP/ur_model_perf100616.jpeg)
