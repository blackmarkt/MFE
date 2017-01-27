#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Oct  4 16:55:41 2016

@author: markblack
"""

from numpy import *

# Variables
M = 4000
p = 250
k = .01012
t = 210

# Find A
A = (M - p)/p

# Find Logistic Model
P = M/(1 + A * exp(-k * t))

print ("After %i years the population will be %.2f" %(t,P))