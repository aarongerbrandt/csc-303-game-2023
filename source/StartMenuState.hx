package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import level.TestGenState;

class StartMenuState extends FlxState {
	private static var BUTTON_HEIGHT(default, never):Int = 192;
	private static var BUTTON_WIDTH(default, never):Int = 256;
	private static var BUTTON_COLOR(default, never):FlxColor = FlxColor.ORANGE;

	override public function create() {
		super.create();

		var button = new FlxButton(0, 0, "Play Game", onPlayButtonPressed);
		button.makeGraphic(BUTTON_WIDTH, BUTTON_HEIGHT, BUTTON_COLOR);
		button.label.size = 72;
		button.width = button.label.width;
		button.height = button.label.height;
		button.screenCenter();
		add(button);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}

	function onPlayButtonPressed():Void {
		FlxG.switchState(new TestGenState());
	}
}
