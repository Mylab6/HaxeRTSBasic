package entities;

import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

class BigBox extends FlxSprite
{
    public var turretAngle:Float;
    public var fireRate:Float;
    private var timeSinceLastShot:Float;
    private var projectiles:FlxGroup;

    public function new(x:Float, y:Float, projectiles:FlxGroup)
    {
        super(x, y);
        makeGraphic(100, 100, FlxColor.BLUE);
        turretAngle = 0;
        fireRate = 2.0; // Turret fires every 2 seconds
        timeSinceLastShot = 0;
        this.projectiles = projectiles; // Store reference to projectiles group
    }

    public function updateTurret(elapsed:Float, target:FlxPoint):Void
    {
        // Calculate the angle to the target
        var targetAngle = Math.atan2(target.y - (y + height / 2), target.x - (x + width / 2));

        // Interpolate the angle towards the target angle
        turretAngle = lerpAngle(turretAngle, targetAngle, 0.05); // 0.05 is the rotation speed

        // Shoot if turret is aligned and enough time has passed
        timeSinceLastShot += elapsed;
        if (Math.abs(angleDifference(turretAngle, targetAngle)) < 0.1 && timeSinceLastShot >= fireRate)
        {
            shoot(target);
            timeSinceLastShot = 0;
        }
    }

    private function lerpAngle(currentAngle:Float, targetAngle:Float, t:Float):Float
    {
        var difference = angleDifference(targetAngle, currentAngle);
        return currentAngle + difference * t;
    }

    private function angleDifference(a1:Float, a2:Float):Float
    {
        var diff = a1 - a2;
        while (diff < -Math.PI) diff += Math.PI * 2;
        while (diff > Math.PI) diff -= Math.PI * 2;
        return diff;
    }

    public function shoot(target:FlxPoint):Void
    {
        var projectile = new Projectile(x + width / 2, y + height / 2, target);
        projectiles.add(projectile); // Add the projectile to the projectiles group
    }
}
