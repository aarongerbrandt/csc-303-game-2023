# CSC 303 Game 2023: Tanks for Nothin'
[![Html5 Demo](https://github.com/SamBumgardner/csc-303-game-2023/actions/workflows/deploy-pages.yml/badge.svg)](https://github.com/SamBumgardner/csc-303-game-2023/actions/workflows/deploy-pages.yml)

[Play in your browser!](https://sambumgardner.github.io/csc-303-game-2023/)

## About
A game designed and programmed by the students of the Spring 2023 semester of MSU's CSC 303.

It's our midterm project and our first 'real' game, so grade your expectations accordingly.

## Summary
In the style of the Wii Play classic *Tanks*, our game pits a player-controlled tank against overwhelming odds in a desperate fight for survival. Can you survive more levels than we're capable of implementing? Play to find out!

## Features
* A player-controlled tank
* Enemy Tanks
* Bouncing Bullets
* Randomly Generated Levels
* HUD and Menu
* Mines (?)

## Contribution Guidelines
To contribute to this project, please fork it and open pull requests from there back to this main repository.

It's just like contributing to a big open-source project! I'll review your work, as will your peers to ensure we're combining our different features effectively.

## Build Instructions
This game is written in Haxe using the [HaxeFlixel framework](https://haxeflixel.com/).

Assumed library versions are:
* lime 8.0.0
* openfl 9.2.0
* flixel 5.2.2
* flixel-addons 2.11.0

The game might compile successfully even with different dependency versions, but if you run into unexpected issues try switching your libraries to matching version using `haxelib install all` and/or `haxelib set`.

With correct versions in place, compile the game with
```
haxelib run lime build html5
```
and run the compiled game with 
```
haxelib run lime run html5
```
The game is built for web, but we also expect the HashLink target `hl` should also work fine if you prefer it instead.

## Attributions
<a href="https://www.flaticon.com/free-icons/explosion" title="explosion icons">Explosion icons created by Good Ware - Flaticon</a>