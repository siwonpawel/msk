#!/usr/bin/python3

import nstrace
import matplotlib.pyplot as plt

times = []
values = []

nstrace.nsopen('basic1.tr')
while not nstrace.isEOF():
    if nstrace.isVar():
        (time, srcNode, srcFlowId, destNode, destFlowId, name, value) = nstrace.getVar()
        if name == "cwnd_":
            times.append(time)
            values.append(value)
    else:
        nstrace.skipline()

plt.plot(times, values, 'ro')
plt.show()



