library(IBrokers)
library(quantmod)
library(Quandl)

# Import ES Fut prior to IBKR futures
# Fut.201206 <- Quandl("CME/ESM2012", authcode="Wp68Bux85C874pBHCnNC", trim_start="2011-06-13", trim_end="2012-10-13")

tws <- twsConnect()
tws

# Assign Fut.xxxxxx objects
# Fut.201312 <- twsFUT("ES","GLOBEX","201312",include_expired="1")
# Fut.201403 <- twsFUT("ES","GLOBEX","201403",include_expired="1")
# Fut.201406 <- twsFUT("ES","GLOBEX","201406",include_expired="1")
# Fut.201409 <- twsFUT("ES","GLOBEX","201409",include_expired="1")
# Fut.201412 <- twsFUT("ES","GLOBEX","201412",include_expired="1")
# Fut.201503 <- twsFUT("ES","GLOBEX","201503",include_expired='1')
# Fut.201506 <- twsFUT("ES","GLOBEX","201506",include_expired='1')
# Fut.201509 <- twsFUT("ES","GLOBEX","201509",include_expired='1')
# Fut.201512 <- twsFUT("ES","GLOBEX","201512",include_expired='1')
# Fut.201603 <- twsFUT("ES","GLOBEX","201603",include_expired='1')
Fut.201606 <- twsFUT("ES","GLOBEX","201606",include_expired='1')


# Download E.mini fut's into appropriate objects
# E.mini.201312 <- reqHistoricalData(tws,Contract=Fut.201312,duration='2 Y',useRTH='1')
# E.mini.201403 <- reqHistoricalData(tws,Contract=Fut.201403,duration='2 Y',useRTH='1')
# E.mini.201406 <- reqHistoricalData(tws,Contract=Fut.201406,duration='2 Y',useRTH='1')
# E.mini.201409 <- reqHistoricalData(tws,Contract=Fut.201409,duration='2 Y',useRTH='1')
# E.mini.201412 <- reqHistoricalData(tws,Contract=Fut.201412,duration='2 Y',useRTH='1')
# E.mini.201503 <- reqHistoricalData(tws,Contract=Fut.201503,duration='2 Y',useRTH='1')
# E.mini.201506 <- reqHistoricalData(tws,Contract=Fut.201506,duration='2 Y',useRTH='1')
# E.mini.201509 <- reqHistoricalData(tws,Contract=Fut.201509,duration='2 Y',useRTH='1')
# E.mini.201512 <- reqHistoricalData(tws,Contract=Fut.201512,duration='2 Y',useRTH='1')
# E.mini.201603 <- reqHistoricalData(tws,Contract=Fut.201603,duration='2 Y',useRTH='1')
E.mini.201606 <- reqHistoricalData(tws,Contract=Fut.201606,duration='2 Y',useRTH='1')

# Disconnect
twsDisconnect(tws)

# E.mini. Data Merge
# names(E.mini.201312) <- c("ES.Open","ES.High","ES.Low","ES.Close","ES.Volume","ES.VWAP",
#                              "ES.Gaps","ES.Count")
# E.mini.201312 <- window(E.mini.201312,start="2013-12-16",end="2013-12-12")
# E.mini <- E.mini.201312

# colnames(E.mini.201403) <- c("ES.Open","ES.High","ES.Low","ES.Close","ES.Volume","ES.VWAP",
#                              "ES.Gaps","ES.Count")
# E.mini.201403 <- window(E.mini.201412,start="2013-12-16",end="2014-03-13")
# E.mini <- rbind(E.mini,E.mini.201403)
# 
# colnames(E.mini.201406) <- c("ES.Open","ES.High","ES.Low","ES.Close","ES.Volume","ES.VWAP",
#                              "ES.Gaps","ES.Count")
# E.mini.201406 <- window(E.mini.201412,start="2014-03-14",end="2014-06-10")
# E.mini <- rbind(E.mini,E.mini.201406)
# 
# colnames(E.mini.201409) <- c("ES.Open","ES.High","ES.Low","ES.Close","ES.Volume","ES.VWAP",
#                              "ES.Gaps","ES.Count")
# E.mini.201409 <- window(E.mini.201412,start="2014-06-12",end="2014-09-11")
# E.mini <- rbind(E.mini,E.mini.201409)
# 
# colnames(E.mini.201412) <- c("ES.Open","ES.High","ES.Low","ES.Close","ES.Volume","ES.VWAP",
#                              "ES.Gaps","ES.Count")
# E.mini.201412 <- window(E.mini.201412,start="2014-09-12",end="2014-12-10")
# E.mini <- rbind(E.mini,E.mini.201412)
# 
# colnames(E.mini.201503) <- c("ES.Open","ES.High","ES.Low","ES.Close","ES.Volume","ES.VWAP",
#                              "ES.Gaps","ES.Count")
# E.mini.201503 <- window(E.mini.201503,start="2014-12-11",end="2015-03-11")
# E.mini <- rbind(E.mini,E.mini.201503)
# 
# colnames(E.mini.201506) <- c("ES.Open","ES.High","ES.Low","ES.Close","ES.Volume","ES.VWAP",
#                              "ES.Gaps","ES.Count")
# E.mini.201506 <- window(E.mini.201506,start="2015-03-12", end="2015-06-10")
# E.mini <- rbind(E.mini,E.mini.201506)
# 
# colnames(E.mini.201509) <- c("ES.Open","ES.High","ES.Low","ES.Close","ES.Volume","ES.VWAP",
#                              "ES.Gaps","ES.Count")
# E.mini.201509 <- window(E.mini.201509,start="2015-06-11", end="2015-09-10")
# E.mini <- rbind(E.mini,E.mini.201509)
# 
# colnames(E.mini.201512) <- c("ES.Open","ES.High","ES.Low","ES.Close","ES.Volume","ES.VWAP",
#                              "ES.Gaps","ES.Count")
# E.mini.201512 <- window(E.mini.201512,start="2015-09-11", end="2015-12-10")
# E.mini.xts <- rbind(E.mini,E.mini.201512)

