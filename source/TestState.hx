package;

import flixel.FlxState;
import flixel.math.FlxVelocity;
import flixel.util.FlxColor;
import tank.Tank;
import tank.TankFactory;
import tank.controller.move.HorizontalMoveController;
import tank.controller.shoot.SpinShootController;

class TestState extends FlxState {
	override public function create() {
		super.create();
		bgColor = FlxColor.WHITE;

		setUpHorizontalTank();
		setUpMouseFollowTanks();
	}

	private function setUpHorizontalTank() {
		var tank = new Tank(300, 50);
		tank.setControllers(new HorizontalMoveController(tank), new SpinShootController(tank));
		add(tank.getAllSprites());
		return tank.getPosition();
	}

	private function setUpMouseFollowTanks() {
		for (x in 0...7) {
			for (y in 0...5) {
				var dumbTank = TankFactory.NewDumbTank(x * 100, y * 100);
				add(dumbTank.getAllSprites());
			}
		}
		var idleTank = TankFactory.NewIdleTank(100, 100);
		add(idleTank.getAllSprites());
		return idleTank;
	}

	override public function update(elapsed:Float) {
		// FlxVelocity.moveTowardsPoint(setUpMouseFollowTanks(), setUpHorizontalTank(), 20);

		super.update(elapsed);
	}
}
