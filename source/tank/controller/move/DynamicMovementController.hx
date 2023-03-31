package tank.controller.move;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.tile.FlxTilemap;

class DynamicMovementController extends BaseController implements IMoveController {
	private static var targetTank:FlxObject;
	private static var map:FlxTilemap;

	private static var SPEED:Float = 40;

	private static var timerMin:Int = 2;
	private static var timerMax:Int = 5;
	private static var noTinyRotations:Array<Int> = [for (i in -15...15) if (i != 0) i];

	private var idleTimerRemaining:Float = 0;
	private var timerFinished:Bool = true;

	private var targetInLineOfSight:Bool;

	public function new(controlledTank:Tank, target:FlxObject, tileMap:FlxTilemap) {
		super(controlledTank);
		targetTank = target;
		map = tileMap;
		idleTimerRemaining = FlxG.random.int(timerMin, timerMax);
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

	private function rotateAmount():FlxPoint {
		var angle = FlxG.random.int(-45, 45, noTinyRotations);

		return controlledTank.velocity.rotateByDegrees(angle);
	}

	private function idle():FlxPoint {
		if (timerFinished) {
			timerFinished = false;
			idleTimerRemaining = FlxG.random.int(timerMin, timerMax);
			return rotateAmount();
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
