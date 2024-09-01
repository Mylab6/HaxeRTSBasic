package entities;

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

class Projectile extends FlxSprite
{
	public function new(x:Float, y:Float, velocity:FlxPoint, color:FlxColor, size:Int)
    {
        super(x, y);
		makeGraphic(size, size, color); // Example size and color
		this.velocity = velocity; // Set the projectile's velocity
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        // Destroy the projectile if it goes off-screen
		/*if (!onScreen())
			{
				kill();
		}*/
    }
}
