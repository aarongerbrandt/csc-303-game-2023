## Enemy Tank Feature Proposal
Implemented by Kellie Behm

#### Planned features
* Enemy tank--either just a generic enemy for now, or a generic class and additionally more specific extensions for different types of enemies

#### Feature branch name
* EnemyTank

#### List of existing classes you expect to update
For inheritance route:
* inherit base Tank class

For composition route:
* inherit base Tank by calling specific controller classes

#### List of new classes you expect to create
For inheritance route:
* EnemyTank inheriting from Tank
* later: specific enemies, each inheriting from EnemyTank

For composition route:
* Controller classes that taek care of cannon aiming, tank movement (idle or in pursuit of player), but passing methods into base Tank class to instantiate different types of enemies.

#### Additional details of your implementation.
First thoughts (pre-composition method suggestion) For the enemy tank, I could start with just a generic enemy class (inheriting from base Tank) then extend into other new classes, each an additional type of enemy tank that would inherit from the general enemy. 

Properties:
* health
* speed
* "ownership" of bullets--max number "alive" or on screen at a time
* cool graphic -- sprite sheet with maybe 8 directional sprites
* rotatable cannon graphic
* cool firing sound -- not priority (or is it!)

#### Interactions with existing content
* The path the tank will move along needs to be on the non-wall spaces of Aaron's generated levels
* Likewise but want to avoid other tanks
* Possibly dodge bullets -- move perpendicular to bullet path?
* Needs to be able to fire bullets based on some logic regarding detecting and aiming toward the player
* initialized locations in each map through generated levels section