package entities;

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

class RedBox extends FlxSprite
{
    public function new(x:Float, y:Float)
    {
        super(x, y);
		makeGraphic(100, 100, FlxColor.RED);
    }

    public function updateBehavior(bigBox:BigBox):Void
    {
        var direction:FlxPoint = FlxPoint.get(bigBox.x - x, bigBox.y - y).normalize();
        velocity.set(direction.x * 100, direction.y * 100);

        if (overlaps(bigBox))
        {
           // bigBox.takeDamage(10);
            kill();
        }
    }
}
