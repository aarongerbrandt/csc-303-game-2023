package mines;

import flixel.FlxSprite;

class Mine extends FlxSprite {
	private static var DETONATION_TIME:Int = 5;
	public static var DETONATION_RADIUS:Int = 2;

	public var detonationTimeRemaining:Float;

	override function new(x:Float, y:Float) {
		super(x, y);

		loadGraphic(AssetPaths.mine__png);

		detonationTimeRemaining = DETONATION_TIME;
	}

	override function update(elapsed:Float) {
		detonationTimeRemaining -= elapsed;
		if (detonationTimeRemaining <= 0) {
			explode();
		}
	}

	private function explode() {
		kill();
		// create explosion
	}
}
