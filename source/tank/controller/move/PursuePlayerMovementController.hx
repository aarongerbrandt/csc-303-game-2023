package tank.controller.move;

import flixel.FlxObject;
import flixel.math.FlxPoint;

class PursuePlayerMovementController extends BaseController implements IMoveController {
	public static var SPEED:Float = 50;

	private var direction = 1;

	private var targetTank:FlxObject;

	public function new(controlledTank:Tank, target:FlxObject) {
		super(controlledTank);
		targetTank = target;
	}

	public function getVelocity():FlxPoint {
		var result = FlxPoint.weak(1, 0);
		var angleToTarget = controlledTank.getPosition().degreesTo(targetTank.getPosition());
		return result.rotateByDegrees(angleToTarget).scale(SPEED);
	}
}
