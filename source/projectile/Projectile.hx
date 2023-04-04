package projectile;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Projectile extends FlxSprite {
	static inline public var HITBOX_SIZE_REDUCTION = .5;

	private var speed:Float = 0;

	public function new(graphic:FlxGraphicAsset) {
		super();
		loadGraphic(graphic);
		adjustHitbox();
		kill();
	}

	private function adjustHitbox() {
		var hitboxReduction = width * HITBOX_SIZE_REDUCTION;
		width -= hitboxReduction;
		height -= hitboxReduction;
		offset.add(hitboxReduction / 2, hitboxReduction / 2);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}

	public function fire(startPoint:FlxPoint, aimDegrees:Float) {
		reset(startPoint.x, startPoint.y);
		var result = FlxPoint.weak(1, 0);
		velocity = result.rotateByDegrees(aimDegrees).scale(speed);
		angle = aimDegrees;
	}

	private function impact(surface:String) {
		kill();
	}
}
