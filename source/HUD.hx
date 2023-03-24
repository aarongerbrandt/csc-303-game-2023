package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;

class HUD extends FlxTypedGroup<FlxSprite> {
	public function new() {
		super();

		var background = new FlxSprite(0,
			FlxG.height - 30).makeGraphic(FlxG.width, 30, FlxColor.GRAY);
		add(background);
	}
}
