package tank.controller.shoot;

import flixel.FlxObject;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;

class AutoAimController extends BaseController implements IShootController {
	static inline public var SHOOT_TIMER_MAX = .5;

	private var shootTimerRemaining:Float = SHOOT_TIMER_MAX;

	private var rotateBy:Float = 0;

	private var targetTank:FlxObject;

	public function new(controlledTank:Tank, target:FlxObject) {
		super(controlledTank);
		targetTank = target;
	}

	private function distanceToTarget():Float {
		var dx = (controlledTank.x - targetTank.x);
		var dy = (controlledTank.y - targetTank.y);
		return Std.int(FlxMath.vectorLength(dx, dy));
	}

	override public function update(elapsed:Float):Void {
		shootTimerRemaining -= elapsed;
		rotateBy = controlledTank.getPosition().degreesTo(targetTank.getPosition());
		if (shouldShoot()) {
			// shoot bullet if shootShoot true
		}
	}

	public function getAimDegrees():Float {
		return controlledTank.aimDegrees = rotateBy;
	}

	public function shouldShoot():Bool {
		if (shootTimerRemaining < 0) {
			shootTimerRemaining += SHOOT_TIMER_MAX;
			return true;
		}
		return false;
	}
}
