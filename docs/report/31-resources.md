## Resources

The decision was taken to base the model on the papers 'Social force model for pedestrian dynamics' by Helbing and
Molnár [@helbing1995social] and 'How simple rules determine pedestrian behaviour and crowd disasters' by Moussaïd, Helbing and
Theraulaz [@moussaid2011simple]. In both of these papers, the authors describe a model based on social forces to simulate pedestrian
behaviour in crowds. This model is widely regarded as one of the most prominent crowd simulation models, and it possesses the notable
capability of accurately representing pedestrian behaviour, including the avoidance of collisions with other pedestrians and the
maintenance of a safe distance from obstacles.Furthermore, we have drawn upon a range of additional sources, which are listed
in [@sec:references].

The model incorporates a series of inputs, including the initial position of the pedestrians, their intended destination, the average
velocity at which they move, their mass, the maximum field of view that is available to them, the range of their vision, the time
allocated for them to reach their destination, and the location of any obstacles that they might encounter. The outputs of the model
include the time taken for the pedestrians to reach their destination, as well as the visualisation of the pedestrian crossing and the
formation and dissolution of the crowd. A visualisation of the model is presented in [@fig:moussaid2011simple-005].

The model under consideration utilises the following variables:

- $i, j$ - pedestrians,
- $W$ - wall,
- $x_i$ - position vector,
- $r_i = $frac{m_i}{320}$ - radius,
- $v_{0i}$ - pedestrian normal velocity,
- $v_i$ - velocity vector,
- $v_{\text{des}}$ - desired velocity,
- $m_i$ - mass of the pedestrian,
- $O_i$ - target point of the pedestrian,
- $H_i$ - range of vision,
- $phi$ - maximum angle of view,
- $\alpha = [-phi , -phi]$ - direction,
- $\alpha_0$ - target direction,
- $\alpha_{\text{des}}$ - desired direction relative to $H_i$,
- $t$ - relaxation time (time required to change pedestrian behaviour),
- $t$ - time,
- $d_{max}$ - greatest distance seen,
- $d_h$ - distance between pedestrian and obstacle.

The function $f(\alpha)$ returns the distance to an obstacle in the pedestrian's line of sight, depending on the direction. If there is
no obstacle in the direction $\alpha$, the value $d_{\max}$ is returned. The direction $\alpha_{\text{des}}(t)$ is calculated as shown
in [@eq:direction].

![Illustration of a pedestrian $p_1$ facing three other objects and trying to reach the target point $O_1$ marked in red; the blue dashed line corresponds to the line of sight [@moussaid2011simple]](images/moussaid2011simple-005.png)
{#fig:moussaid2011simple-005}

$$
\begin{aligned}
d_{\text{max}} &= H_i \\
d(\alpha) &= d_{\text{max}}^2 + f(\alpha)^2 - 2d_{\max} \times f(\alpha) \times \cos(\alpha_0 - \alpha) \\
\alpha_{\text{des}} &= \min(d(\alpha))
\end{aligned}
$$ {#eq:direction}

The calculation of the desired velocity of the pedestrian is achieved through the utilisation of [@eq:desired_velocity], while the
acceleration of the pedestrian is calculated via [@eq:pedestrian_acceleration].

$$
v_{\text{des}}(t) = \min(v_{0i}, \frac{d_h}{\tau})
$$ {#eq:desired_velocity}

$$
\frac{dv_i}{dt} = \frac{(v_\text{des} - v_i)}{\tau}
$$ {#eq:pedestrian_acceleration}

In situations of high traffic density, the forces exerted on pedestrians due to direct physical contact (i.e. collision) with other
objects must also be taken into account.

The final acceleration vector of the pedestrian can be calculated using [@eq:acceleration-vector].

$$
\begin{aligned}
f_{ij} &= k \times g(r_i + r_j - d_{ij}) \times n_{ij} \\
a_i &= \frac{v_{\text{des}} - v_i}{\tau} + \sum_{j, j \neq i} \frac{f_{ij}}{m_i} + \sum_{W} \frac{f_{iW}}{m_i}
\end{aligned}
$$ {#eq:acceleration-vector}

where:

- $f_{ij}$ - contact force between pedestrians $i$ and $j$,
- $k$ - scaling factor,
- $g(x)$ - $x$ if pedestrians are touching, otherwise 0,
- $d_{ij}$ - distance between centres of mass of pedestrians $i$ and $j$,
- $n_{ij}$ - normalised vector from pedestrian $j$ to pedestrian $i$.
