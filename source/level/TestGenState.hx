package level;

import flixel.FlxState;
import flixel.tile.FlxTilemap;
import level.LevelGenerator;

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
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}
}
