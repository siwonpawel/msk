#!/usr/bin/python3

import matplotlib.pyplot as plt
import pandas as pd

df0 = pd.read_csv('data0.csv')
df0005 = pd.read_csv('data0.005.csv')
df002 = pd.read_csv('data0.02.csv')

# plot
plt.xlabel('delayB')
plt.ylabel('value')

plt.plot(df0['delayB'], df0['(RTT ratio)2'], label='df0')

plt.plot(df0['delayB'], df0['goodput ratio'], label='df0')
plt.plot(df002['delayB'], df002['goodput ratio'], label='df002')
plt.plot(df0005['delayB'], df0005['goodput ratio'], label='df0005')

plt.plot(df0['delayB'], df0['goodput ratio'])


plt.legend(["0", "02", "0005"])
plt.show()