package entities;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

class Projectile extends SVGBox
{
	public var Damage:Int = 10;
	public var EnemyProjectile:Bool;

	public function new(x:Float, y:Float, velocity:FlxPoint, color:FlxColor, size:Int, enemyProjectile:Bool)
    {
		// super(x, y);
		// makeGraphic(size, size, color); // Example size and color
		super(x, y, size, color, null);
		EnemyProjectile = enemyProjectile;
		this.velocity = velocity; // Set the projectile's velocity
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

		// Check if the projectile is off the screen
		if (x + width < 0 || x > FlxG.width || y + height < 0 || y > FlxG.height)
		{
			kill();
		}
    }
}
