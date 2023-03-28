package tank.controller.move;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxPoint;

class DynamicMovementController extends BaseController implements IMoveController {
	public static var SPEED:Float = 50;

	private var direction = 1;
	private var targetTank:FlxObject;
	private var idleState:Bool = true;

	private var point:FlxPoint = FlxPoint.weak(100, 100);

	var distance:Float;

	public function new(controlledTank:Tank, target:FlxObject) {
		super(controlledTank);
		targetTank = target;
	}

	private function getDistance(controlled:Tank, target:FlxObject) {
		distance = (targetTank.getPosition().x) - (controlledTank.getPosition().x);
	}

	override public function update(elapsed:Float) {
		idleState = (distance < 30);
	}

	private function idle():FlxPoint {
		if (controlledTank.y > FlxG.height - controlledTank.height) {
			direction = -1;
		}
		else if (controlledTank.y < 0) {
			direction = 1;
		}

		return FlxPoint.weak(0, SPEED * direction);
	}

	private function chase():FlxPoint {
		var result = FlxPoint.weak(1, 0);
		var angleToTarget = controlledTank.getPosition().degreesTo(targetTank.getPosition());
		return result.rotateByDegrees(angleToTarget).scale(SPEED);
	}

	public function getVelocity():FlxPoint {
		if (idleState) {
			return idle();
		}
		else {
			return chase();
		}
	}
}
/* update function needs to change what type of direction is returned
	-idle movement: random direction, random time (within range of seconds), pause
	-pursuit movement: angleToTarget from PursuePlayer

	getVelocity will return velocity vector, either random or pursuit based on update designation
 */
