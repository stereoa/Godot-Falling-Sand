# Godot Falling Sand Mobile

A cellular automata "Falling Sand" game built entirely on a mobile device using the **Godot Android Editor**.

## Project Goals
* **Experiment with Godot on Mobile:** Testing the limits and workflow of the Godot 4 editor on an Android tablet/phone.
* **Cellular Automata Logic:** Implementing classic sand, water, and gas physics using a grid-based system.
* **Performance Optimization:** Exploring how to handle thousands of active particles efficiently on mobile hardware.

## How it Works
The game uses a 2D array (grid) where each cell follows specific rules:
- **Sand:** Falls down. If blocked, tries to slide diagonally left or right.
- **Input:** Optimized for touchscreens using `InputEventScreenDrag` to allow drawing directly on the grid.

## Current Progress
- [x] Dynamic grid scaling to fit any mobile screen resolution.
- [x] Basic sand gravity and diagonal displacement.
- [x] Multi-touch/Drag support for spawning sand.
- [ ] Liquid physics (Water).
- [ ] Multiple brush sizes.
- [ ] Performance optimizations (ImageTexture/Compute Shaders).

## Built With
* [Godot Engine](https://godotengine.org/) - The mobile editor (Android).
* GDScript.
