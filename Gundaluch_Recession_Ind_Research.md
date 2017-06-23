IS THE UNEMPLOYMENT RATE SIMPLE MOVING AVERAGE A RELIABLE RECESSION INDICATOR FOR THE STOCK MARKET?
================
Mark Black
10/18/2016

#### Strategy Overview

Famed bond guru Jeff Gundaluch, CEO of Doubleline Capital LP, just saw one of his favorite recession indicators starting to flash red or bearish. I decided to see how reliable the Unemployment Rate indicator is in terms of a trading strategy.

Bloomberg article: <http://www.bloomberg.com/news/articles/2016-10-07/one-of-jeff-gundlach-s-favorite-recession-indicators-just-got-triggered>

The recession signal is when the Unemployment Rate (UR) crosses over the 12 month moving average (using Simple Moving Average (SMA) ). Today’s the BLS announced the Unemployment Rate ticked up to 5.0 which is .1 above the 12 month moving average at 4.9.

So looking back let’s take a quick simple look at how “actionable” this indicator is in terms of going long or short the market. In this simple strategy below:

#### PORTFOLIO PARAMETERS

Capital: $1,0000,000 USD<br/> Period: 1/1/2000 – 10/6/2016<br/> Allocation: All<br/>

#### TRADE RULES

LONG SPY ETF when the current month’s UR &lt; UR 12 SMA, when UR &gt; UR 12 SMA close SPY ETF long<br/> SHORT SPY ETF when the current month’s UR &lt; UR 12SMA, reverse back long when UR &lt; UR 12 SMA<br/>

#### ANALYSIS

As you can see below during this time period the “UR 12SMA crossover strategy” outperformed the S&P500 benchmark during the time period. Although the strategy is far from an ideal long/short equity market strategy with a Max Drawdown of around 25%. If you are a simple investor looking for a simple strategy that may give you a hint as to when it may be a good time to ring the register these kinds of fundamental indicators may be better than watching all the back and forth bull v. bear noise on financial media outlets. Perhaps used in conjunction with Gundaluch’s other recession indicators a more profitable trading approach may be found \*On my TDO list now 😉 An interesting observation is that the short signal appears to trigger early while the long signal tends to signal late.

#### TRADES

“2000-08-02 00:00:00 SPY -6950 @ 144.593704”<br/> “2000-09-05 00:00:00 SPY 6950 @ 151.281204”<br/> “2000-09-05 00:00:00 SPY 6557 @ 151.281204”<br/> “2001-01-02 00:00:00 SPY -6557 @ 128.8125”<br/> “2001-01-02 00:00:00 SPY -7623 @ 128.8125”<br/> “2002-10-02 00:00:00 SPY 7623 @ 83.150002”<br/> “2002-10-02 00:00:00 SPY 11666 @ 83.150002”<br/> “2002-11-04 00:00:00 SPY -11666 @ 91.129997”<br/> “2002-11-04 00:00:00 SPY -11078 @ 91.129997”<br/> “2003-10-02 00:00:00 SPY 11078 @ 102.449997”<br/> “2003-10-02 00:00:00 SPY 9796 @ 102.449997”<br/> “2007-06-04 00:00:00 SPY -9796 @ 154.100006”<br/> “2007-06-04 00:00:00 SPY -6490 @ 154.100006”<br/> “2010-05-03 00:00:00 SPY 6490 @ 120.349998”<br/> “2010-05-03 00:00:00 SPY 8417 @ 120.349998”<br/> “2010-11-02 00:00:00 SPY -8417 @ 119.470001”<br/> “2010-11-02 00:00:00 SPY -8437 @ 119.470001”<br/> “2010-12-02 00:00:00 SPY 8437 @ 122.559998”<br/> “2010-12-02 00:00:00 SPY 8264 @ 122.559998”<br/> “2016-09-02 00:00:00 SPY -8264 @ 218.369995”<br/> “2016-09-02 00:00:00 SPY -4600 @ 218.369995”<br/>

#### RETURNS

Annualized Return 0.0816<br/> Annualized Std Dev 0.1816<br/> Annualized Sharpe (Rf=0%) 0.4493<br/> Max Drawdown: .2482572<br/>

Here are the results of the backtest:

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

![Model Signals](https://blackmarkttrading.files.wordpress.com/2016/10/ur_backtest_image100616.jpeg) ![Model Performance](https://blackmarkttrading.files.wordpress.com/2016/10/ur_model_perf100616.jpeg)
