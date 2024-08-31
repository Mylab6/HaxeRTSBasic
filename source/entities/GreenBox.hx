package entities;

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

class GreenBox extends FlxSprite
{
    public function new(x:Float, y:Float)
    {
        super(x, y);
        makeGraphic(10, 10, FlxColor.GREEN);
    }

    public function updateBehavior(bigBox:BigBox):Void
    {
        // Implement shooting behavior
    }
}
