package level;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxObject;
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

	public var map:FlxTilemap;

	private var playerTank:Tank;
	private var dynamicTank:Tank;
	private var pursuitTank:Tank;
	private var enemyTanks:FlxTypedGroup<Tank>;
	private var allProjectiles:FlxGroup;

	var hud:HUD;
	var score:Int;
	var level:Int;

	public function new(currentScore:Int = 0, currentLevel:Int = 1) {
		super();
		score = currentScore;
		level = currentLevel;
	}

	override public function create() {
		super.create();

		var bitmap = LevelGenerator.generateLevel(LEVEL_HEIGHT, LEVEL_WIDTH);

		map = new FlxTilemap();
		map.loadMapFrom2DArray(bitmap, AssetPaths.Wall__png, TILE_WIDTH, TILE_HEIGHT);

		add(map);
		addTanks();

		hud = new HUD(enemyTanks.length, score, level);
		add(hud);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);

		#if FLX_DEBUG
		if (FlxG.keys.justPressed.K) {
			enemyTanks.getFirstAlive().kill();
			hud.registerEnemyTankKill();
		}
		#end

		FlxG.collide(playerTank, map);
		FlxG.collide(enemyTanks, map);

		doBulletCollision(allProjectiles);
		checkFinished();
	}

	private function addTanks() {
		var tankCoordinates = [250, 300, 350, 400, 450];
		playerTank = TankFactory.NewPlayerTank(500, 500);

		enemyTanks = new FlxTypedGroup<Tank>();
		var dynamicTank = TankFactory.NewDynamicTank(50, 100, playerTank, map);
		var pursuitTank = TankFactory.NewPursuitTank(200, 400, playerTank, map);

		for (x in tankCoordinates) {
			var enemy = TankFactory.NewDumbTank(x, 50);
			enemyTanks.add(enemy);
		}

		enemyTanks.add(dynamicTank);
		enemyTanks.add(pursuitTank);

		allProjectiles = new FlxGroup();

		add(playerTank.getAllSprites());
		playerTank.bullets.forEach(allProjectiles.add);
		for (enemyTank in enemyTanks) {
			add(enemyTank.getAllSprites());
			enemyTank.bullets.forEach(allProjectiles.add);
		}
	}

	private function doBulletCollision(bullets:FlxBasic) {
		FlxG.collide(bullets, map, function onOverlap(bullets, map) {
			bullets.impact("wall");
		});
		FlxG.overlap(bullets, enemyTanks, function onOverlap(bullets, enemyTank) {
			bullets.impact("tank");
			enemyTank.kill();
			hud.registerEnemyTankKill();
		});
		FlxG.overlap(bullets, playerTank, function onOverlap(bullets, playerTank) {
			bullets.impact("tank");
			playerTank.kill();
		});
		FlxG.overlap(bullets, null, function onOverlap(bullet1, bullet2) {
			bullet1.impact("projectile");
			bullet2.impact("projectile");
		});
	}

	private function checkFinished() {
		if (enemyTanks.countLiving() <= 0) {
			score = hud.getScore();
			level = hud.getLevel();
			FlxG.switchState(new FinishedLevelState(score, level));
		}
		else if (!playerTank.alive) {
			FlxG.switchState(new StartMenuState());
		}
	}
}
