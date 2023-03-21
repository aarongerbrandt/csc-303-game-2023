package tank.controller.move;

import flixel.FlxG;
import flixel.math.FlxPoint;

class KeyboardMoveController extends BaseController implements IMoveController {
	public static var SPEED:Float = 50;

	private var direction = 1;

	override public function update(elapsed:Float) {
		if (this.velocity.y > 0 && this.y >= FlxG.height) {
			this.y = 0;
		}
		else if (this.velocity.y < 0 && (this.y + this.height) <= 0) {
			this.y = FlxG.height;
		}

		if (this.velocity.x > 0 && this.x >= FlxG.width) {
			this.x = -(this.width);
		}
		else if (this.velocity.x < 0 && (this.x + this.width) <= 0) {
			this.x = FlxG.width;
		}

		super.update(elapsed);
	}

	public function getVelocity():FlxPoint {
		// Accelerate until max speed is reached
		if (FlxG.keys.pressed.W) {
			this.velocity.y - SPEED;
		}

		if (FlxG.keys.pressed.S) {
			this.velocity.y + SPEED;
		}

		if (FlxG.keys.pressed.A) {
			this.velocity.x - SPEED;
		}

		if (FlxG.keys.pressed.D) {
			this.velocity.x + SPEED;
		}

		return FlxPoint.weak(SPEED * direction, 0);
	}
}
