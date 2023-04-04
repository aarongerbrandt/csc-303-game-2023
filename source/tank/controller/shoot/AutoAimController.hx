package tank.controller.shoot;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.tile.FlxTilemap;

class AutoAimController extends BaseController implements IShootController {
	static inline public var SHOOT_TIMER_MAX = 1;
	static inline public var SHOOT_TIMER_MIN = .5;

	private var shootTimerRemaining:Float = SHOOT_TIMER_MAX;

	private var rotateBy:Float = 0;

	private static var targetTank:FlxObject;

	static var map:FlxTilemap;

	var targetInLineOfSight:Bool;

	public function new(controlledTank:Tank, target:FlxObject, tileMap:FlxTilemap) {
		super(controlledTank);
		targetTank = target;
		map = tileMap;
	}

	override public function update(elapsed:Float):Void {
		if (shootTimerRemaining > 0) {
			shootTimerRemaining -= elapsed;
		}
		rotateBy = controlledTank.getMidpoint().degreesTo(targetTank.getMidpoint());
	}

	private function canSeeTarget():Bool {
		targetInLineOfSight = map.ray(controlledTank.getMidpoint(), targetTank.getMidpoint());
		return targetInLineOfSight;
	}

	public function getAimDegrees():Float {
		return controlledTank.aimDegrees = rotateBy;
	}

	public function shouldShoot():Bool {
		if (shootTimerRemaining <= 0 && canSeeTarget()) {
			shootTimerRemaining += FlxG.random.float(SHOOT_TIMER_MIN, SHOOT_TIMER_MAX);
			return true;
		}
		return false;
	}
}
