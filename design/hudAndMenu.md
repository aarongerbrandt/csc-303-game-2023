# HUD and Menu Feature Proposal
Implementer: Richard P.

## Planned Features
- HUD: This will display things like number of enemy tanks, level numbers (if we end up with more than one level), etc.
- Start Menu: This will be the initial screen and may have entries to start the game and possibly an options menu with stuff like volume controls.

## Feature Branches
- hud for the HUD branch.
- start-menu for the start menu screen.
- Other branches as necessary depending on what else is needed.

## Updates to existing classes
- HUD: At the moment, I think just the PlayState class will need to be modified. As other classes are created, then it’s likely one or two of them will need to be modified as well, such as a level class.
- Start Menu: I think just the PlayState will need to be modified.

## New Classes
- HUD: I will need to make a HUD class to draw the hud onto the screen.
- Start Menu: I will need to make a MenuState class, and possibly a separate StartMenu class.

## Other Details
- For both of these features, my initial ideas for implementation are similar to what I saw when doing the TurnBasedRPG demo on the Haxe website. The layout will be different, of course, taking inspiration from the Wii Battle Tanks game and depending on other features that will be present in the game. I’m not great at design or being artsy, so I may need some help to make things look “pretty.”

## Interactions with Existing Content
- HUD: The HUD will display elements of things going on in the game state. This could be related to the number of enemies, health (if such a thing exists), or other elements. The HUD will also be a frame locked to the edges of the “camera” with no scroll factor so that it stays in place as the player moves around.
- Start Menu: This will probably be the first screen presented to the player and will have a start button at a minimum to start the game. This will interact with the game as a whole. If there needs to be an option to pause, I assume that the start menu would also do that.