# colnames(E.mini.201603) <- c("ES.Open","ES.High","ES.Low","ES.Close","ES.Volume","ES.VWAP",
#                              "ES.Gaps","ES.Count")
# E.mini.201603 <- window(E.mini.201603,start="2015-12-11", end="2016-03-10")
colnames(E.mini.201606) <- c("ES.Open","ES.High","ES.Low","ES.Close","ES.Volume","ES.VWAP",
                             "ES.Gaps","ES.Count")
E.mini.201606 <- window(E.mini.201606,start="2016-03-11", end="2016-06-10")
# E.mini.xts <- rbind(E.mini,E.mini.201606)
# E.mini$ES.Count <- NULL

# # Archive Old ES files
setwd("C:/Users/blackmarkt/Google Drive/R Models/Daily")
# E.mini.df <- data.frame(Date=index(E.mini.xts),coredata(E.mini.xts))
# write.csv(E.mini.df,file="ES_PP_archive.csv")

# Read in archived ES
ES.df <- read.csv("ES_PP_archive.csv", stringsAsFactors = FALSE)
ES.df <- ES.df[,-1]
ES.df$Date <- as.Date(ES.df$Date, format="%m/%d/%Y")
ES <- xts(ES.df[,-1], order.by=ES.df[,1])

# Combine archive w/ current ES contract
ES <- rbind(ES, E.mini.201606)

# Save Mid
ES$ES.Mid <- ((lag(ES$ES.High,1)-lag(ES$ES.Low,1))/2)+lag(ES$ES.Low,1)

# Pivot Points
ES$ES.PP <- (lag(ES$ES.High,1)+lag(ES$ES.Low,1)+lag(ES$ES.Close,1))/3
ES$ES.R1 <- (2*ES$ES.PP)-lag(ES$ES.Low,1)
ES$ES.R2 <- ES$ES.PP+(lag(ES$ES.High,1)-lag(ES$ES.Low,1))
ES$ES.R3 <- ES$ES.R2+(lag(ES$ES.High,1)-lag(ES$ES.Low,1))
ES$ES.S1 <- (2*ES$ES.PP)-lag(ES$ES.High,1)
ES$ES.S2 <- ES$ES.PP-(lag(ES$ES.High,1)-lag(ES$ES.Low,1))
ES$ES.S3 <- ES$ES.S2-(lag(ES$ES.High,1)-lag(ES$ES.Low,1))

E.mini <- ES

# Today's Projected Open
# 1st Lag the archived days
E.mini$ES.Open.Proj <- lag(E.mini$ES.Open,-1)
E.mini[nrow(E.mini),"ES.Open.Proj"] <- 2058

# Mid

# Calculate the difference in today's projected open from prev day's reference pts
E.mini$ES.PO.YCL <- (E.mini$ES.Open.Proj-E.mini$ES.Close)/E.mini$ES.Close
E.mini$ES.PO.YHI <- (E.mini$ES.Open.Proj-E.mini$ES.High)/E.mini$ES.High
E.mini$ES.PO.YLO <- (E.mini$ES.Open.Proj-E.mini$ES.Low)/E.mini$ES.Low
E.mini$ES.PO.Mid <- (E.mini$ES.Open.Proj-E.mini$ES.Mid)/E.mini$ES.Mid


# Calculate the differences
# Open-Close
E.mini$Op.Cl <- (E.mini$ES.Close-E.mini$ES.Open)/E.mini$ES.Open
E.mini$Hi.Cl <- (E.mini$ES.Close-E.mini$ES.High)/E.mini$ES.High
E.mini$Lo.Cl <- (E.mini$ES.Close-E.mini$ES.Low)/E.mini$ES.Low

