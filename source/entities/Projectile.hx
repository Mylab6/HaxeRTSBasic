package entities;

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

class Projectile extends FlxSprite
{
    public var speed:Float;

    public function new(x:Float, y:Float, target:FlxPoint)
    {
        super(x, y);
        makeGraphic(10, 10, FlxColor.RED); // Ensure the projectile has a visible color
        speed = 200; // Adjust speed to ensure it's visible

        // Calculate direction towards the target
        var direction:FlxPoint = new FlxPoint(target.x - x, target.y - y);
        direction.normalize();

        velocity.x = direction.x * speed;
        velocity.y = direction.y * speed;
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        // Destroy the projectile if it goes off-screen
      //  if (!onScreen())
        //{
          //  kill();
        //}
    }
}
