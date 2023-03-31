package;

import flixel.FlxState;
import flixel.util.FlxColor;
import tank.Tank;
import tank.TankFactory;
import tank.controller.move.DynamicMovementController;
import tank.controller.move.HorizontalMoveController;
import tank.controller.move.PursuePlayerMovementController;
import tank.controller.shoot.AutoAimController;
import tank.controller.shoot.SpinShootController;

class TestState extends FlxState {
	override public function create() {
		super.create();
		bgColor = FlxColor.WHITE;

		var targetTank = setUpHorizontalTank();
		setUpPursuitTank1(targetTank);
		setUpPursuitTank2(targetTank);
		// setUpDynamicTank(targetTank);
		setUpMouseFollowTanks();
		setUpPlayerTank();
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

	private function setUpPursuitTank1(targetTank) {
		var pursuitTank = new Tank(100, 100);
		pursuitTank.setControllers(new PursuePlayerMovementController(pursuitTank, targetTank),
			new SpinShootController(pursuitTank));
		add(pursuitTank.getAllSprites());
	}

	private function setUpPursuitTank2(targetTank) {
		var pursuitTank = new Tank(300, 400);
		pursuitTank.setControllers(new PursuePlayerMovementController(pursuitTank, targetTank),
			new AutoAimController(pursuitTank, targetTank));
		add(pursuitTank.getAllSprites());
	}

	/*private function setUpDynamicTank(targetTank) {
		var dynamicTank = new Tank(50, 300);
		dynamicTank.setControllers(new DynamicMovementController(dynamicTank, targetTank),
			new AutoAimController(dynamicTank, targetTank));
		add(dynamicTank.getAllSprites());
	}*/
	override public function update(elapsed:Float) {
		super.update(elapsed);
	}
}
