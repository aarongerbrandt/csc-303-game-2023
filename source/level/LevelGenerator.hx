package level;

import flixel.FlxG;

private class Point {
	public var x:Int;
	public var y:Int;

	public function new(x:Int, y:Int) {
		this.x = x;
		this.y = y;
	}

	public function toString():String {
		return this.x + " " + this.y;
	}
}

/**
 * Contains logic to create random levels.
 * Call generateLevel() to get a bitmap
 */
class LevelGenerator {
	// Defining static constants
	private static var MIN_Y_GAP_SIZE(default, never):Int = 3;
	private static var MIN_X_GAP_SIZE(default, never):Int = 3;
	private static var MIN_WALL_COUNT(default, never):Int = 5;
	private static var MAX_WALL_COUNT(default, never):Int = 12;
	private static var MIN_WALL_SIZE(default, never):Int = 4;
	private static var MAX_WALL_SIZE(default, never):Int = 12;

	private static var BITMAP_EMPTY_BIT(default, never):Int = 0;
	private static var BITMAP_WALL_BIT(default, never):Int = 1;

	// Instantiating Instance Variables
	private var mapWidth:Int;
	private var mapHeight:Int;

	private var minX:Int;
	private var minY:Int;
	private var maxX:Int;
	private var maxY:Int;

	private var map:Array<Array<Int>>;

	public function new(?mapWidth:Int = 20, ?mapHeight:Int = 20) {
		this.mapWidth = mapWidth;
		this.mapHeight = mapHeight;
	}

	/**
	 * Creates a randomly generated level in the form of a 2D Array
	 * @return Array<Array<Int>>	Level map
	 */
	public function generateLevel():Array<Array<Int>> {
		instantiateMap();
		addBorders();
		addObstacles();

		return this.map;
	}

	/**
	 * Populates this.map with an empty 2D Array with width and height specified previously
	 */
	private function instantiateMap() {
		this.map = [for (x in 0...this.mapWidth) [for (y in 0...this.mapHeight) BITMAP_EMPTY_BIT]];
	}

	private function addBorders() {
		// Define bounds for borders
		this.minX = MIN_X_GAP_SIZE;
		this.minY = MIN_Y_GAP_SIZE;
		this.maxX = this.mapWidth - 1 - MIN_X_GAP_SIZE;
		this.maxY = this.mapHeight - 1 - MIN_Y_GAP_SIZE;

		// Add borders on sides
		for (row in this.map) {
			row[0] = BITMAP_WALL_BIT;
			row[row.length - 1] = BITMAP_WALL_BIT;
		}

		// Replace all items in first and last rows with walls
		this.map[0] = [for (_ in 0...this.mapWidth) BITMAP_WALL_BIT];
		this.map[this.map.length - 1] = [for (_ in 0...this.mapWidth) BITMAP_WALL_BIT];
	}

	private function addObstacles() {
		var random = FlxG.random;

		var numWalls:Int = random.int(MIN_WALL_COUNT, MAX_WALL_COUNT);
		for (wall in 0...numWalls) {
			var validPlacement:Bool = false;

			var direction:Int = -1;
			var distance:Int;
			var startingPoint:Point = null;
			var finalPoint:Point = null;

			while (!validPlacement) {
				var startX:Int = random.int(this.minX, this.maxX);
				var startY:Int = random.int(this.minY, this.maxY);
				startingPoint = new Point(startX, startY);

				// 0 - Up
				// 1 - Right
				// 2 - Down
				// 3 - Up
				direction = random.int(0, 3);
				distance = random.int(MIN_WALL_SIZE, MAX_WALL_SIZE);

				finalPoint = switch (direction) {
					case 0: // Up
						new Point(startingPoint.x, startingPoint.y + distance);
					case 1: // Right
						new Point(startingPoint.x + distance, startingPoint.y);
					case 2: // Down
						new Point(startingPoint.x, startingPoint.y - distance);
					case 3: // Left
						new Point(startingPoint.x - distance, startingPoint.y);
					default:
						trace("Invalid direction! " + direction);
						null;
				}

				// Ensure end of wall is within bounds
				var validX:Bool = finalPoint.x > this.minX && finalPoint.x < this.maxX;
				var validY:Bool = finalPoint.y > this.minY && finalPoint.y < this.maxY;

				validPlacement = validX && validY;
			}

			drawWall(startingPoint, finalPoint, direction);
		}
	}

	private function drawWall(startingPoint:Point, finalPoint:Point, direction:Int) {
		switch (direction) {
			case 0 | 2: // Up/Down
				for (y in startingPoint.y...finalPoint.y) {
					this.map[y][startingPoint.x] = BITMAP_WALL_BIT;
				}
			case 1 | 3: // Left/Right
				for (x in startingPoint.x...finalPoint.x) {
					this.map[startingPoint.y][x] = BITMAP_WALL_BIT;
				}
			default:
				trace("Unknown direction: " + direction);
				return;
		}
	}
}
