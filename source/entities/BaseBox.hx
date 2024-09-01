package entities;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.effects.particles.FlxEmitter;
import flixel.math.FlxPoint;
import flixel.math.FlxRandom;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class BaseBox extends SVGBox
{
	public var emitter:FlxEmitter;
	public var Damage:Int = 10;
	public var distanceToTarget:Float;
	public var movementSpeed:Float = 100; 
	public var HP:Int = 20;

	private var kickbackVelocity:FlxPoint;
	private var recoveringFromKickback:Bool = false;

    public function new(x:Float, y:Float, color:Int)
    {
		super(x, y, 45, color, null);

        // Create a particle emitter
        emitter = new FlxEmitter(x + width / 2, y + height / 2, 50);
		emitter.makeParticles(5, 5, color, 50); // Create particles matching the box color
    }

	public function MoveTowards(bigBox:EnemyBox, minDistance:Float = -10):Void
	{
		if (recoveringFromKickback)
			return;

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
			bigBox.TakeDamage(Damage);
			kill();
		}
	}
	public function hit(damage:Int, sourceX:Float, sourceY:Float):Void
    {
        // Position the emitter at the box's position
        emitter.setPosition(x + width / 2, y + height / 2);
        
        // Start the particle effect
        emitter.start(true, 0.5, 10); // Play the particle effect

		// Apply damage to HP
		HP = HP - damage;
		if (HP <= 0)
		{
			kill();
		}
		else
		{
			// Calculate the kickback direction and apply a randomized velocity opposite to the hit source
			var kickbackDirection:FlxPoint = FlxPoint.get(x - sourceX, y - sourceY).normalize();

			// Randomize the magnitude of the kickback within a range
			var kickbackMagnitude:Float = 100 + new FlxRandom().float(50, 150);

			// Apply the randomized kickback velocity
			kickbackVelocity = new FlxPoint(kickbackDirection.x * kickbackMagnitude, kickbackDirection.y * kickbackMagnitude);
			velocity.set(kickbackVelocity.x, kickbackVelocity.y);

			// Trigger the slowdown and recovery process
			recoveringFromKickback = true;
			FlxTimer.wait(0.5, slowDown);
		}
	}

	private function slowDown():Void
	{
		// Gradually reduce the velocity to simulate a slowdown
		velocity.set(kickbackVelocity.x * 0.5, kickbackVelocity.y * 0.5);
		FlxTimer.wait(0.5, recoverSpeed);
	}

	private function recoverSpeed():Void
	{
		// Reset the velocity to normal and resume regular movement
		velocity.set(0, 0);
		recoveringFromKickback = false;
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        // Update the emitter position in case the box moves
        emitter.setPosition(x + width / 2, y + height / 2);
		// Remove the box if it goes off-screen
		if (x + width < 0 || x > FlxG.width || y + height < 0 || y > FlxG.height)
		{
			kill();
		}
    }
}
