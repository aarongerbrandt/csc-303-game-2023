package projectile;

import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;

class SimpleBullet extends Projectile {
	private static var RICOCHET_TIMES:Float = 3.0;
	private static var BULLET_GRPHIC:FlxGraphicAsset = AssetPaths.bullet__png;

	override public function new() {
		super();
		speed = 350;
		loadGraphic(BULLET_GRPHIC);
		elasticity = 1;
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
