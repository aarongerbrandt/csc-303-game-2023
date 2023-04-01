package;

import flixel.FlxState;
import flixel.util.FlxColor;
import tank.Tank;
import tank.TankFactory;
import tank.controller.move.HorizontalMoveController;
import tank.controller.shoot.SpinShootController;

class TestState extends FlxState {
	override public function create() {
		super.create();
		bgColor = FlxColor.WHITE;

		var targetTank = setUpHorizontalTank();
		setUpMouseFollowTanks();
		setUpPlayerTank();

		var hud = new HUD();
		add(hud);
	}

	private function setUpHorizontalTank() {
		var tank = new Tank(300, 50);
		tank.setControllers(new HorizontalMoveController(tank), new SpinShootController(tank));
		add(tank.getAllSprites());
		return tank;
	}

	private function setUpPlayerTank() {
		var playerTank = TankFactory.NewPlayerTank(100, 50);
		add(playerTank.getAllSprites());
	}

	private function setUpMouseFollowTanks() {
		for (x in 0...7) {
			for (y in 0...5) {
				var dumbTank = TankFactory.NewDumbTank(x * 100, y * 100);
				add(dumbTank.getAllSprites());
			}
		}
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}
}
