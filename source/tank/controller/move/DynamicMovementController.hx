package tank.controller.move;

import flixel.FlxG.random;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;

class DynamicMovementController extends BaseController implements IMoveController {
	private var idleTimer:Float = 0;

	public static var SPEED:Float = 50;

	private var direction = 1;
	private var targetTank:FlxObject;
	private var idleState:Bool = true;

	private var point:FlxPoint = FlxPoint.weak(100, 100);

	var distance:Float;
	var dx:Float;
	var dy:Float;

	public function new(controlledTank:Tank, target:FlxObject) {
		super(controlledTank);
		targetTank = target;
	}

	private function distanceToTarget():Float {
		var dx = (controlledTank.x - targetTank.x);
		var dy = (controlledTank.y - targetTank.y);
		return Std.int(FlxMath.vectorLength(dx, dy));
	}

	// idleState is true while distance is too big--then false ie "chase" mode when distance is within given range
	override public function update(elapsed:Float) {
		idleState = (distanceToTarget() > 300); // this logic can be changed w line of sight jazz
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
