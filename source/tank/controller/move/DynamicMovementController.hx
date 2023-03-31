package tank.controller.move;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.tile.FlxTilemap;

class DynamicMovementController extends BaseController implements IMoveController {
	private var idleTimerRemaining:Float = 0;

	private static var timerAmount:Int = 3;

	private var timerFinished:Bool = true;

	private static var SPEED:Float = 40;

	private var direction = 1;

	private static var targetTank:FlxObject;

	private static var map:FlxTilemap;

	private var targetInLineOfSight:Bool;

	public function new(controlledTank:Tank, target:FlxObject, tileMap:FlxTilemap) {
		super(controlledTank);
		targetTank = target;
		map = tileMap;
		idleTimerRemaining = timerAmount;
	}

	private function canSeeTarget():Bool {
		targetInLineOfSight = map.ray(controlledTank.getPosition(), targetTank.getPosition());
		return targetInLineOfSight;
	}

	override public function update(elapsed:Float) {
		idleTimerRemaining -= elapsed;
		if (!canSeeTarget()) {
			if (idleTimerRemaining <= 0) {
				timerFinished = true;
			}
		}
	}

	private function getNewDirection():FlxPoint {
		var newDirection:FlxPoint = null;
		var newX = FlxG.random.int(-1, 1);
		var newY = FlxG.random.int(-1, 1);
		trace(newX);
		trace(newY);
		return FlxPoint.weak(SPEED * newX, SPEED * newY);
	}

	private function idle():FlxPoint {
		if (timerFinished) {
			timerFinished = false;
			idleTimerRemaining = timerAmount;
			return getNewDirection();
		}
		else {
			return controlledTank.velocity;
		}
	}

	private function chase():FlxPoint {
		var result = FlxPoint.weak(1, 0);
		var angleToTarget = controlledTank.getPosition().degreesTo(targetTank.getPosition());
		return result.rotateByDegrees(angleToTarget).scale(SPEED);
	}

	public function getVelocity():FlxPoint {
		if (!canSeeTarget()) {
			return idle();
		}
		else {
			return chase();
		}
	}
}
