package entities;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class GreenBox extends BaseBox
{
	private var dartTimer:FlxTimer;

    public function new(x:Float, y:Float)
    {
		super(x, y, FlxColor.GREEN);
		// makeGraphic(100, 100, FlxColor.GREEN);
		dartTimer = new FlxTimer();
		dartTimer.start(1, onDartThrow, 0); // Throws a dart every 1 second
    }

    public function updateBehavior(bigBox:BigBox):Void
    {
		MoveTowards(bigBox, 20); 
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
