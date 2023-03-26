package tank;

import tank.controller.move.KeyboardMoveController;
import tank.controller.move.MouseFollowMoveController;
import tank.controller.shoot.MouseShootController;
import tank.controller.shoot.SpinShootController;

abstract class TankFactory {
	static inline public function NewDumbTank(X:Float = 0, Y:Float = 0) {
		var tank = new Tank(X, Y, AssetPaths.dumb_tank_body__png);
		tank.setControllers(new MouseFollowMoveController(tank), new SpinShootController(tank));
		return tank;
	}

	static inline public function NewPlayerTank(X:Float = 0, Y:Float = 0) {
		var tank = new Tank(X, Y, AssetPaths.tank_body_placeholder__png);
		tank.setControllers(new KeyboardMoveController(tank), new MouseShootController(tank));
		return tank;
	}
}
