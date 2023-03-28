package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class HUD extends FlxTypedGroup<FlxSprite> {
	static inline var HUD_HEIGHT:Int = 25;

	var tanksDestroyedCounter:FlxText;
	var levelNumber:FlxText;
	var levelName:FlxText;
	var levelTanksIcon:FlxSprite;
	var levelTanksCounter:FlxText;

	public function new() {
		super();

		var background = new FlxSprite(0,
			FlxG.height - HUD_HEIGHT).makeGraphic(FlxG.width, HUD_HEIGHT, FlxColor.GRAY);
		add(background);

		var tanksDestroyedIcon = new FlxSprite(8, (background.y + (background.height / 2) - 8));
		add(tanksDestroyedIcon);

		tanksDestroyedCounter = new FlxText((tanksDestroyedIcon.x + 16), tanksDestroyedIcon.y, 0,
			"BOOM", 16);
		trace(tanksDestroyedCounter.size, tanksDestroyedCounter.height);
		tanksDestroyedCounter.color = FlxColor.RED;
		add(tanksDestroyedCounter);
	}
}
