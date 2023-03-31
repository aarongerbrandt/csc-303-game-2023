package projectile;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;

class Projectile extends FlxSprite {
	private static var SPEED:Float = 0;

	public function new() {
		super(FlxG.width, FlxG.height);
		kill();
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}

	private function getSpeed() {
		return SPEED;
	}

	public function fire(startPoint:FlxPoint, aimDegrees:Float) {
		reset(startPoint.x, startPoint.y);
		var result = FlxPoint.weak(1, 0);
		velocity = result.rotateByDegrees(aimDegrees).scale(getSpeed());
		angle = aimDegrees;
	}

	private function impact(surface:String) {
		kill();
	}
}
