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

		/* var tanksDestroyedIcon:FlxSprite;
			tanksDestroyedIcon = new FlxSprite(15, (tanksDestroyedIcon))
			add(tanksDestroyedIcon); */
		/**
			My current plan is to use math to figure the halfway point of the background and of the
			graphic to center them together. That way changes in the graphic and background
			heights will recenter them together.  I still don't like the way this is going to look
			when it's done, but need to get it working first.
		**/
	}
}
