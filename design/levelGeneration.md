# Level Generation Feature Proposal
Implementer: Aaron G.

## Planned Features
* Randomly generated map
* Wall

## Feature Branch Names
* LevelGenerator
* Wall

## Existing Classes to Update
* None

## New Classes to Create
* LevelGenerator
* Make a new state for each level?
* Wall
* Maybe more?

## Additional Implementation Details
* My preliminary thought for randomly generated levels is just having an object in the PlayState that can be used to return a bitmap for the level layout
* I'm currently planning on implementing a preexisting algorithm that I will tweak to fit our game
  * Currently looking at the [Maze Generation Algorithm](https://en.wikipedia.org/wiki/Maze_generation_algorithm#Recursive_division_method)
  * Open to other algorithms, depends on how well the Maze Generation works
* Wall should be fairly easy to create will just have to look into FlxTilemap

## How This Interacts with Other New Content
* Tanks will be added to the level after it is generated
* Tanks cannot move through walls
* Bullets will bounce off of Walls
