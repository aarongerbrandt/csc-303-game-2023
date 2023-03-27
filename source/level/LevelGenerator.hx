package level;

import flixel.FlxG;
import flixel.math.FlxPoint;
import haxe.EnumTools;

enum Direction {
	Up;
	Right;
	Down;
	Left;
}

/**
 * Contains logic to create random levels.
 * Call generateLevel() to get a bitmap
 */
class LevelGenerator {
	// Defining static constants
	private static var MIN_GAP_SIZE_Y(default, never):Int = 3;
	private static var MIN_GAP_SIZE_X(default, never):Int = 3;
	private static var WALL_COUNT_MIN(default, never):Int = 5;
	private static var WALL_COUNT_MAX(default, never):Int = 12;
	private static var WALL_SIZE_MIN(default, never):Int = 4;
	private static var WALL_SIZE_MAX(default, never):Int = 12;

	private static var BITMAP_INDEX_EMPTY(default, never):Int = 0;
	private static var BITMAP_INDEX_WALL(default, never):Int = 1;

	// Instantiating Instance Variables
	private var mapWidth:Int;
	private var mapHeight:Int;

	public function new(?mapWidth:Int = 20, ?mapHeight:Int = 20) {
		this.mapWidth = mapWidth;
		this.mapHeight = mapHeight;
	}

	/**
	 * Creates a randomly generated level in the form of a 2D Array
	 * @return Array<Array<Int>>	Level map
	 */
	public function generateLevel():Array<Array<Int>> {
		var map = instantiateMap();
		map = addBordersToMap(map);
		map = addObstaclesToMap(map);

		return map;
	}

	/**
	 * Populates this.map with an empty 2D Array with width and height specified previously
	 */
	private function instantiateMap():Array<Array<Int>> {
		return [for (x in 0...this.mapWidth) [for (y in 0...this.mapHeight) BITMAP_INDEX_EMPTY]];
	}

	private function addBordersToMap(map:Array<Array<Int>>) {
		// Add borders on sides
		for (row in map) {
			row[0] = BITMAP_INDEX_WALL;
			row[row.length - 1] = BITMAP_INDEX_WALL;
		}

		// Replace all items in first and last rows with walls
		map[0] = [for (_ in 0...this.mapWidth) BITMAP_INDEX_WALL];
		map[map.length - 1] = [for (_ in 0...this.mapWidth) BITMAP_INDEX_WALL];

		return map;
	}

	private function addObstaclesToMap(map:Array<Array<Int>>) {
		// Define bounds for borders
		var minX = MIN_GAP_SIZE_X;
		var minY = MIN_GAP_SIZE_Y;
		var maxX = this.mapWidth - 1 - MIN_GAP_SIZE_X;
		var maxY = this.mapHeight - 1 - MIN_GAP_SIZE_Y;

		var random = FlxG.random;

		var numWalls:Int = random.int(WALL_COUNT_MIN, WALL_COUNT_MAX);
		for (wall in 0...numWalls) {
			var validPlacement:Bool = false;

			var direction:Direction = null;
			var distance:Int;
			var startingPoint:FlxPoint = null;
			var finalPoint:FlxPoint = null;

			while (!validPlacement) {
				var startX:Int = random.int(minX, maxX);
				var startY:Int = random.int(minY, maxY);
				startingPoint = FlxPoint.weak(startX, startY);
				direction = EnumTools.createByIndex(Direction, random.int(0, 3));
				distance = random.int(WALL_SIZE_MIN, WALL_SIZE_MAX);

				finalPoint = switch (direction) {
					case Up:
						FlxPoint.weak(startingPoint.x, startingPoint.y + distance);
					case Right:
						FlxPoint.weak(startingPoint.x + distance, startingPoint.y);
					case Down:
						FlxPoint.weak(startingPoint.x, startingPoint.y - distance);
					case Left:
						FlxPoint.weak(startingPoint.x - distance, startingPoint.y);
					default:
						trace("Invalid direction! " + direction);
						null;
				}

				// Ensure end of wall is within bounds
				var validX:Bool = finalPoint.x > minX && finalPoint.x < maxX;
				var validY:Bool = finalPoint.y > minY && finalPoint.y < maxY;

				validPlacement = validX && validY;
			}

			drawWall(map, startingPoint, finalPoint, direction);
		}

		return map;
	}

	private function drawWall(map:Array<Array<Int>>, startingPoint:FlxPoint, finalPoint:FlxPoint,
			direction:Direction) {
		switch (direction) {
			case Up | Down:
				for (y in Std.int(startingPoint.y)...Std.int(finalPoint.y)) {
					map[y][Std.int(startingPoint.x)] = BITMAP_INDEX_WALL;
				}
			case Right | Left:
				for (x in Std.int(startingPoint.x)...Std.int(finalPoint.x)) {
					map[Std.int(startingPoint.y)][x] = BITMAP_INDEX_WALL;
				}
			default:
				trace("Unknown direction: " + direction);
				return;
		}
	}
}
