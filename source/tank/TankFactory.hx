package tank;

import flixel.tile.FlxTilemap;
import tank.Tank;
import tank.controller.move.DynamicMovementController;
import tank.controller.move.KeyboardMoveController;
import tank.controller.move.MouseFollowMoveController;
import tank.controller.shoot.AutoAimController;
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

	static inline public function NewDynamicTank(X:Float = 0, Y:Float = 0, target:Tank,
			map:FlxTilemap) {
		var tank = new Tank(X, Y, AssetPaths.green_tank_body__png);
		tank.setControllers(new DynamicMovementController(tank, target, map),
			new AutoAimController(tank, target, map));
		return tank;
	}
}
