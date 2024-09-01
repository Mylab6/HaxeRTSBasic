package entities;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.effects.particles.FlxEmitter;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

class BaseBox extends SVGBox
{
	public var emitter:FlxEmitter;
	public var distanceToTarget:Float;
	public var movementSpeed:Float = 100; 
    public function new(x:Float, y:Float, color:Int)
    {
		super(x, y, 45, color, "assets/images/svgs/box.svg");
        //makeGraphic(50, 50, color);

        // Create a particle emitter
        emitter = new FlxEmitter(x + width / 2, y + height / 2, 50);
        emitter.makeParticles( 2, 2, color, 50 ); // Create particles matching the box color
    }
	public function MoveTowards(bigBox:BigBox, minDistance:Float = -10):Void
	{

		var boxPoint:FlxPoint = new FlxPoint(x, y);
		var bigBoxPoint:FlxPoint = new FlxPoint(bigBox.x, bigBox.y);
		distanceToTarget = boxPoint.distanceTo(bigBoxPoint);
		var finalSpeed:Float = 0;
		if (distanceToTarget < minDistance)
		{
			finalSpeed = movementSpeed * -1;
		}
		else
		{
			finalSpeed = movementSpeed;
		}
		var direction:FlxPoint = FlxPoint.get(bigBox.x - x, bigBox.y - y).normalize();
		velocity.set(direction.x * finalSpeed, direction.y * finalSpeed);

		if (overlaps(bigBox))
		{
			// bigBox.takeDamage(10);
			kill();
		}
	}
    public function hit():Void
    {
        // Position the emitter at the box's position
        emitter.setPosition(x + width / 2, y + height / 2);
        
        // Start the particle effect
        emitter.start(true, 0.5, 10); // Play the particle effect

        // Handle any other hit logic (e.g., reducing health, destroying the box, etc.)
        kill(); // Example: destroy the box when hit
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        // Update the emitter position in case the box moves
        emitter.setPosition(x + width / 2, y + height / 2);
		if (x + width < 0 || x > FlxG.width || y + height < 0 || y > FlxG.height)
		{
			kill();
		}
    }
}
