package tank.controller.move;

import flixel.FlxG;
import flixel.math.FlxPoint;

class MouseFollowMoveController extends BaseController implements IMoveController {
	public static var SPEED:Float = 50;

	private var direction = 1;

	public function getVelocity():FlxPoint {
		var result = FlxPoint.weak(1, 0);
		var angleToTarget = controlledTank.getPosition().degreesTo(FlxG.mouse.getPosition());
		return result.rotateByDegrees(angleToTarget).scale(SPEED);
	}
}
