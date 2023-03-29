package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class HUD extends FlxTypedGroup<FlxSprite> {
	static inline var HUD_HEIGHT:Int = 25;

	var background:FlxSprite;
	var tanksDestroyedIcon:FlxSprite;
	var tanksDestroyedCounter:FlxText;
	var levelNumber:FlxText;
	var levelName:FlxText;
	var levelTanksIcon:FlxSprite;
	var levelTanksCounter:FlxText;

	public function new() {
		super();

		setupBackground();
		setupTanksDestroyed();
	}

	function setupBackground() {
		background = new FlxSprite(0, FlxG.height - HUD_HEIGHT);
		background.makeGraphic(FlxG.width, HUD_HEIGHT, FlxColor.GRAY);
		add(background);
	}

	function setupTanksDestroyed() {
		tanksDestroyedIcon = new FlxSprite(0, 0, AssetPaths.place__png);
		tanksDestroyedIcon.x = tanksDestroyedIcon.width / 2;
		tanksDestroyedIcon.y = background.y
			+ (background.height / 2)
			- (tanksDestroyedIcon.height / 2);

		tanksDestroyedCounter = new FlxText();
		tanksDestroyedCounter.x = tanksDestroyedIcon.x + 16;
		// Still need to change this one.  Probably make it match with the x value spacing.

		tanksDestroyedCounter.y = tanksDestroyedIcon.getGraphicMidpoint().y
			- ((tanksDestroyedIcon.height / 4) + (tanksDestroyedCounter.height / 2));
		tanksDestroyedCounter.text = "BOOM!";
		tanksDestroyedCounter.size = 16; // Make this one a static once everything works.

		tanksDestroyedCounter.color = FlxColor.RED;

		add(tanksDestroyedIcon);
		add(tanksDestroyedCounter);

		/**
			Still working on figuring out how to align. I'm closer than I was.
			When background height changes, it stays aligned, but when the font size is changed, it
			goes all out of whack.
		**/
	}
}
