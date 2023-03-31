package projectile;

import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class Rocket extends Projectile {
	private static var SPEED = 0;
	private static var ACCEL = 1500;
	private static var SIZE = 1;
	private static var EXPLOSION_LENGTH = 0.5;

	private var isExploding:Bool = false;
	private var explosionTimer:Float;

	override public function new() {
		super();
		// explosionTimer.start(EXPLOSION_LENGTH, explosionKill, 1);
	}

	override public function update(elapsed:Float) {
		if (isExploding && explosionTimer > 0) {
			explosionTimer -= elapsed;
			velocity = new FlxPoint(0, 0);
			acceleration = new FlxPoint(0, 0);
		}
		else if (isExploding) {
			kill();
		}
		super.update(elapsed);
	}

	override public function fire(startPoint:FlxPoint, aimDegrees:Float) {
		// loadGraphic(ROCKET PATH HERE);
		makeGraphic(15, 5, FlxColor.RED);
		setSize(SIZE, SIZE);
		isExploding = false;
		explosionTimer = EXPLOSION_LENGTH;
		super.fire(startPoint, aimDegrees);
		var baseAccel = FlxPoint.weak(1, 0);
		acceleration = baseAccel.rotateByDegrees(aimDegrees).scale(ACCEL);
	}

	override public function impact(surface:String) {
		loadGraphic(AssetsPaths.explosion__png);
		isExploding = true;
	}

	private function explosionKill(timer:FlxTimer) {
		kill();
	}
}
