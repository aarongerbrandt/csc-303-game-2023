package;

import flixel.FlxGame;
import flixel.FlxObject;
import openfl.display.Sprite;

class Main extends Sprite {
	public function new() {
		super();
		// hard-coded separation bias to ensure bullets and such don't pass through walls.
		FlxObject.SEPARATE_BIAS = 16;
		addChild(new FlxGame(640, 640, StartMenuState));
	}
}
