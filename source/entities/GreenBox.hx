package entities;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class GreenBox extends FlxSprite
{
	private var dartTimer:FlxTimer;

    public function new(x:Float, y:Float)
    {
        super(x, y);
		makeGraphic(100, 100, FlxColor.GREEN);
		dartTimer = new FlxTimer();
		dartTimer.start(1, onDartThrow, 0); // Throws a dart every 1 second
    }

    public function updateBehavior(bigBox:BigBox):Void
    {
		var boxPoint:FlxPoint = new FlxPoint(x, y);
		var bigBoxPoint:FlxPoint = new FlxPoint(bigBox.x, bigBox.y);
		var distance:Float = boxPoint.distanceTo(bigBoxPoint);

		// If too close, move away from the BigBox
		if (distance < 150) // Adjust to maintain 150 units distance
		{
			var direction:FlxPoint = new FlxPoint(x - bigBox.x, y - bigBox.y);
			direction.normalize();
			velocity.x = direction.x * 100; // Move at a speed of 100 units
			velocity.y = direction.y * 100;
		}
		else
		{
			velocity.x = 0;
			velocity.y = 0; // Stop moving if far enough
		}
	}

	private function onDartThrow(timer:FlxTimer):Void
	{
		// Throw a dart towards the BigBox
		var dartDirection:FlxPoint = new FlxPoint(FlxG.mouse.x - this.x, FlxG.mouse.y - this.y); // Adjust this to bigBox
		dartDirection.normalize();

		var dart = new FlxSprite(this.x, this.y);
		dart.makeGraphic(10, 5, FlxColor.YELLOW); // Simple dart graphic
		dart.velocity.set(dartDirection.x * 200, dartDirection.y * 200); // Set dart speed
		FlxG.state.add(dart);
    }
}
