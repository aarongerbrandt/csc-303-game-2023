package projectile;

class SimpleBullet extends Projectile {
	private static var RICOCHET_TIMES:Float = 3.0;
	private static var SPEED = 350;

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}

	override public function impact(surface:String) {
		if (surface == "wall") {
			hurt(1);
		}
		if (surface == "tank") {
			kill();
		}
		if (surface == "projectile") {
			hurt(2);
		}
	}
}
