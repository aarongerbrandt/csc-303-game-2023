# Bullet Feature Proposal
Implpementer: Sawyer M.

## Planned Features
* Spawnable projectile with a given speed and direction
* Bullet that bounces off walls and damages tanks on contact

## Feature Branch Names
* BaseProjectile
* SimpleBullet

## Existing Classes to Update
* None planned

## New Classes to Create
* Projectile
* Bullet (inherits projectile)

## Additional Implementation Details
* Projectile should act as the parent class to most things fired by tanks, giving them a general fire method, speed, direction, and impact detection
* Bullet class will act as the default projectile, bouncing off walls and damaging tanks
* Planning to use the kill/revive functions to handle bullet "creation" and "deletion"

## Interactions with Other New Content
* Will have to bounce off of walls
* Inflicts damage on tanks
* Tanks will have to be able to create bullets and set their speed and direction