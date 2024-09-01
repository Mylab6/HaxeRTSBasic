package entities;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class GreenBox extends BaseBox
{
	private var dartTimer:FlxTimer;
	private var projectiles:FlxGroup;

	public function new(x:Float, y:Float, projectiles:FlxGroup)
    {
		super(x, y, FlxColor.GREEN);
		this.projectiles = projectiles;

		// makeGraphic(100, 100, FlxColor.GREEN);
		dartTimer = new FlxTimer();
		dartTimer.start(5, onDartThrow, 3); // Throws a dart every 1 second
    }

	public function updateBehavior(bigBox:EnemyBox):Void
    {
		MoveTowards(bigBox, 20); 
	}

	private function onDartThrow(timer:FlxTimer):Void
	{
		// Throw a dart towards the BigBox
		var dartDirection:FlxPoint = new FlxPoint(FlxG.mouse.x - this.x, FlxG.mouse.y - this.y); // Adjust this to bigBox
		dartDirection.normalize();
		var projectile = new Projectile(x + width / 2, y + height / 2, velocity * 2, FlxColor.fromString("#006400"), 30, false);
		projectiles.add(projectile);
		// FlxG.state.add(projectile);
    }
}
