package level;

import flixel.FlxG;

class LevelNameGenerator {
	static var adjectives = [
		"Heavy", "Light", "Fast", "Slow", "Dangerous", "Rugged", "Barren", "Dusty", "Dry", "Arid",
		"Dirty"
	];
	static var nouns = ["Desert", "Forest", "Canyon", "Mountain", "Jungle", "City", "Factory", "Bunker"];

	static var realOperationNames = [
		"Overlord",
		"Barbarossa",
		"Magic Carpet",
		"Dynamo",
		"Paul Bunyan",
		"Grand Slam",
		"Hush"
	];

	private static var random = FlxG.random;

	public static function generate():String {
		switch (random.int(0, 2)) {
			case 0:
				return adjectiveNounGenerator();
			case 1:
				return operationNameGenerator();
			case 2:
				return operationNameGenerator();
			default:
				return "";
		}
	}

	private static function adjectiveNounGenerator():String {
		var adjective = adjectives[random.int(0, adjectives.length)];
		var noun = nouns[Std.random(nouns.length)];
		return adjective + " " + noun;
	}

	private static function operationNameGenerator():String {
		var operationName:String;
		if (random.bool()) {
			// use real operation names
			operationName = "Operation "
				+ realOperationNames[random.int(0, realOperationNames.length)];
		}
		else {
			// generate operation name
			operationName = "";
		}
		return "";
	}
}
