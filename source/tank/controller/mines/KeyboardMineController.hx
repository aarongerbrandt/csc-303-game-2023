package tank.controller.mines;

import flixel.FlxG;

class KeyboardMineController extends BaseController implements IMineController {
	static inline public var PLACE_MINE_TIMER = 5;

	private var mineTimerRemaining:Float = PLACE_MINE_TIMER;

	override public function update(elapsed:Float):Void {
		if (mineTimerRemaining > 0) {
			mineTimerRemaining -= elapsed;
		}
	}

	public function shouldPlaceMine():Bool {
		// True if space pressed and not on cooldown
		return FlxG.keys.pressed.SPACE && mineTimerRemaining == 0;
	}
}
