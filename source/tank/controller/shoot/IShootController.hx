package tank.controller.shoot;

interface IShootController {
	public var controlledTank:Tank;

	public function update(elapsed:Float):Void;
	public function getAimDegrees():Float;
	public function shouldShoot():Bool;
}
