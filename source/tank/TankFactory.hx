package tank;

import tank.Tank;
import tank.controller.move.MouseFollowMoveController;
import tank.controller.shoot.SpinShootController;

abstract class TankFactory {
	static inline public function NewDumbTank(X:Float = 0, Y:Float = 0) {
		var tank = new Tank(X, Y, AssetPaths.dumb_tank_body__png);
		tank.setControllers(new MouseFollowMoveController(tank), new SpinShootController(tank));
		return tank;
	}
}
