package tank.controller.shoot;

import flixel.FlxObject;

class AutoAimController extends BaseController implements IShootController {
	static inline public var SHOOT_TIMER_MAX = .5;

	private var shootTimerRemaining:Float = SHOOT_TIMER_MAX;

	private var rotateBy:Float = 0;

	private var targetTank:FlxObject;

	public function new(controlledTank:Tank, target:FlxObject) {
		super(controlledTank);
		targetTank = target;
	}

	override public function update(elapsed:Float):Void {
		shootTimerRemaining -= elapsed;
		rotateBy = controlledTank.getPosition().degreesTo(targetTank.getPosition());
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
