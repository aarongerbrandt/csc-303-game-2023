package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import level.TestGenState;

class FinishedLevelState extends FlxState {
	private static var BUTTON_HEIGHT(default, never):Int = 192;
	private static var BUTTON_WIDTH(default, never):Int = 256;
	private static var BUTTON_COLOR(default, never):FlxColor = FlxColor.ORANGE;

	override public function create() {
		super.create();

		var replayButton = new FlxButton(0, 0, "Next Level", () -> {
			FlxG.switchState(new PlayState());
		});

		replayButton.screenCenter();
		replayButton.y -= 64;

		var menuButton = new FlxButton(0, 0, "Return", () -> {
			FlxG.switchState(new StartMenuState());
		});

		menuButton.screenCenter();
		menuButton.y += 64;

		add(replayButton);
		add(menuButton);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}
}
