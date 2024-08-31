package entities;

import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class BigBox extends FlxSprite
{
    public var turretAngle:Float;
    public var fireRate:Float;
    private var timeSinceLastShot:Float;
    private var projectiles:FlxGroup;
	private var cannonDisabled:Bool;
	private var disableTimer:FlxTimer;

	public var aimLine:FlxSprite; // Aiming line

    public function new(x:Float, y:Float, projectiles:FlxGroup)
    {
        super(x, y);
		makeGraphic(100, 100, FlxColor.BLUE);
        turretAngle = 0;
		fireRate = 0.5; // Reduced for faster shooting
        timeSinceLastShot = 0;
		this.projectiles = projectiles;
		this.cannonDisabled = false;
		this.disableTimer = new FlxTimer();

		// Initialize the aim line
		aimLine = new FlxSprite();
		aimLine.makeGraphic(100, 2, FlxColor.RED); // Thin red line
		aimLine.origin.set(0, 1); // Set the origin at the start of the line
    }

    public function updateTurret(elapsed:Float, target:FlxPoint):Void
    {
		if (cannonDisabled)
			return;

		// Recalculate the angle to the target each frame
		turretAngle = Math.atan2(target.y - (y + height / 2), target.x - (x + width / 2));

		// Update the aiming line to point in the correct direction
		updateAimLine();

		// Shoot if enough time has passed
        timeSinceLastShot += elapsed;
		if (timeSinceLastShot >= fireRate)
        {
			shoot();
            timeSinceLastShot = 0;
        }
    }

	private function updateAimLine():Void
    {
		// Set the position and angle of the aim line
		aimLine.x = x + width / 2;
		aimLine.y = y + height / 2;
		aimLine.angle = turretAngle * (180 / Math.PI); // Convert from radians to degrees
    }

	public function shoot():Void
    {
		// Calculate the velocity based on the turret's current angle
		var speed:Float = 400; // Set projectile speed
		var velocity:FlxPoint = new FlxPoint(Math.cos(turretAngle) * speed, Math.sin(turretAngle) * speed);

		// Create and fire the projectile
		var projectile = new Projectile(x + width / 2, y + height / 2, velocity);
		projectiles.add(projectile);
    }

	public function disableCannon(duration:Float):Void
    {
		cannonDisabled = true;
		disableTimer.start(duration, reenableCannon, 1);
	}

	private function reenableCannon(timer:FlxTimer):Void
	{
		cannonDisabled = false;
    }
}
