package bullet;

import flixel.FlxSprite;
import flixel.math.FlxPoint;

class Projectile extends FlxSprite {
	public function new(X:Float, Y:Float) {
		super(X, Y);
	}

	public function fire(startingPos:FlxPoint) {
		reset(startingPos.x, startingPos.y);
	}

	public function impact() {
		kill();
	}
}
