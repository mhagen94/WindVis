Matt Hagen & Steven Roach

For parameters, we used 5000 particles with a random life time in the range of 50-200 and a step of 0.1 (using Euler's implementation.  
Changing step size proved to be a balancing act.  If the step became too big (closer to 1), the visualization became unruly and overwhelmingly active, making it difficult to get an idea of the directed field.  If the step was too small (closer to 0), it could become too slow to be engaging and again be a missed opportunity to understand the directions from the field.

We didn't attempt any wizardry because we had some late issues with particles only ever staying still or moving in a negative direciton towards (0,0). We spent most of our time working on this bug before being able to get to RK4 interpolation.
