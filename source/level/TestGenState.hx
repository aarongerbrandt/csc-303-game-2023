package level;

import flixel.FlxG;
import flixel.FlxState;
import flixel.tile.FlxTilemap;
import level.LevelGenerator;
import tank.Tank;
import tank.TankFactory;
import tank.controller.move.DynamicMovementController;
import tank.controller.move.HorizontalMoveController;
import tank.controller.shoot.AutoAimController;
import tank.controller.shoot.SpinShootController;

class TestGenState extends FlxState {
	private static var TILE_HEIGHT(default, never):Int = 32;
	private static var TILE_WIDTH(default, never):Int = 32;

	private static var LEVEL_HEIGHT(default, never):Int = 32;
	private static var LEVEL_WIDTH(default, never):Int = 32;

	private var map:FlxTilemap;

	private var targetTank:Tank;
	private var enemyTank:Tank;

	override public function create() {
		super.create();

		var gen = new LevelGenerator(20, 20);
		var bitmap = gen.generateLevel();

		map = new FlxTilemap();
		trace(bitmap);
		map.loadMapFrom2DArray(bitmap, AssetPaths.Wall__png, TILE_WIDTH, TILE_HEIGHT);

		add(map);

		setUpHorizontalTank();
		targetTank = setUpPlayerTank();
		enemyTank = setUpDynamicTank(targetTank, map);
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
		return playerTank;
	}

	private function setUpDynamicTank(target, tileMap) {
		var dynamicTank = new Tank(50, 500);
		dynamicTank.setControllers(new DynamicMovementController(dynamicTank, target, tileMap),
			new AutoAimController(dynamicTank, target));
		add(dynamicTank.getAllSprites());
		return dynamicTank;
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);

		FlxG.collide(targetTank, map);
		FlxG.collide(targetTank, enemyTank);
		FlxG.collide(enemyTank, map);
	}
}
