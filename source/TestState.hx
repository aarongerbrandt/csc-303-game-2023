package;

import flixel.FlxState;
import flixel.util.FlxColor;
import tank.Tank;
import tank.TankFactory;
import tank.controller.move.HorizontalMoveController;
import tank.controller.move.KeyboardMoveController;
import tank.controller.shoot.MouseShootController;
import tank.controller.shoot.SpinShootController;

class TestState extends FlxState {
	override public function create() {
		super.create();
		bgColor = FlxColor.WHITE;

		setUpHorizontalTank();
		// setUpMouseFollowTanks();
		setUpPlayerTank();
	}

	private function setUpHorizontalTank() {
		var tank = new Tank(300, 50);
		tank.setControllers(new HorizontalMoveController(tank), new SpinShootController(tank));
		add(tank.getAllSprites());
	}

	private function setUpPlayerTank() {
		var tank = new Tank(100, 50);
		tank.setControllers(new KeyboardMoveController(tank), new MouseShootController(tank));
		add(tank.getAllSprites());
	}

	// private function setUpMouseFollowTanks() {
	// 	for (x in 0...35) {
	// 		for (y in 0...10) {
	// 			var dumbTank = TankFactory.NewDumbTank(x * 50, y * 50);
	// 			add(dumbTank.getAllSprites());
	// 		}
	// 	}
	// }

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}
}
