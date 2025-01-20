# State of the art

## Crowd dynamics modelling

In recent years, there has been a considerable advancement in the field of crowd simulation models. Microscopic models have witnessed a surge in popularity, displacing macroscopic models based on hydrodynamic principles (e.g. the Pauls model) [@was2011modelowanie]. The adoption of microscopic models facilitates more detailed simulations, accounting for the distinct behaviour of individual agents.

The Social Force model is an example of such a model, proposing that pedestrian movement can be conceptualised as being subject to 'social forces'. These 'forces' are not directly exerted by the personal environment of pedestrians, but rather represent a measure of the intrinsic motivations of individuals to perform certain actions (movements) [@helbing1995social]. The Social Force model is one of the most widely used crowd simulation models, but it is not the sole example. Other models include the Floor Field model and the Vicsek model.

## Simulation engines

The report delineates the issue of crowd flow on the AGH campus, employing the Social Force model to illustrate the phenomenon. The model under scrutiny offers a precise representation of pedestrian behaviour in that it accurately reflects the tendency of individuals to circumvent collisions with others (as illustrated in [@fig:laufer2008passenger-000]). In contrast to the tendency to reach one's destination expeditiously, pedestrians appear to prioritise the avoidance of collisions. Furthermore, the Social Force model incorporates the tendency of agents to maintain a safe distance from obstacles, such as lawns or walls, which aligns with empirical observations.

One alternative could be the Pygame library, which has been designed for the creation of games and multimedia applications in Python. Pygame allows for the creation of interactive simulations in which the user can change the simulation parameters in real time. It is particularly well-suited for visualising cellular automata and other discrete systems. However, due to the language used, it is not a very efficient solution.

It is evident that alternative, highly prevalent solutions comprise substantial game engines, such as Unity and Unreal Engine. These offer a substantially elevated degree of functionality in comparison to Pygame; however, they necessitate a more substantial investment of both knowledge and time to master. These tools are of a more intricate nature, yet they facilitate the development of sophisticated simulations and their subsequent visualisation.

It is also pertinent to mention the Godot engine, which is both free and open source, yet offers a plethora of features that are commonly found in paid engines. A notable advantage of the Godot engine is its smaller size compared to Unity or Unreal Engine, while retaining the capability to create sophisticated simulations.
