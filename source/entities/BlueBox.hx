package entities;

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

class BlueBox extends BaseBox
{
    public function new(x:Float, y:Float)
    {
		super(x, y, FlxColor.BLUE, 65);
		// tank
		//
		movementSpeed = 30;
		HP = 50; 
		
    }

	public function updateBehavior(bigBox:EnemyBox):Void
	{

		MoveTowards(bigBox, -10, true); 
		// If close enough, disable the cannon

    }
}