#E.mini$Volume.Diff <- (E.mini$ES.Volume-lag(E.mini$ES.Volume,1))/lag(E.mini$ES.Volume,1)
E.mini$Op.YCl <- (E.mini$ES.Open-lag(E.mini$ES.Close,1))/lag(E.mini$ES.Close,1)

# Mid

E.mini$ES.Cl.Mid <- (E.mini$ES.Close-E.mini$ES.Mid)/E.mini$ES.Mid
E.mini$ES.PO.Mid <- (E.mini$ES.Open.Proj-E.mini$ES.Mid)/E.mini$ES.Mid

# Close in relation to PP
E.mini$Cl.PP <- (E.mini$ES.Close-E.mini$ES.PP)/E.mini$ES.PP

# YHI or YLO tag
E.mini$Hi.YHI <- ifelse(E.mini$ES.High>lag(E.mini$ES.High,1),1,0)
E.mini$Lo.YLO <- ifelse(E.mini$ES.Low<lag(E.mini$ES.Low,1),1,0)
E.mini$Hi.YHI1 <- lag(E.mini$Hi.YHI,-1)
E.mini$Lo.YLO1 <- lag(E.mini$Lo.YLO,-1)

# Close in relation to YHI or YLO
E.mini$Cl.YHI <- ifelse(E.mini$ES.Close>lag(E.mini$ES.High,1),1,0)
E.mini$Cl.YLO <- ifelse(E.mini$ES.Close<lag(E.mini$ES.Low,1),1,0)

# DHI DLO in relation to YHI or YLO
E.mini$Up.Trend <- ifelse(E.mini$ES.Close>lag(E.mini$ES.Close,1),1,0)
E.mini$Up.Trend1 <- lag(E.mini$Up.Trend,-1)
E.mini$Down.Trend <- ifelse(E.mini$ES.Close<lag(E.mini$ES.Close,1),1,0)
E.mini$Down.Trend1 <- lag(E.mini$Down.Trend,-1)

# Current Day PP Tag
E.mini$Mid.Tag <- ifelse((E.mini$ES.Mid<=E.mini$ES.High)&(E.mini$ES.Mid>=E.mini$ES.Low),1,0)
E.mini$PP.Tag <- ifelse((E.mini$ES.PP<=E.mini$ES.High)&(E.mini$ES.PP>=E.mini$ES.Low),1,0)
E.mini$R1.Tag <- ifelse((E.mini$ES.R1<=E.mini$ES.High)&(E.mini$ES.R1>=E.mini$ES.Low),1,0)
E.mini$R2.Tag <- ifelse((E.mini$ES.R2<=E.mini$ES.High)&(E.mini$ES.R2>=E.mini$ES.Low),1,0)
E.mini$R3.Tag <- ifelse((E.mini$ES.R3<=E.mini$ES.High)&(E.mini$ES.R3>=E.mini$ES.Low),1,0)
E.mini$S1.Tag <- ifelse((E.mini$ES.S1<=E.mini$ES.High)&(E.mini$ES.S1>=E.mini$ES.Low),1,0)
E.mini$S2.Tag <- ifelse((E.mini$ES.S2<=E.mini$ES.High)&(E.mini$ES.S2>=E.mini$ES.Low),1,0)
E.mini$S3.Tag <- ifelse((E.mini$ES.S3<=E.mini$ES.High)&(E.mini$ES.S3>=E.mini$ES.Low),1,0)

# Future Day PP Tags
E.mini$Mid.Tag1 <- lag(E.mini$Mid.Tag,-1)
E.mini$PP.Tag1 <- lag(E.mini$PP.Tag,-1)
E.mini$R1.Tag1 <- lag(E.mini$R1.Tag,-1)
E.mini$R2.Tag1 <- lag(E.mini$R2.Tag,-1)
E.mini$R3.Tag1 <- lag(E.mini$R3.Tag,-1)
E.mini$S1.Tag1 <- lag(E.mini$S1.Tag,-1)
E.mini$S2.Tag1 <- lag(E.mini$S2.Tag,-1)
E.mini$S3.Tag1 <- lag(E.mini$S3.Tag,-1)

# Gap
E.mini$Gap <- ifelse((E.mini$ES.High>=lag(E.mini$ES.Close,1))&(E.mini$ES.Low<=lag(E.mini$ES.Close,1)),1,0)
E.mini$Gap1 <- lag(E.mini$Gap,-1)

