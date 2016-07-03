import pandas as pd
import os
from myunzip import unzip
import numpy as np
from urllib import urlretrieve

# Lists of underlying
forex = ['AUDUSD', 'EURJPY', 'EURUSD', 'GBPUSD', 'USDJPY']
futures =['ES', 'NQ', 'TF', 'YM']
symbols = forex + futures
symbols.sort()

download = False
n = 5

# Build lists of areas, ranges, and points
ranges = ['OIR', 'OOR']
areas = ['a4', 'a3', 'a2', 'a1', 'b1', 'b2', 'b3', 'b4']
directions = ['bull', 'bear']
points = ['r3', 'r2', 'r1', 'pp', 's1', 's2', 's3']
timeFrames = ['d', 'w']
midAreas = ['ma2', 'ma1', 'mb1', 'mb2']
midPoints = ['LHi', 'LMid', 'LLo']

denominators = []
for opening in ranges:
    for area in areas:        
        for direc in directions:
            denominators.append(opening + '.' + area + '.' + direc)

events = []
for opening in ranges:
    for area in areas:
        for point in points:
            events.append(opening + '.' + area + point)

midDenominators = []
for opening in ranges:
    for area in midAreas:        
        for direc in directions:
            denominators.append(opening + '.' + area + '.' + direc)
            
midEvents = []
for opening in ranges:
    for area in midAreas:
        for point in midPoints:
            events.append(opening + '.' + area + point)
 
# Create empty probability table            
allEvents = []
for opening in ranges:
    for frame in timeFrames:
        for area in areas:
            for point in points:
                    allEvents.append(opening + '.' + area + point +  '.' + frame)     
for opening in ranges:
    for frame in timeFrames:
        for area in midAreas:
            for point in midPoints:
                    allEvents.append(opening + '.' + area + point +  '.' + frame)   
allEvents.sort()        
ProbTable = pd.DataFrame(index = symbols, columns = allEvents)
ProbTable = ProbTable.fillna(0)


# Function for calculating pivot points
def calcPivotPoints (dataFrame):
    dataFrame['pp'][1::] = (dataFrame['High'][:-1] + 
                       dataFrame['Low'][:-1] +
                       dataFrame['Close'][:-1]) / 3
    a = 2 * dataFrame['pp'][1:]
    b = dataFrame['Low'].shift(1)
    c = b[1:]
    dataFrame['r1'][1:] = a - c
    b = dataFrame['High'].shift(1)
    c = b[1:]
    dataFrame['s1'][1:] = a - c
    dataFrame['r2'] = dataFrame['pp'] - dataFrame['s1'] + dataFrame['r1']
    dataFrame['s2'] = dataFrame['pp'] - dataFrame['r1'] + dataFrame['s1']
    dataFrame['r3'] = dataFrame['pp'] - dataFrame['s2'] + dataFrame['r2']
    dataFrame['s3'] = dataFrame['pp'] - dataFrame['r2'] + dataFrame['s2']
    
# Function for calculating denominators
def calcDenominators (dataFrame, areas, points):    
    for opening in ranges:
        for area in areas:
            for direction in directions:
                tag = opening + '.' + area + '.' + direction
                if areas.index(area) == 0:
                    floor = points[0]
                    if direction == 'bull':
                        dataFrame[tag] = 1 * ((dataFrame[opening] == 1) & 
                                              ((dataFrame['Open'] > dataFrame[floor]) | 
                                               np.isclose(dataFrame['Open'],dataFrame[floor])))
                    else:
                        dataFrame[tag] = 1 * ((dataFrame[opening] == 1) & (dataFrame['Open'] > dataFrame[floor]))
                elif areas.index(area) == (len(areas) -1):
                    ceiling = points[(len(points)-1)]
                    if direction == 'bull':
                        dataFrame[tag] = 1 * ((dataFrame[opening] == 1) & 
                                              (dataFrame['Open'] < dataFrame[ceiling]))
                    else:
                        dataFrame[tag] = 1 * ((dataFrame[opening] == 1) & 
                                              ((dataFrame['Open'] < dataFrame[ceiling]) | 
                                               np.isclose(dataFrame['Open'], dataFrame[ceiling])))
                else:
                    floor = points[areas.index(area)]
                    ceiling = points[(areas.index(area) - 1)]
                    if direction == 'bull':
                        dataFrame[tag] = 1 * ((dataFrame[opening] == 1) & 
                                         ((dataFrame['Open'] > dataFrame[floor]) | 
                                          np.isclose(dataFrame['Open'], dataFrame[floor])) & 
                                          (dataFrame['Open'] < dataFrame[ceiling]))
                    else:
                        dataFrame[tag] = 1 * ((dataFrame[opening] == 1) & 
                                         (dataFrame['Open'] > dataFrame[floor]) & 
                                          ((dataFrame['Open'] < dataFrame[ceiling]) | 
                                           np.isclose(dataFrame['Open'], dataFrame[ceiling])))

