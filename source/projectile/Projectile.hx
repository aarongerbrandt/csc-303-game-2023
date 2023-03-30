package projectile;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

class Projectile extends FlxSprite {
	private static var SPEED:Float = 250;

	public function new() {
		super(FlxG.width, FlxG.height);
		makeGraphic(10, 10, FlxColor.WHITE);
		kill();
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}

	public function fire(startPoint:FlxPoint, aimDegrees:Float) {
		reset(startPoint.x, startPoint.y);
		var result = FlxPoint.weak(1, 0);
		velocity = result.rotateByDegrees(aimDegrees).scale(SPEED);
		angle = aimDegrees;
	}

	private function impact(surface:String) {
		kill();
	}
}