# # Calculate/Import Technical Indicators
# E.mini$VWAP <- VWAP(Cl(E.mini),Vo(E.mini))
# E.mini$EMA5 <- EMA(Cl(E.mini),5)
# E.mini$EMA8 <- EMA(Cl(E.mini),8)
# E.mini$SMA200 <- SMA(Cl(E.mini),200)
# E.mini$SMA100 <- SMA(Cl(E.mini),100)
# E.mini$SMA50 <- SMA(Cl(E.mini),50)
# E.mini$SMA20 <- SMA(Cl(E.mini),20)
# E.mini$RSI14 <- RSI(Cl(E.mini),14)
E.mini$RSI2 <- RSI(Cl(E.mini),2)
# E.mini$Momo <- momentum(Cl(E.mini),10)
# E.mini$BB2 <- BBands(Cl(E.mini),20)
# E.mini$BB3 <- BBands(Cl(E.mini),20,sd=3)
# E.mini$CCI <- CCI(Cl(E.mini),20)
# E.mini$MACD <- MACD(Cl(E.mini),nFast=12,nSlow=26,nSig=9)
# E.mini$Stoch <- stoch(Cl(E.mini),nFastK=14,nFastD=5,nSlowD=3)
# E.mini$Stoch.RSI <- stoch(RSI(Cl(E.mini)))
# E.mini$CMF <- CMF(HLC(E.mini),Vo(E.mini),n=20)
# E.mini$ADX <- ADX(HLC(E.mini),14)
# E.mini$CCI <- CCI(Cl(E.mini),20)
# E.mini$CMO <- CMO(Cl(E.mini),14)
# E.mini$DPO <- DPO(Cl(E.mini),21,shift=0)
# E.mini$ROC <- ROC(Cl(E.mini),9)
# E.mini$WPR <- WPR(HLC(E.mini),14)

# Import ATR Indicator
E.mini$ATR <- ATR(E.mini,5)

E.mini$ATR.R <- E.mini$tr/E.mini$atr
# E.mini$ATR.Diff <- (E.mini$tr-lag(E.mini$tr,1))/lag(E.mini$tr,1)
E.mini$tr <- NULL
E.mini$atr <- NULL
E.mini$trueHigh <- NULL
E.mini$ATR <- NULL

# VWAP calculation
E.mini$VWAP.Diff <- (E.mini$ES.VWAP-lag(E.mini$ES.VWAP,1))/lag(E.mini$ES.VWAP,1)
E.mini$VWAP.UD <- ifelse(E.mini$ES.Close>E.mini$ES.VWAP,1,0)

# # Calculate Slop for MA's
# E.mini$EMA5.Slope <- (E.mini$EMA5-lag(E.mini$EMA5,5))/5
# E.mini$EMA8.Slope <- (E.mini$EMA5-lag(E.mini$EMA5,8))/8
# E.mini$SMA20.Slope <- (E.mini$SMA20-lag(E.mini$SMA20,20))/20
# E.mini$SMA50.Slope <- (E.mini$SMA50-lag(E.mini$SMA50,50))/50
# E.mini$SMA100.Slope <- (E.mini$SMA100-lag(E.mini$SMA100,100))/100
# E.mini$SMA200.Slope <- (E.mini$SMA200-lag(E.mini$SMA200,200))/200
# 
# # Above SMA's
# E.mini$Cl.EMA5 <- (E.mini$ES.Close-E.mini$EMA5)/E.mini$EMA5
# E.mini$Cl.EMA8 <- (E.mini$ES.Close-E.mini$EMA8)/E.mini$EMA8
# E.mini$Cl.SMA20 <- (E.mini$ES.Close-E.mini$SMA20)/E.mini$SMA20
# E.mini$Cl.SMA50 <- (E.mini$ES.Close-E.mini$SMA50)/E.mini$SMA50
# E.mini$Cl.SMA100 <- (E.mini$ES.Close-E.mini$SMA100)/E.mini$SMA100
# E.mini$Cl.SMA200 <- (E.mini$ES.Close-E.mini$SMA200)/E.mini$SMA200

# Calculate the rdiff in OHLC
E.mini$ES.Open <- (E.mini$ES.Open-lag(E.mini$ES.Open,1))/lag(E.mini$ES.Open,1)
E.mini$ES.High <- (E.mini$ES.High-lag(E.mini$ES.High,1))/lag(E.mini$ES.High,1)
E.mini$ES.Low <- (E.mini$ES.Low-lag(E.mini$ES.Low,1))/lag(E.mini$ES.Low,1)
#E.mini$ES.Vol <- (E.mini$ES.Volume-lag(E.mini$ES.Volume,1))/lag(E.mini$ES.Volume,1)
E.mini$ES.PP <- (E.mini$ES.PP-lag(E.mini$ES.PP,1))/lag(E.mini$ES.PP,1)

