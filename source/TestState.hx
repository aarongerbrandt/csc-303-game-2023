package;

import flixel.FlxState;
import flixel.util.FlxColor;
import tank.Tank;
import tank.TankFactory;
import tank.controller.move.HorizontalMoveController;
import tank.controller.move.PursuePlayerMovementController;
import tank.controller.shoot.SpinShootController;

class TestState extends FlxState {
	override public function create() {
		super.create();
		bgColor = FlxColor.WHITE;

		var targetTank = setUpHorizontalTank();
		setUpIdleTank1(targetTank);
		setUpIdleTank2(targetTank);
		setUpMouseFollowTanks();
	}

	private function setUpHorizontalTank() {
		var tank = new Tank(300, 50);
		tank.setControllers(new HorizontalMoveController(tank), new SpinShootController(tank));
		add(tank.getAllSprites());
		return tank;
	}

	private function setUpMouseFollowTanks() {
		for (x in 0...7) {
			for (y in 0...5) {
				var dumbTank = TankFactory.NewDumbTank(x * 100, y * 100);
				add(dumbTank.getAllSprites());
			}
		}
	}

	private function setUpIdleTank1(targetTank) {
		var idleTank = new Tank(100, 100);
		idleTank.setControllers(new PursuePlayerMovementController(idleTank, targetTank),
			new SpinShootController(idleTank));
		add(idleTank.getAllSprites());
	}

	private function setUpIdleTank2(targetTank) {
		var idleTank = new Tank(300, 400);
		idleTank.setControllers(new PursuePlayerMovementController(idleTank, targetTank),
			new SpinShootController(idleTank));
		add(idleTank.getAllSprites());
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}
}
