## Framework

In order to enhance the robustness and realism of the simulation, a
sophisticated pathfinding algorithm was employed. This approach represented a
significant enhancement over the previously discussed methodology that relied on
raycasts, shown in [@fig:godot-raycast], thereby enabling more efficient and
optimal crowd movement, particularly in complex scenarios. The integration of
AStar and Corridor-funnel path post-processing played a pivotal role in the
implementation of pathfinding.

In order to leverage pathfinding, it is first necessary to model the Navigation Region.
It was created within the environment by combining multiple Navigation Obstacles. In some
parts of Navigation Region Collision Polygons were utilized to model Bottlenecks more
realistically. The collision shapes ensure that each agent has an awareness of its
surroundings, thus allowing for smooth navigation through obstacles and other agents.

In the initial stage, the pathfinding algorithm is triggered as soon as an agent
is spawned in the simulation. The algorithm calculates a precise path, presented
in [@fig:godot-paths] by dividing the environment into manageable segments. Each
agent is then tasked with navigating to the next designated point along this
path, ensuring steady progress towards its final destination. This stepwise
approach not only simplifies the navigation process but also enhances
performance by breaking down complex paths into smaller, more manageable
segments.

![The initial common path was updated to avoid collisions between agents](images/godot-paths.png){#fig:godot-paths}

Moreover, the raycast methodology is maintained as an ancillary system to
enhance interactions between agents and to achieve current targets along the
designated path. While pathfinding directs agents along optimal routes, raycasts
augment their capacity to respond to immediate, short-range interactions, such
as avoiding collisions or dynamically adjusting their paths based on proximate
agents. This dual-system approach amalgamates the strengths of long-range
planning with real-time responsiveness.

Due to the high computational cost of ray-casting, which significantly slowed down the
simulation speed, we made a number of optimizations and improvements to the model to make 
it more efficient for advanced scenarios. We utilized caching to store the results of
heuristic calculations and agent speed, thereby reducing the number of calculations and
enhancing the overall efficiency of the system. This optimization was particularly
beneficial in scenarios with a large number of agents or collision shapes, where the
computational cost of ray-casting was particularly high.

The entire simulation was developed using Godot 4.3, a game engine that has been
demonstrated to be well-suited for handling the computational and graphical
demands of such projects. Godot provides a native implementation of collisions, which
was adapted and integrated into the system. Furthermore, custom raycast functionality
was implemented in order to align with the unique requirements of the simulation.
These customisations were essential for achieving the desired level of precision and
realism in agent behaviour.

The efficacy and realism of the simulation have been enhanced to a considerable
degree by the integration of pathfinding and raycasts for local
interactions. This methodology guarantees that agents can navigate complex
environments with ease, whilst maintaining dynamic, responsive interactions with
their surroundings and other agents.

![Raycasts may be considered as a means of representing the field of view of an agent](images/godot-raycast.png){#fig:godot-raycast}
