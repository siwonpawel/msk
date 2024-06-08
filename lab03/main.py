#!/usr/bin/python3

import matplotlib.pyplot as plt
import pandas as pd

# convert string to Pandas DataFrame
df = pd.read_csv('data.csv')

# plot
plt.plot(df['delayB'], df['goodput ratio'])
plt.plot(df['delayB'], df['(RTT ratio)^2'])

plt.xlabel('delayB')
plt.ylabel('value')
plt.show()