# Find Returns for Day & +1 Day
E.mini$Ret <- (E.mini$ES.Close-lag(E.mini$ES.Close,1))/lag(E.mini$ES.Close,1)
# E.mini$Ret1 <- (lag(ES$ES.Adjusted,-1)-ES$ES.Adjusted)/ES$ES.Adjusted
# ES$Ret2 <- (lag(ES$ES.Adjusted,-2)-ES$ES.Adjusted)/ES$ES.Adjusted
# ES$Ret3 <- (lag(ES$ES.Adjusted,-3)-ES$ES.Adjusted)/ES$ES.Adjusted

# Separate Returns
#Returns <- (ES$ES.Close-lag(ES$ES.Close,1))/lag(ES$ES.Close,1)
#Returns$Ret1 <- (lag(ES$ES.Close,-1)-ES$ES.Close)/ES$ES.Close
#Returns$Ret2 <- (lag(ES$ES.Adjusted,-2)-ES$ES.Adjusted)/ES$ES.Adjusted
#Returns$Ret3 <- (lag(ES$ES.Adjusted,-3)-ES$ES.Adjusted)/ES$ES.Adjusted
#Returns$Ret4 <- (lag(ES$ES.Adjusted,-4)-ES$ES.Adjusted)/ES$ES.Adjusted
#Returns$Ret5 <- (lag(ES$ES.Adjusted,-5)-ES$ES.Adjusted)/ES$ES.Adjusted

# Binary Function YCL > 200SMA 
E.mini$RSI.OB <- ifelse(E.mini$RSI2>90, 1, 0)

# Binary Function YCL > 100SMA
E.mini$RSI.OS <- ifelse(E.mini$RSI2<10, 1, 0)

# Binary Function YCL > 50SMA
# ES$CL_SMA50 <- ifelse(ES$ES.Close>ES$SMA50, 1, 0)

# Binary Function YCL > 20SMA
# ES$CL_SMA20 <- ifelse(ES$ES.Close>ES$SMA20, 1, 0)

# # Binary Function YCL > UBB
# E.mini$CL_UBB2 <- ifelse(E.mini$ES.Close>E.mini$up, 1, 0)
# E.mini$CL_UBB3 <- ifelse(E.mini$ES.Close>E.mini$up.1, 1, 0)
# E.mini$mavg <- NULL
# 
# # Binary Function YCL < UBB
# E.mini$CL_LBB2 <- ifelse(E.mini$ES.Close<E.mini$dn, 1, 0)
# E.mini$CL_LBB3 <- ifelse(E.mini$ES.Close<E.mini$dn.1, 1, 0)
# E.mini$mavg.1 <- NULL
# 
# Remove Unnecessary columns
E.mini$ES.Mid <- NULL
E.mini$ES.Close <- NULL
#E.mini$ES.Adjusted <- NULL
E.mini$ES.Volume <- NULL
E.mini$ES.Gaps <- NULL
# E.mini$EMA5 <- NULL
# E.mini$EMA8 <- NULL
# E.mini$SMA200 <- NULL
# E.mini$SMA100 <- NULL
# E.mini$SMA50 <- NULL
# E.mini$SMA20 <- NULL
# E.mini$E.mini <- NULL
E.mini$ES.VWAP <- NULL
E.mini$dn <- NULL
E.mini$up <- NULL
E.mini$dn.1 <- NULL
E.mini$up.1 <- NULL

E.mini$ES.R1 <- NULL
E.mini$ES.R2 <- NULL
E.mini$ES.R3 <- NULL
E.mini$ES.S1 <- NULL
E.mini$ES.S2 <- NULL
E.mini$ES.S3 <- NULL

# # Import NYSE Adv/Dec 
# NYSE <- Quandl("URC/NYSE_ADV", trim_start="2013-10-10", type="xts",
#                authcode="Wp68Bux85C874pBHCnNC")
# colnames(NYSE) <- c("NYSE.Adv")
# 
# NYSE$NYSE.Dec <-  Quandl("URC/NYSE_DEC", trim_start="1997-09-10", type="xts",
#                          authcode="Wp68Bux85C874pBHCnNC")
# #colnames(NYSE.Dec) <- c("NYSE.Dec")
# 
# NYSE$NYSE.AD.Ratio <- NYSE$NYSE.Adv/NYSE$NYSE.Dec
# 
# E.mini <- merge.xts(E.mini,NYSE$NYSE.AD.Ratio, all=FALSE)
# 
# VIX <- Quandl("CBOE/VIX",trim_start="2013-10-10", authcode="Wp68Bux85C874pBHCnNC", 
#               type="xts", transformation="rdiff")
# VIX <- VIX[,4]
# names(VIX) <- "VIX"
# 
# E.mini <- merge.xts(E.mini, VIX, all=FALSE)

# Separate out Adjusted Close for ES2 & convert to df for prediction use
#ES2 <- ES$ES.Adjusted[nrow(ES)]
E.mini.df <- data.frame(Date=index(E.mini),coredata(E.mini))
#ES2$Date

