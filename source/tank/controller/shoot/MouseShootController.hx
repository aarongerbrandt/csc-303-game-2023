package tank.controller.shoot;

import flixel.FlxG;

class MouseShootController extends BaseController implements IShootController {
	static inline public var AIM_ROTATE_RATE = 60;
	static inline public var SHOOT_TIMER_MAX = .5;

	private var rotateBy:Float = 0;
	private var shootTimerRemaining:Float = SHOOT_TIMER_MAX;

	override public function update(elapsed:Float):Void {
		if (shootTimerRemaining > 0) {
			shootTimerRemaining -= elapsed;
		}
	}

	public function getAimDegrees():Float {
		return controlledTank.getPosition().degreesTo(FlxG.mouse.getPosition());
	}

	public function shouldShoot():Bool {
		if (FlxG.mouse.justPressed || shootTimerRemaining <= 0) {
			shootTimerRemaining += SHOOT_TIMER_MAX;
			return true;
		}
		return false;
	}
}
