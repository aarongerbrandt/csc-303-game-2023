package tank.controller.move;

import flixel.FlxG;
import flixel.math.FlxPoint;

class HorizontalMoveController extends BaseController implements IMoveController {
	public static var SPEED:Float = 50;

	private var direction = 1;

	override public function update(elapsed:Float) {
		if (controlledTank.x > FlxG.width - controlledTank.width) {
			direction = -1;
		}
		else if (controlledTank.x < 0) {
			direction = 1;
		}
	}

	public function getVelocity():FlxPoint {
		return FlxPoint.weak(SPEED * direction, 0);
	}
}
