package entities;

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

class BlueBox extends BaseBox
{
    public function new(x:Float, y:Float)
    {
		super(x, y, FlxColor.BLUE);
		
    }

	public function updateBehavior(bigBox:EnemyBox):Void
	{

		MoveTowards(bigBox, 10); 
		// If close enough, disable the cannon
		if (distanceToTarget < 20)
		{
			bigBox.disableCannon(3); // Disable the cannon for 3 seconds
			kill(); // Remove the BlueBox after it disables the cannon
		}
    }
}
