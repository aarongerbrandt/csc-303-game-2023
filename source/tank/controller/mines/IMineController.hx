package tank.controller.mines;

interface IMineController {
	public var controlledTank:Tank;

	public function update(elapsed:Float):Void;
	public function shouldPlaceMine():Bool;
}
