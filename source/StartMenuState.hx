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

		var playButton = createMenuButton("Play Game", () -> {
			FlxG.switchState(new PlayState());
		}, 0, -96);
		add(playButton);

		#if html5
		#else
		var exitButton = createMenuButton("Exit", () -> {
			Sys.exit(0);
		}, 0, 64);
		add(exitButton);
		#end
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}

	private function createMenuButton(labelText:String, onClick:Void->Void, ?xOffset:Int = 0,
			?yOffset:Int = 0):FlxButton {
		var button = new FlxButton(0, 0, labelText, onClick);
		button.makeGraphic(BUTTON_WIDTH, BUTTON_HEIGHT, BUTTON_COLOR);
		button.label.size = 72;
		button.width = button.label.width;
		button.height = button.label.height;
		button.screenCenter();

		button.x += xOffset;
		button.y += yOffset;

		return button;
	}
}
