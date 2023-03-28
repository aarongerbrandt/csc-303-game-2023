package level;

import flixel.FlxState;
import flixel.tile.FlxTilemap;
import level.LevelGenerator;
import tank.Tank;
import tank.TankFactory;
import tank.controller.move.DynamicMovementController;
import tank.controller.move.HorizontalMoveController;
import tank.controller.move.PursuePlayerMovementController;
import tank.controller.shoot.AutoAimController;
import tank.controller.shoot.SpinShootController;

class TestGenState extends FlxState {
	private static var TILE_HEIGHT(default, never):Int = 32;
	private static var TILE_WIDTH(default, never):Int = 32;

	private static var LEVEL_HEIGHT(default, never):Int = 32;
	private static var LEVEL_WIDTH(default, never):Int = 32;

	override public function create() {
		super.create();

		var gen = new LevelGenerator(20, 20);
		var bitmap = gen.generateLevel();

		var map = new FlxTilemap();
		trace(bitmap);
		map.loadMapFrom2DArray(bitmap, AssetPaths.Wall__png, TILE_WIDTH, TILE_HEIGHT);

		add(map);

		var targetTank = setUpHorizontalTank();
		// setUpPursuitTank1(targetTank);
		// setUpPursuitTank2(targetTank);
		setUpDynamicTank(targetTank);
		setUpPlayerTank();
	}

	private function setUpHorizontalTank() {
		var tank = new Tank(500, 50);
		tank.setControllers(new HorizontalMoveController(tank), new SpinShootController(tank));
		add(tank.getAllSprites());
		return tank;
	}

	private function setUpPlayerTank() {
		var playerTank = TankFactory.NewPlayerTank(100, 50);
		add(playerTank.getAllSprites());
	}

	/*private function setUpPursuitTank1(targetTank) {
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
	}*/
	private function setUpDynamicTank(targetTank) {
		var dynamicTank = new Tank(50, 500);
		dynamicTank.setControllers(new DynamicMovementController(dynamicTank, targetTank),
			new AutoAimController(dynamicTank, targetTank));
		add(dynamicTank.getAllSprites());
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}
}