# Set Predictors as Factors
E.mini.df$Hi.YHI <- as.factor(E.mini.df$Hi.YHI)
E.mini.df$Lo.YLO <- as.factor(E.mini.df$Lo.YLO)
E.mini.df$Hi.YHI1 <- as.factor(E.mini.df$Hi.YHI1)
E.mini.df$Lo.YLO1 <- as.factor(E.mini.df$Lo.YLO1)
E.mini.df$Cl.YHI <- as.factor(E.mini.df$Cl.YHI)
E.mini.df$Cl.YLO <- as.factor(E.mini.df$Cl.YLO)
E.mini.df$Up.Trend <- as.factor(E.mini.df$Up.Trend)
E.mini.df$Down.Trend <- as.factor(E.mini.df$Down.Trend)
E.mini.df$VWAP.UD <- as.factor(E.mini.df$VWAP.UD)
E.mini.df$RSI.OB <- as.factor(E.mini.df$RSI.OB)
E.mini.df$RSI.OS <- as.factor(E.mini.df$RSI.OS)
# E.mini.df$CL_UBB2 <- as.factor(E.mini.df$CL_UBB2)
# E.mini.df$CL_UBB3 <- as.factor(E.mini.df$CL_UBB3)
# E.mini.df$CL_LBB2 <- as.factor(E.mini.df$CL_LBB2)
# E.mini.df$CL_LBB3 <- as.factor(E.mini.df$CL_LBB3)

#E.mini.df <- na.omit(E.mini.df)

E.mini.df$ES.Open.Proj <- NULL
E.mini.df$ES.Count <- NULL

# Divide into train & test
train.pp.df <- E.mini.df[1:(nrow(E.mini.df)-42),]
test.pp.df <- E.mini.df[(nrow(E.mini.df)-42):(nrow(E.mini.df)),]

# Classification LR model binomial
# HiYHI
E.mini.hi.glm <- glm(Hi.YHI1~.-Down.Trend1-Up.Trend1-Lo.YLO1-PP.Tag1-R1.Tag1-R2.Tag1-
                       R3.Tag1-S1.Tag1-S2.Tag1-S3.Tag1-Mid.Tag1-Gap1,train.pp.df,family="binomial")
E.mini.hi.train.probs <- predict(E.mini.hi.glm,type="response")
E.mini.hi.test.probs <- predict(E.mini.hi.glm,newdata=test.pp.df,type="response")

#Gap
E.mini.gap.glm <- glm(Gap1~.-Down.Trend1-Up.Trend1-Lo.YLO1-PP.Tag1-R1.Tag1-R2.Tag1-
                        R3.Tag1-S1.Tag1-S2.Tag1-S3.Tag1-Mid.Tag1-Hi.YHI1,train.pp.df,family="binomial")
E.mini.gap.train.probs <- predict(E.mini.gap.glm,type="response")
E.mini.gap.test.probs <- predict(E.mini.gap.glm,newdata=test.pp.df,type="response")

#LoYLO
E.mini.lo.glm <- glm(Lo.YLO1~.-Hi.YHI1-Down.Trend1-Up.Trend1-PP.Tag1-R1.Tag1-R2.Tag1-
                       R3.Tag1-S1.Tag1-S2.Tag1-S3.Tag1-Mid.Tag1-Gap1,train.pp.df,family="binomial")
E.mini.lo.train.probs <- predict(E.mini.lo.glm,type="response")
E.mini.lo.test.probs <- predict(E.mini.lo.glm,newdata=test.pp.df,type="response")

#Mid
E.mini.mid.glm <- glm(Mid.Tag1~.-Lo.YLO1-Hi.YHI1-Down.Trend1-Up.Trend1-PP.Tag1-R1.Tag1-
                        R2.Tag1-R3.Tag1-S1.Tag1-S2.Tag1-S3.Tag1-Gap1,train.pp.df,family="binomial")
E.mini.mid.train.probs <- predict(E.mini.mid.glm,type="response")
E.mini.mid.test.probs <- predict(E.mini.mid.glm,newdata=test.pp.df,type="response")

#Up.Trend
E.mini.up.glm <- glm(Up.Trend1~.-Down.Trend1-Hi.YHI1-Lo.YLO1-PP.Tag1-R1.Tag1-R2.Tag1-
                       R3.Tag1-S1.Tag1-S2.Tag1-S3.Tag1-Mid.Tag1-Gap1,train.pp.df,family="binomial")
E.mini.up.train.probs <- predict(E.mini.up.glm,type="response")
E.mini.up.test.probs <- predict(E.mini.up.glm,newdata=test.pp.df,type="response")

#Down.Trend
E.mini.down.glm <- glm(Down.Trend1~.-Up.Trend1-Hi.YHI1-Lo.YLO1-PP.Tag1-R1.Tag1-R2.Tag1-
                         R3.Tag1-S1.Tag1-S2.Tag1-S3.Tag1-Mid.Tag1-Gap1,train.pp.df,family="binomial")
