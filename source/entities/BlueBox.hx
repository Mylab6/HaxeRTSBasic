package entities;

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

class BlueBox extends FlxSprite
{
    public function new(x:Float, y:Float)
    {
        super(x, y);
        makeGraphic(10, 10, FlxColor.BLUE);
    }

    public function updateBehavior(bigBox:BigBox):Void
    {
        /*if (FlxPoint.distanceTo(getMidpoint(), bigBox.getMidpoint()) < 50)
        {
            // Implement slowing behavior
        } 
        */
    }
}
