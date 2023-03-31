package level;

import flixel.FlxG;
import flixel.FlxState;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.system.debug.watch.Watch;
import flixel.tile.FlxTilemap;
import level.LevelGenerator;
import projectile.Projectile;
import projectile.SimpleBullet;
import projectile.rocket.Explosion;
import projectile.rocket.Rocket;
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

		doBulletCollision(playerTank.bullets);
		for (tank in enemyTanks) {
			doBulletCollision(tank.bullets);
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

	private function doBulletCollision(bullets:FlxGroup) {
		FlxG.collide(bullets, map, function onOverlap(bullets, map) {
			bullets.impact("wall");
		});
		FlxG.overlap(bullets, enemyTanks, function onOverlap(bullets, enemyTank) {
			bullets.impact("tank");
		});
		FlxG.overlap(bullets, playerTank, function onOverlap(bullets, playerTank) {
			bullets.impact("tank");
		});
		FlxG.overlap(bullets, null, function onOverlap(bullets, na) {
			bullets.impact("projectile");
		});
	}
}
