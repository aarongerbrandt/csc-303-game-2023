package tank;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tile.FlxTilemap;
import level.TestGenState;
import projectile.Projectile;
import projectile.SimpleBullet;
import tank.controller.move.IMoveController;
import tank.controller.shoot.IShootController;
#if FLX_DEBUG
import lime.system.System;
#end

class Tank extends FlxSprite {
	static inline public var BAKED_ROTATION_ANGLE_COUNT = 90;
	static inline public var HITBOX_SIZE_REDUCTION = .35;
	static inline public var BULLET_SPAWN_DISTANCE_MULT = 1.5;

	public var bullets:FlxTypedGroup<Projectile>;
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
		var hitboxReduction = width * HITBOX_SIZE_REDUCTION;
		width -= hitboxReduction;
		height -= hitboxReduction;
		offset.add(hitboxReduction / 2, hitboxReduction / 2);
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
		bullets = new FlxTypedGroup<Projectile>();
		for (i in 0...10) {
			bullets.add(new SimpleBullet());
		}
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
			var bullet = bullets.getFirstDead();
			if (bullet != null) {
				var bulletMidpoint = getMidpoint().addPoint(FlxPoint.weak(width * .75
					+ bullet.width * .75, 0)
					.rotateByDegrees(aimDegrees));

				var willOverlapWithMap = cast(FlxG.state, TestGenState)
					.map.overlapsPoint(bulletMidpoint);

				if (!willOverlapWithMap) {
					bullet.fire(bulletMidpoint.subtract(bullet.width / 2, bullet.height / 2),
						aimDegrees);
				};
			}
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
