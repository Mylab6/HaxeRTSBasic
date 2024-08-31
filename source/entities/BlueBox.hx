package entities;

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

class BlueBox extends FlxSprite
{
    public function new(x:Float, y:Float)
    {
        super(x, y);
		makeGraphic(100, 100, FlxColor.BLUE);
    }

    public function updateBehavior(bigBox:BigBox):Void
    {
		// Approach the BigBox
		var direction:FlxPoint = new FlxPoint(bigBox.x - x, bigBox.y - y);
		direction.normalize();

		velocity.x = direction.x * 100; // Adjust speed as needed
		velocity.y = direction.y * 100;
		var currentPosition:FlxPoint = new FlxPoint(x, y);
		var bigBoxPosition:FlxPoint = new FlxPoint(bigBox.x, bigBox.y);

		// If close enough, disable the cannon
		if (currentPosition.distanceTo(bigBoxPosition) < 50)
		{
			bigBox.disableCannon(3); // Disable the cannon for 3 seconds
			kill(); // Remove the BlueBox after it disables the cannon
		}
    }
}
