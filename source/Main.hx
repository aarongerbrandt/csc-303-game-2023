package;

import flixel.FlxGame;
import level.TestGenState;
import openfl.display.Sprite;

class Main extends Sprite {
	public function new() {
		super();
		// addChild(new FlxGame(0, 0, TestState));
		// Comment Line 11 and uncomment this line to test level generation
		addChild(new TankGame());
	}
}
