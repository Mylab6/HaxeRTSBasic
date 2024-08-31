package states;

import entities.BigBox;
import entities.BlueBox;
import entities.GreenBox;
import entities.Projectile;
import entities.RedBox;
import filters.Scanline;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.util.FlxTimer;
import openfl.filters.BitmapFilter;
import openfl.filters.ShaderFilter;
#if shaders_supported
import filters.*;
import openfl.Lib;
import openfl.display.Shader;
import openfl.utils.Assets;
#end

class PlayState extends FlxState
{
    private var redBoxes:FlxGroup;
    private var blueBoxes:FlxGroup;
    private var greenBoxes:FlxGroup;
    private var projectiles:FlxGroup;
    private var bigBox:BigBox;

	private var redBoxTimer:FlxTimer;
	private var blueBoxTimer:FlxTimer;
	private var greenBoxTimer:FlxTimer;

    override public function create():Void
    {
		super.create();

		// Initialize groups for enemies and projectiles
        redBoxes = new FlxGroup();
        blueBoxes = new FlxGroup();
        greenBoxes = new FlxGroup();
        projectiles = new FlxGroup(); // Create the projectiles group
		// Apply the scanline filter if supported
		var filters:Array<BitmapFilter> = [];
		#if shaders_supported
		var scanLine = new ShaderFilter(new Scanline());
		filters.push(scanLine);
		FlxG.camera.filters = filters;
		FlxG.game.filters = filters;
		#end

		// Add groups to the state
        add(redBoxes);
        add(blueBoxes);
        add(greenBoxes);
		add(projectiles);

		// Initialize and add the BigBox
		bigBox = new BigBox(FlxG.width / 2 - 50, FlxG.height / 2 - 50, projectiles);
		add(bigBox);
		add(bigBox.aimLine);
		// Start spawning enemies
		redBoxTimer = new FlxTimer();
		redBoxTimer.start(2, spawnRedBox, 0); // Spawn a red box every 2 seconds

		blueBoxTimer = new FlxTimer();
		blueBoxTimer.start(3, spawnBlueBox, 0); // Spawn a blue box every 3 seconds

		greenBoxTimer = new FlxTimer();
		greenBoxTimer.start(4, spawnGreenBox, 0); // Spawn a green box every 4 seconds
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        // Find the nearest box to the BigBox
        var nearestBox:FlxSprite = null;
		var minDistance:Float = Math.POSITIVE_INFINITY;

        var allBoxes:Array<FlxSprite> = [];
        allBoxes = allBoxes.concat(cast redBoxes.members);
        allBoxes = allBoxes.concat(cast blueBoxes.members);
        allBoxes = allBoxes.concat(cast greenBoxes.members);

        for (box in allBoxes)
		{
			if (box != null && box.exists && box.alive)
            {
                var boxPoint = new FlxPoint(box.x + box.width / 2, box.y + box.height / 2);
                var bigBoxPoint = new FlxPoint(bigBox.x + bigBox.width / 2, bigBox.y + bigBox.height / 2);
				var distance = bigBoxPoint.distanceTo(boxPoint);

                if (distance < minDistance)
                {
                    minDistance = distance;
					nearestBox = box;
                }
            }
		}

        // If a box is found, update the turret to aim and shoot
        if (nearestBox != null)
        {
			bigBox.updateTurret(elapsed, new FlxPoint(nearestBox.x + nearestBox.width / 2, nearestBox.y + nearestBox.height / 2));
		}

        // Update behaviors for all boxes
        for (redBox in redBoxes.members)
        {
            var box = cast(redBox, RedBox);
            box.updateBehavior(bigBox);
        }
        for (blueBox in blueBoxes.members)
        {
            var box = cast(blueBox, BlueBox);
            box.updateBehavior(bigBox);
        }
        for (greenBox in greenBoxes.members)
        {
            var box = cast(greenBox, GreenBox);
            box.updateBehavior(bigBox);
        }
    }

	private function spawnRedBox(timer:FlxTimer):Void
	{
		var x = FlxG.random.float(0, FlxG.width - 50);
		var y = FlxG.random.float(0, FlxG.height - 50);
		var redBox = new RedBox(x, y);
		redBoxes.add(redBox);
	}

	private function spawnBlueBox(timer:FlxTimer):Void
	{
		var x = FlxG.random.float(0, FlxG.width - 50);
		var y = FlxG.random.float(0, FlxG.height - 50);
		var blueBox = new BlueBox(x, y);
		blueBoxes.add(blueBox);
	}

	private function spawnGreenBox(timer:FlxTimer):Void
	{
		var x = FlxG.random.float(0, FlxG.width - 50);
		var y = FlxG.random.float(0, FlxG.height - 50);
		var greenBox = new GreenBox(x, y);
		greenBoxes.add(greenBox);
	}
}
