package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class HUD extends FlxTypedGroup<FlxSprite> {
	static inline var HUD_HEIGHT:Int = 24;
	static inline var HUD_COLOR = FlxColor.GRAY;
	static inline var HUD_SIDE_SPACING:Float = 8;
	static inline var HUD_ELEMENT_SIZE:Int = 16;

	var background:FlxSprite;
	var tanksDestroyedIcon:FlxSprite;
	var tanksDestroyedCounter:FlxText;

	public function new() {
		super();

		setupBackground();
		setupTanksDestroyed();
		setupLevelInformation();
		setupLevelTanksInformation();
	}

	function setupBackground() {
		background = new FlxSprite(0, FlxG.height - HUD_HEIGHT);
		background.makeGraphic(FlxG.width, HUD_HEIGHT, HUD_COLOR);
		add(background);
	}

	function setupTanksDestroyed() {
		tanksDestroyedIcon = new FlxSprite(0, 0, AssetPaths.place__png);
		tanksDestroyedIcon.x = HUD_SIDE_SPACING;
		tanksDestroyedIcon.y = background.y
			+ (background.height / 2)
			- (tanksDestroyedIcon.height / 2);

		tanksDestroyedCounter = new FlxText();
		tanksDestroyedCounter.text = "0";
		tanksDestroyedCounter.size = HUD_ELEMENT_SIZE;
		tanksDestroyedCounter.x = tanksDestroyedIcon.x
			+ tanksDestroyedIcon.width
			+ HUD_SIDE_SPACING;
		tanksDestroyedCounter.y = tanksDestroyedIcon.getGraphicMidpoint().y
			- (tanksDestroyedCounter.height / 2);
		tanksDestroyedCounter.color = FlxColor.RED;

		add(tanksDestroyedIcon);
		add(tanksDestroyedCounter);
	}

	function setupLevelInformation() {
		var levelNumber:Int = 0;
		var levelName:String = "Insert Witty Level Name Here!";
		var levelInformation = new FlxText();

		levelInformation.text = "Level " + levelNumber + ": " + levelName;
		levelInformation.size = HUD_ELEMENT_SIZE;
		levelInformation.x = background.getGraphicMidpoint().x - (levelInformation.width / 2);
		levelInformation.y = tanksDestroyedCounter.y;
		levelInformation.color = FlxColor.RED;

		add(levelInformation);
	}

	function setupLevelTanksInformation() {
		var levelTanksStart:Int = 0;
		var levelTanksRemain:Int = 0;
		var levelTanksIcon = new FlxSprite(0, 0, AssetPaths.place__png);
		var levelTanksInformation = new FlxText();

		levelTanksInformation.text = levelTanksRemain + " / " + levelTanksStart;
		levelTanksInformation.size = HUD_ELEMENT_SIZE;
		levelTanksInformation.x = FlxG.width - levelTanksInformation.width - HUD_SIDE_SPACING;
		levelTanksInformation.y = tanksDestroyedCounter.y;
		levelTanksInformation.color = FlxColor.RED;

		levelTanksIcon.x = levelTanksInformation.x - levelTanksIcon.width - HUD_SIDE_SPACING;
		levelTanksIcon.y = tanksDestroyedIcon.y;

		add(levelTanksIcon);
		add(levelTanksInformation);
	}
}
/**
	TODO: Replace placeholder images. Not sure on artistic abilities.
	TODO: Create update Tanks Destroyed function.
	TODO: Create update Level Number function.
	TODO: Create Random Level Name Generator function.
	TODO: Create update Level Enemy Start and Remaining function(s).
**/
