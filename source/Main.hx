package;

import flixel.FlxGame;
import states.PlayState;

class Main extends FlxGame
{
    public function new()
    {
        super(1640, 1480, PlayState);
    }
}
