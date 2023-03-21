# Player Tank Feature Proposal
Implementer: Quinn L.

## Planned Features
* Player tank movement with wasd keys
* Player tank aiming with MouseCannonController
* Player tank firing with left mouse click
* Player tank health
* Player tank speed
* Modify tank sprite to make it stand out

## Feature Branch Names
* PlayerTank

## Existing Classes to Update
* Tank
* MoveController
* ShootController

## New Classes to Create
* PlayerTank
* KeyboardMovementController
* MouseCannonController
* GamepadMovementController(If there is time)
* GamepadCannonController(If there is time)

## Additional Implementation Details
* We're using the composition strategy so I'll be creating controller classes that the tank controllers will then use to create the player tank behavior.
* If we have time I'll implement gamepad controls using the sticks for movement and aiming and a shoulder/trigger button to fire.
* I should try to build the PlayerTank class in a way that powerups or other modifyers can change the behavior of the player tank.

## How This Interacts with Other New Content
* Should use the Fire method in the cannon controller classes
* Should be dealt damage from bullets
* Shouldn't collide with walls
* Shouldn't collide with other tanks