E.mini.down.train.probs <- predict(E.mini.down.glm,type="response")
E.mini.down.test.probs <- predict(E.mini.down.glm,newdata=test.pp.df,type="response")

## PP
E.mini.pp.glm <- glm(PP.Tag1~.-Down.Trend1-Up.Trend1-Hi.YHI1-Lo.YLO1-R1.Tag1-R2.Tag1-
                       R3.Tag1-S1.Tag1-S2.Tag1-S3.Tag1-Mid.Tag1-Gap1,train.pp.df,family="binomial")
E.mini.pp.train.probs <- predict(E.mini.pp.glm,type="response")
E.mini.pp.test.probs <- predict(E.mini.pp.glm,newdata=test.pp.df,type="response")

## R1
E.mini.r1.glm <- glm(R1.Tag1~.-Down.Trend1-Up.Trend1-Hi.YHI1-Lo.YLO1-PP.Tag1-R2.Tag1-
                       R3.Tag1-S1.Tag1-S2.Tag1-S3.Tag1-Mid.Tag1-Gap1,train.pp.df,family="binomial")
E.mini.r1.train.probs <- predict(E.mini.r1.glm,type="response")
E.mini.r1.test.probs <- predict(E.mini.r1.glm,newdata=test.pp.df,type="response")

## R2
E.mini.r2.glm <- glm(R2.Tag1~.-Down.Trend1-Up.Trend1-Hi.YHI1-Lo.YLO1-PP.Tag1-R1.Tag1-R2.Tag1-
                       R3.Tag1-S1.Tag1-S2.Tag1-S3.Tag1-Mid.Tag1-Gap1,train.pp.df,family="binomial")
E.mini.r2.train.probs <- predict(E.mini.r2.glm,type="response")
E.mini.r2.test.probs <- predict(E.mini.r2.glm,newdata=test.pp.df,type="response")

## R3
E.mini.r3.glm <- glm(R3.Tag1~.-Down.Trend1-Up.Trend1-Hi.YHI1-Lo.YLO1-PP.Tag1-R1.Tag1-R2.Tag1-
                       S1.Tag1-S2.Tag1-S3.Tag1-Mid.Tag1-Gap1,train.pp.df,family="binomial")
E.mini.r3.train.probs <- predict(E.mini.r3.glm,type="response")
E.mini.r3.test.probs <- predict(E.mini.r3.glm,newdata=test.pp.df,type="response")

## S1
E.mini.s1.glm <- glm(S1.Tag1~.-Down.Trend1-Up.Trend1-Hi.YHI1-Lo.YLO1-PP.Tag1-R1.Tag1-R2.Tag1-
                       R3.Tag1-S2.Tag1-S3.Tag1-Mid.Tag1-Gap1,train.pp.df,family="binomial")
E.mini.s1.train.probs <- predict(E.mini.s1.glm,type="response")
E.mini.s1.test.probs <- predict(E.mini.s1.glm,newdata=test.pp.df,type="response")

## S2
E.mini.s2.glm <- glm(S2.Tag1~.-Down.Trend1-Up.Trend1-Hi.YHI1-Lo.YLO1-PP.Tag1-R1.Tag1-R2.Tag1-
                       R3.Tag1-S1.Tag1-S3.Tag1-Mid.Tag1-Gap1,train.pp.df,family="binomial")
E.mini.s2.train.probs <- predict(E.mini.s2.glm,type="response")
E.mini.s2.test.probs <- predict(E.mini.s2.glm,newdata=test.pp.df,type="response")

## S3
E.mini.s3.glm <- glm(S3.Tag1~.-Down.Trend1-Up.Trend1-Hi.YHI1-Lo.YLO1-PP.Tag1-R1.Tag1-R2.Tag1-
                       R3.Tag1-S1.Tag1-S2.Tag1-Mid.Tag1-Gap1,train.pp.df,family="binomial")
E.mini.s3.train.probs <- predict(E.mini.s3.glm,type="response")
E.mini.s3.test.probs <- predict(E.mini.s3.glm,newdata=test.pp.df,type="response")

## PREDICTIONS

# Dates
tail(test.pp.df$Date,2)

# Hi Lo Mid
tail(E.mini.hi.test.probs,2)
tail(round(E.mini.lo.test.probs,4),2)
tail(round(E.mini.mid.test.probs,4),2)

# Close 
tail(E.mini.up.test.probs,2)
tail(E.mini.down.test.probs,2)

# Gap
tail(E.mini.gap.test.probs,2)

## PP
tail(E.mini.pp.test.probs,2)
tail(E.mini.r1.test.probs,2)
tail(E.mini.r2.test.probs,2)
tail(E.mini.r3.test.probs,2)
tail(E.mini.s1.test.probs,2)
tail(E.mini.s2.test.probs,2)
tail(E.mini.s3.test.probs,2)

