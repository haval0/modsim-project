# modsim blog - refracting light

This project is about simulating refraction of light using refractive indexes of different mediums and also using Snell's law.

The project was implemented in the Godot game engine.

Here is a video of how it looks when a "Photon" travels and goes through a square shaped piece of glass (refractive index 1.55).

Watch this:

![demo video](demo.mp4)


<video src="https://user-images.githubusercontent.com/56519858/159232522-00999300-0849-42e3-bbdd-c24b0067d381.mp4" muted="muted" controls="controls" style="max-width: 730px;">
</video>

The travel time of the Photon is timed. In this video the path takes 3.932 seconds in Godot time to travel. If we take out the piece of glass and let the Photon travel in a straight line it takes only 3.416 seconds.

The hardest part of the project was implementing the angle detection on collision and having it work with different shaped polygonal objects (not just squares).
