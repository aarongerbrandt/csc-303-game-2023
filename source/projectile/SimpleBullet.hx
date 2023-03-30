package projectile;

import flixel.math.FlxPoint;

class SimpleBullet extends Projectile {
	private static var RICOCHET_TIMES:Float = 3.0;
	private static var SPEED = 350;

	override public function new() {
		super();
		elasticity = 1;
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}

	override public function fire(startPoint:FlxPoint, aimDegrees:Float) {
		health = RICOCHET_TIMES;
		super.fire(startPoint, aimDegrees);
	}

	override public function impact(surface:String) {
		if (surface == "wall") {
			hurt(1);
		}
		if (surface == "tank") {
			hurt(RICOCHET_TIMES);
		}
		if (surface == "projectile") {
			hurt(2);
		}
	}
}
