package tank.controller;

import tank.controller.move.IMoveController;
import tank.controller.shoot.IShootController;

abstract class BaseController {
	public var controlledTank:Tank;

	public function new(ControlledTank:Tank) {
		controlledTank = ControlledTank;
	}

	public function update(elapsed:Float) {}
}
