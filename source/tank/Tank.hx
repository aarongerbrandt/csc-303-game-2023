package tank;

import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;
import lime.system.System;
import tank.controller.move.IMoveController;
import tank.controller.shoot.IShootController;

class Tank extends FlxSprite {
	static inline public var BAKED_ROTATION_ANGLE_COUNT = 90;
	static inline public var HITBOX_SIZE_ADJUSTMENT = .35;

	public var bullets:FlxGroup;
	public var cannon:FlxSprite;

	public var aimDegrees:Float = 0;

	private var moveController:IMoveController;
	private var shootController:IShootController;

	public function new(X:Float, Y:Float,
			bodyGraphic:FlxGraphicAsset = AssetPaths.tank_body_placeholder__png) {
		super(X, Y);
		initSelf(bodyGraphic);
		initCannon();
		initBullets();
	}

	private function initSelf(staticGraphic:FlxGraphicAsset) {
		loadRotatedGraphic(staticGraphic, BAKED_ROTATION_ANGLE_COUNT, -1, false, true);
		var hitboxAdjustment = width * HITBOX_SIZE_ADJUSTMENT;
		width -= hitboxAdjustment;
		height -= hitboxAdjustment;
		offset.add(hitboxAdjustment / 2, hitboxAdjustment / 2);
	}

	private function initCannon() {
		cannon = new FlxSprite(x, y);
		cannon.active = false;
		cannon.loadRotatedGraphic(AssetPaths.tank_cannon_placeholder__png,
			BAKED_ROTATION_ANGLE_COUNT, -1, false, true);
		cannon.offset.add((cannon.width - width) / 2, (cannon.height - height) / 2);
		#if FLX_DEBUG
		cannon.ignoreDrawDebug = true;
		#end
	}

	private function initBullets() {
		bullets = new FlxGroup();
		// TODO: Generate all Bullet objects
	}

	/**
		Extra set-up step, anything that instantiates this should call `setControllers()` before
		the class is actually used. 
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
		if (velocity.length > 0) {
			angle = velocity.degrees;
		}

		shootController.update(elapsed);
		aimDegrees = shootController.getAimDegrees();

		if (shootController.shouldShoot()) {
			// TODO: Actually implement firing a bullet, to be completed when bullet-shooting is done.
		}

		super.update(elapsed);
		updateCannon();
	}

	private function updateCannon() {
		cannon.x = x;
		cannon.y = y;
		cannon.angle = aimDegrees;
	}

	override function kill() {
		cannon.kill();
		super.kill();
	}
}
