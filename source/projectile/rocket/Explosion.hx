package projectile.rocket;

import flixel.math.FlxPoint;

class Explosion extends Projectile {
	private static var EXPLOSION_LENGTH:Float = 0.5;
	private static var OFFSET:FlxPoint = new FlxPoint(32, 32);

	private static var EXPLOSION_GRAPHIC:String = "assets/images/rocket_explosion.png";

	private var explosionTimer:Float;

	override public function new() {
		super(EXPLOSION_GRAPHIC);
	}

	override public function update(elapsed:Float) {
		if (explosionTimer > 0) {
			explosionTimer -= elapsed;
		}
		else {
			kill();
		}
		super.update(elapsed);
	}

	override public function impact(surface:String) {}

	override public function fire(startPoint:FlxPoint, aimDegrees:Float) {
		super.fire(new FlxPoint(startPoint.x - OFFSET.x, startPoint.y - OFFSET.y), aimDegrees);
		explosionTimer = EXPLOSION_LENGTH;
	}
}