# Function for calculating tags for hitting points from areas
def calcEvents (dataframe, areas, points):
    for opening in ranges:
        for area in areas:
            for point in points:
                ref = point
                event = opening + '.' + area + point
                if areas.index(area) <= points.index(point):
                    cond = opening + '.' + area + '.bear'
                    dataframe[event] = 1 * ((dataframe[cond] == 1) &
                                            ((dataframe['Low'] < dataframe[ref]) | 
                                             np.isclose(dataframe['Low'], dataframe[ref])))
                else:
                    cond = opening + '.' + area+ '.bull'
                    dataframe[event] = 1 * ((dataframe[cond] == 1) &
                                       ((dataframe['High'] > dataframe[ref]) | 
                                        np.isclose(dataframe['High'], dataframe[ref])))
                                        
# Function for calculating the the probabilities for hitting points from areas
def calcProbs (dataFrame, areas, points, symbol, frame):
    for opening in ranges:
        for area in areas:
            for point in points:
                eventIn = opening + '.' + area + point
                eventOut = opening + '.' + area + point + frame
                if areas.index(area) <= points.index(point):
                    cond = opening + '.' + area + '.bear'
                else:
                    cond = opening + '.' + area + '.bull'
                num = dataFrame[eventIn].sum()
                den = dataFrame[cond].sum()
                if 0 < den < n:
                    ProbTable[eventOut][symbol] = 'insf'
                elif den != 0:
                    ProbTable[eventOut][symbol] = 1.0 * num / den
                elif (num != 0 & den == 0):
                    ProbTable[eventOut][symbol] = 'err'
                else:
                    ProbTable[eventOut][symbol] = 'insf'


# Download forex data
for i in forex:
    saveFile = i + "/" + i + "_day.zip"
    if download:
        # Check for directory, make directory if it doesn't exist
        if not os.path.exists(i):
            os.makedirs(i)
        
        # Download file
        getFile = "http://www.fxhistoricaldata.com/download/" + i + "?t=day"
        urlretrieve(getFile, saveFile)
            
    # Unzip file
    saveFile = i + "/" + i + "_day.zip"
    assetDir = i + "/"
    unzip(saveFile, assetDir)
    
    # Clean data
    assetCSV = i + "/" + i + "_day.csv"
    data = pd.read_csv(assetCSV)
    drops = ['<TICKER>', '<TIME>']
    for column in drops:
        del data[column]
    data.columns = ['Date', 'Open', 'Low', 'High', 'Close']
    data = data.reindex_axis(['Date', 'Open', 'High', 'Low', 'Close'], axis = 1)
    data.to_csv(assetCSV, index = False)
    
# Prep futures data
for i in futures:
    # Check for directory, make directory if it doesn't exist
    if not os.path.exists(i):
        os.makedirs(i)
        
    # Clean data
    assetTXT = i + "/" + i + ".txt"
    data = pd.read_table(assetTXT, sep = ',')
    drops = ['Symbol', 'SIG', 'PVPT', 'PVPT.1', 'PVPT.2', 'PVPT.3', 'PVPT.4', 'PVPT.5', 'PVPT.6', 'POS', 'Volume']
    for column in drops:
        del data[column]
    data.columns = ['Date', 'Open', 'High', 'Low', 'Close']
    assetCSV = i + "/" + i + "_day.csv"
    data.to_csv(assetCSV, index = False)