# Save data
E.mini.archive <- data.frame(Sys.Date(), tail(E.mini.hi.test.probs,1), tail(E.mini.lo.test.probs,1),
                             tail(E.mini.mid.test.probs,1), tail(E.mini.up.test.probs,1),
                             tail(E.mini.down.test.probs,1), tail(E.mini.pp.test.probs,1),
                             tail(E.mini.r1.test.probs,1), tail(E.mini.r2.test.probs,1),
                             tail(E.mini.r3.test.probs,1), tail(E.mini.s1.test.probs,1),
                             tail(E.mini.s2.test.probs,1), tail(E.mini.s3.test.probs,1))
names(E.mini.archive) <- c("Date","YHI","YLO","YMID","UP","DOWN","PP","R1","R2","R3","S1","S2","S3")

write.table(E.mini.archive, file="E_mini_probs.csv", append=TRUE, col.names=FALSE)

# Consolidate all the predictions
E.mini.all.probs <- data.frame(E.mini.hi.test.probs,E.mini.lo.test.probs,E.mini.mid.test.probs,
                               E.mini.up.test.probs,E.mini.down.test.probs,E.mini.gap.test.probs,
                               E.mini.pp.test.probs,E.mini.r1.test.probs,E.mini.r2.test.probs,
                               E.mini.r3.test.probs,E.mini.s1.test.probs,E.mini.s2.test.probs,
                               E.mini.s3.test.probs)

E.mini.max.probs <- colnames(E.mini.all.probs)[apply(E.mini.all.probs,1,which.max)]
E.mini.max.probs.df <- data.frame(test.pp.df$Date,E.mini.max.probs)
names(E.mini.max.probs.df) <- c("Date","PROBS")
# PROB.COL <- xts(E.mini.max.probs.df$PROBS,order.by = E.mini.max.probs.df$Date)
# names(PROB.COL) <- "PROB"

# TEST ES distance from Open
ES.test <- ES 

ES.test$Op.Hi <- ES$ES.Open-lag(ES$ES.High,1)
ES.test$Op.Lo <- ES$ES.Open-lag(ES$ES.Low,1)
ES.test$Op.PP <- ES$ES.Open-lag(ES$ES.PP,1)
ES.test$Op.Close <- ES$ES.Open-lag(ES$ES.Close,1)
ES.test$Op.Mid <- ES$ES.Open-lag(ES$ES.Mid,1)
ES.test$Op.R1 <- ES$ES.Open-lag(ES$ES.R1,1)
ES.test$Op.R2 <- ES$ES.Open-lag(ES$ES.R2,1)
ES.test$Op.R3 <- ES$ES.Open-lag(ES$ES.R3,1)
ES.test$Op.S1 <- ES$ES.Open-lag(ES$ES.S1,1)
ES.test$Op.S2 <- ES$ES.Open-lag(ES$ES.S2,1)
ES.test$Op.S3 <- ES$ES.Open-lag(ES$ES.S3,1)

ES.test$Hi.YHI <- E.mini$Hi.YHI
ES.test$Lo.YLO <- E.mini$Lo.YLO
ES.test$Up.Trend <- E.mini$Up.Trend
ES.test$Down.Trend <- E.mini$Down.Trend
ES.test$Mid.Tag <- E.mini$Mid.Tag
ES.test$Gap.Tag <- E.mini$Gap
ES.test$PP.Tag <- E.mini$PP.Tag
ES.test$R1.Tag <- E.mini$R1.Tag
ES.test$R2.Tag <- E.mini$R2.Tag
ES.test$R3.Tag <- E.mini$R3.Tag
ES.test$S1.Tag <- E.mini$S1.Tag
ES.test$S2.Tag <- E.mini$S2.Tag
ES.test$S3.Tag <- E.mini$S3.Tag

ES.test <- window(ES.test, start=head(test.pp.df$Date,1))
ES.test.df <- data.frame(Date=index(ES.test), coredata(ES.test))
ES.test.df <- merge(ES.test.df, E.mini.max.probs.df)

write.table(ES.test.df,file="ES_test_df.csv", append=TRUE, col.names=FALSE)

# TEST
table(test.pp.df$Hi.YHI, E.mini.hi.test.probs>.50)
table(test.pp.df$Lo.YLO, E.mini.lo.test.probs>.50)
table(test.pp.df$Mid.Tag, E.mini.mid.test.probs>.50)
table(test.pp.df$Up.Trend, E.mini.up.test.probs>.50)
table(test.pp.df$Down.Trend, E.mini.down.test.probs>.50)
table(test.pp.df$PP.Tag, E.mini.pp.test.probs>.50)
table(test.pp.df$Gap, E.mini.gap.test.probs>.50)
