# Discussion

The primary enquiry concerned the feasibility of simulating the movement of students between the halls of the C-2 building. However, it
was swiftly determined that this endeavour would necessitate a substantial investment of time and resources, which was deemed to be
beyond the available timeframe. Consequently, the focus was shifted to the simulation of the academic community's movement within the
university campus.

Following the modification of the project assumptions, the feasibility of executing a flow simulation in accordance with the stipulated
timetable was called into question. In order to address this query, it is imperative to obtain information pertaining to the timetable,
including the number of students residing in the building's halls. The USOS system is capable of providing such data; however, the
process of acquiring it would be excessively time-consuming. This is attributable to the random nature of the URLs associated with the
timetables of individual subjects.

The analysis of crowd flow on campus gives rise to a significant hardware concern: namely, the capacity of our computing devices to
simulate such a substantial number of agents.During the course of the experiments, it was observed that the simulation of over 1,000
agents concurrently resulted in a substantial increase in system load and a decline in performance (to less than 10 frames per second).
Furthermore, it was observed that performance degradation was particularly pronounced in scenarios characterised by high agent density,
as evidenced in [@fig:godot-stuck]. This figure depicts the performance of 630 agents navigating a map, where a clear decline in
performance is evident.