# Process data
for i in symbols:    
    # Read csv data and index by datetime
    assetCSV = i + "/" + i + "_day.csv"
    data.d = pd.read_csv(assetCSV, 
                        parse_dates = {'Timestamp' : ['Date']}, 
                        index_col = 'Timestamp')
    data.temp = pd.read_csv(assetCSV, 
                        parse_dates = {'Timestamp' : ['Date']}, 
                        index_col = 'Timestamp')
                        
    # Calculate daily pivot points
    for point in points:
        data.d[point] = np.nan 
    calcPivotPoints(data.d)
    
    # Calculate daily ranges
    data.d['LHi'] = np.nan
    data.d['LMid'] = np.nan
    data.d['LLo'] = np.nan
    data.d['OIR'] = np.nan
    data.d['OOR'] = np.nan
    b = data.d['High'].shift(1) 
    data.d['LHi'][1:] = b[1:]
    b = data.d['Low'].shift(1) 
    data.d['LLo'][1:] = b[1:]
    data.d['LMid'] = ((data.d['LHi'] + data.d['LLo']) / 2)
    data.d['OIR'][1:] = 1 * ((data.d['LLo'][1:] < data.d['Open'][1:]) & (data.d['Open'][1:] < data.d['LHi'][1:]))
    data.d['OOR'][1:] = 1 * (data.d['OIR'][1:] != 1)
    
    
    # Resample daily data to create weekly data
    weekly_open = data.temp['Open'].resample('W', how = 'first')
    weekly_high = data.temp['High'].resample('W', how='max')
    weekly_low = data.temp['Low'].resample('W', how='min')
    weekly_close = data.temp['Close'].resample('W', how = 'last')
    data.w = pd.DataFrame(weekly_open)
    data.w.columns = ['Open']
    data.w['High'] = weekly_high
    data.w['Low'] = weekly_low
    data.w['Close'] = weekly_close
    
    # Calculate weekly pivot points
    for point in points:
        data.w[point] = np.nan
    calcPivotPoints(data.w)
    
    #  Calculate weekly ranges
    data.w['LHi'] = np.nan
    data.w['LMid'] = np.nan
    data.w['LLo'] = np.nan
    data.w['OIR'] = np.nan
    data.w['OOR'] = np.nan
    b = data.w['High'].shift(1) 
    data.w['LHi'][1:] = b[1:]
    b = data.w['Low'].shift(1) 
    data.w['LLo'][1:] = b[1:]
    data.w['LMid'] = ((data.w['LHi'] + data.w['LLo']) / 2)
    data.w['OIR'][1:] = 1 * ((data.w['LLo'][1:] < data.w['Open'][1:]) & (data.w['Open'][1:] < data.w['LHi'][1:]))
    data.w['OOR'][1:] = 1 * (data.w['OIR'][1:] != 1)

    # Calculate daily and weekly denominators (pivot points)
    for denominator in denominators:
        data.d[denominator] = np.nan
        data.w[denominator] = np.nan
    calcDenominators(data.d, areas, points)
    calcDenominators(data.w, areas, points)
    
    # Calculate daily and weekly denominators (mid points)
    for denominator in midDenominators:
        data.d[denominator] = np.nan
        data.w[denominator] = np.nan
    calcDenominators(data.d, midAreas, midPoints)
    calcDenominators(data.w, midAreas, midPoints)
    
    # Calculate daily and weekly events (pivot points)
    for event in events:
        data.d[event] = np.nan
        data.w[event] = np.nan
    calcEvents(data.d, areas, points)
    calcEvents(data.w, areas, points)
    
    # Calculate daily and weekly events (mid points)
    for event in midEvents:
        data.d[event] = np.nan
        data.w[event] = np.nan
    calcEvents(data.d, midAreas, midPoints)
    calcEvents(data.w, midAreas, midPoints)
    
    # Calculate probabilities 
    calcProbs(data.d, areas, points, i, '.d')
    calcProbs(data.d, midAreas, midPoints, i, '.d')
    calcProbs(data.w, areas, points, i, '.w')
    calcProbs(data.w, midAreas, midPoints, i, '.w')
                    
    # Write data frame to csv file
    daily =  i + "/" + i + "_daily.csv"
    weekly =  i + "/" + i + "_weekly.csv"
    data.d.to_csv(daily, index = True)
    data.w.to_csv(weekly, index = True)
    
# Write probability table to csv file
ProbTable.to_csv('historic_probabilities.csv', index = True)
