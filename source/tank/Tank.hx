package tank;

import flixel.FlxSprite;
import flixel.group.FlxGroup;
import lime.system.System;
import tank.controller.move.IMoveController;
import tank.controller.shoot.IShootController;

class Tank extends FlxSprite {
	public var bullets:FlxGroup;
	public var cannon:FlxSprite;

	public var aimDegrees:Float = 0;

	private var moveController:IMoveController;
	private var shootController:IShootController;

	public function new(X:Float, Y:Float) {
		super(X, Y);
		makeGraphic(24, 24);
		initCannon();
		initBullets();
	}

	private function initCannon() {
		cannon = new FlxSprite(x, y);
		cannon.active = false;
		cannon.loadRotatedGraphic(AssetPaths.tank_cannon_placeholder__png, 360);
		cannon.offset.set((cannon.width - width) / 2, (cannon.height - height) / 2);
		#if FLX_DEBUG
		cannon.ignoreDrawDebug = true;
		#end
	}

	private function initBullets() {
		bullets = new FlxGroup();
		// TODO: Generate all Bullet objects
	}

	/**
		Extra set-up step
	**/
	public function setControllers(MoveController:IMoveController,
			ShootController:IShootController) {
		moveController = MoveController;
		shootController = ShootController;
	}

	/**
		Collects everything that needs to be added to the FlxState. Should use this in FlxStates, e.g.
			add(tank.getAllSprites());
		Instead of trying to call add() on the Tank object directly.
	**/
	public function getAllSprites() {
		var group = new FlxGroup();
		group.add(this);
		group.add(cannon);
		group.add(bullets);
		return group;
	}

	override function update(elapsed:Float) {
		#if FLX_DEBUG
		if (moveController == null || shootController == null) {
			trace('ERROR: instance of Tank had `update()` called with a null controller(s).');
			trace('    After instantiating any Tank object, we MUST call `setControllers()`');
			System.exit(1);
		}
		#end
		moveController.update(elapsed);
		velocity.copyFrom(moveController.getVelocity());

		shootController.update(elapsed);
		aimDegrees = shootController.getAimDegrees();

		if (shootController.shouldShoot()) {
			trace('shot a bullet, wowee');
			// TODO: Actually implement firing a bullet, to be completed when bullet-shooting is done.
		}

		updateCannon();
		super.update(elapsed);
	}

	private function updateCannon() {
		cannon.x = x;
		cannon.y = y;
		cannon.angle = aimDegrees;
	}
}
