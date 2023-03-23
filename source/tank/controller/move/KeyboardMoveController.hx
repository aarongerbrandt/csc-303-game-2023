package tank.controller.move;

import flixel.FlxG;
import flixel.math.FlxPoint;

class KeyboardMoveController extends BaseController implements IMoveController {
	public static var MAX_SPEED:Float = 50;

	override public function update(elapsed:Float) {
		// Screenwrap code
		if (controlledTank.velocity.y > 0 && controlledTank.y >= FlxG.height) {
			controlledTank.y = 0;
		}
		else if (controlledTank.velocity.y < 0 && (controlledTank.y + controlledTank.height) <= 0) {
			controlledTank.y = FlxG.height;
		}

		if (controlledTank.velocity.x > 0 && controlledTank.x >= FlxG.width) {
			controlledTank.x = -(controlledTank.width);
		}
		else if (controlledTank.velocity.x < 0 && (controlledTank.x + controlledTank.width) <= 0) {
			controlledTank.x = FlxG.width;
		}

		super.update(elapsed);
	}

	public function getVelocity():FlxPoint {
		var xDirection = 0;
		var yDirection = 0;

		if (FlxG.keys.pressed.W) {
			yDirection--;
		}

		if (FlxG.keys.pressed.S) {
			yDirection++;
		}

		if (FlxG.keys.pressed.A) {
			xDirection--;
		}

		if (FlxG.keys.pressed.D) {
			xDirection++;
		}

		return FlxPoint.weak(MAX_SPEED * xDirection, MAX_SPEED * yDirection);
	}
}
