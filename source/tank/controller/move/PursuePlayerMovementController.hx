// for now, moves to a static point
package tank.controller.move;

import flixel.FlxG;
import flixel.math.FlxPoint;

class PursuePlayerMovementController extends BaseController implements IMoveController {
	public static var SPEED:Float = 50;

	private var direction = 1;

	public function getVelocity():FlxPoint {
		var result = FlxPoint.weak(1, 0);
		var angleToTarget = controlledTank.getPosition().degreesTo((FlxPoint.weak(200, 200)));
		return result.rotateByDegrees(angleToTarget).scale(SPEED);
	}
}
