package level;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import level.LevelGenerator;
import projectile.Projectile;
import projectile.SimpleBullet;
import tank.Tank;
import tank.TankFactory;

class TestGenState extends FlxState {
	private static var TILE_HEIGHT(default, never):Int = 32;
	private static var TILE_WIDTH(default, never):Int = 32;

	private static var LEVEL_HEIGHT(default, never):Int = 20;
	private static var LEVEL_WIDTH(default, never):Int = 20;

	private var map:FlxTilemap;

	private var playerTank:Tank;
	private var enemyTanks:FlxTypedGroup<Tank>;

	override public function create() {
		super.create();

		var bitmap = LevelGenerator.generateLevel(LEVEL_HEIGHT, LEVEL_WIDTH);

		map = new FlxTilemap();
		map.loadMapFrom2DArray(bitmap, AssetPaths.Wall__png, TILE_WIDTH, TILE_HEIGHT);

		add(map);
		addTanks();
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);

		FlxG.collide(playerTank, map);
		FlxG.collide(enemyTanks, map);

		FlxG.collide(playerTank.bullets, map, function onCollision(bullets, map) {
			bullets.impact("map");
		});
		FlxG.collide(playerTank.bullets, enemyTanks, function onCollision(bullets, enemyTank) {
			bullets.impact("tank");
		});
		FlxG.collide(playerTank.bullets, playerTank, function onCollision(bullets, playerTank) {
			bullets.impact("tank");
		});

		for (tank in enemyTanks) {
			FlxG.collide(tank.bullets, map, function onCollision(bullets, map) {
				bullets.impact("map");
			});

			FlxG.collide(tank.bullets, enemyTanks, function onCollision(bullets, enemyTank) {
				bullets.impact("tank");
			});

			FlxG.collide(tank.bullets, playerTank, function onCollision(bullets, playerTank) {
				bullets.impact("tank");
			});
		}
	}

	private function addTanks() {
		var tankCoordinates = [250, 300, 350];
		playerTank = TankFactory.NewPlayerTank(500, 500);

		enemyTanks = new FlxTypedGroup<Tank>(3);
		for (x in tankCoordinates) {
			var enemy = TankFactory.NewDumbTank(x, 50);
			enemyTanks.add(enemy);
		}

		add(playerTank.getAllSprites());
		for (enemyTank in enemyTanks) {
			add(enemyTank.getAllSprites());
		}
	}
}
