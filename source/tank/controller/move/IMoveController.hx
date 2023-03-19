package tank.controller.move;

import flixel.math.FlxPoint;

interface IMoveController {
	public var controlledTank:Tank;

	public function update(elapsed:Float):Void;

	public function getVelocity():FlxPoint;
}
