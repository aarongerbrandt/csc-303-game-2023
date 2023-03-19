package tank.controller.shoot;

class SpinShootController extends BaseController implements IShootController {
	static inline public var AIM_ROTATE_RATE = 60;
	static inline public var SHOOT_TIMER_MAX = .5;

	private var rotateBy:Float = 0;
	private var shootTimerRemaining:Float = SHOOT_TIMER_MAX;

	override public function update(elapsed:Float):Void {
		shootTimerRemaining -= elapsed;
		rotateBy = AIM_ROTATE_RATE * elapsed;
	}

	public function getAimDegrees():Float {
		return controlledTank.aimDegrees += rotateBy;
	}

	public function shouldShoot():Bool {
		if (shootTimerRemaining < 0) {
			shootTimerRemaining += SHOOT_TIMER_MAX;
			return true;
		}
		return false;
	}
}
