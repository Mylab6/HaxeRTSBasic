package;

import flixel.FlxGame;
import states.PlayState;

class Main extends FlxGame
{
    public function new()
    {
		super(0, 0, PlayState);
    }
}
