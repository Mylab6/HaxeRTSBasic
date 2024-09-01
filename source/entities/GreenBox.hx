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
		var projectile = new Projectile(x + width / 2, y + height / 2, velocity * 2, FlxColor.MAGENTA, 20);
		// projectiles.add(projectile);
		FlxG.state.add(projectile);
    }
}
