package states;

import entities.BigBox;
import entities.BlueBox;
import entities.GreenBox;
import entities.Projectile;
import entities.RedBox;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;

class PlayState extends FlxState
{
    private var redBoxes:FlxGroup;
    private var blueBoxes:FlxGroup;
    private var greenBoxes:FlxGroup;
    private var projectiles:FlxGroup;
    private var bigBox:BigBox;

    override public function create():Void
    {
        super.create();

        redBoxes = new FlxGroup();
        blueBoxes = new FlxGroup();
        greenBoxes = new FlxGroup();
        projectiles = new FlxGroup(); // Create the projectiles group

        add(redBoxes);
        add(blueBoxes);
        add(greenBoxes);
        add(projectiles); // Add the projectiles group to the state

        bigBox = new BigBox(FlxG.width / 2 - 50, FlxG.height / 2 - 50, projectiles);
        add(bigBox);

        spawnRedBox(50, 100);
        spawnBlueBox(200, 100);
        spawnGreenBox(350, 100);
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
                var boxPoint = new FlxPoint(box.x + box.width / 2, box.y + box.height / 2);
                var bigBoxPoint = new FlxPoint(bigBox.x + bigBox.width / 2, bigBox.y + bigBox.height / 2);
                var distance = bigBoxPoint.distanceTo(boxPoint); // Use distanceTo instead of distance
    
                if (distance < minDistance)
                {
                    minDistance = distance;
                    nearestBox = box;
                }
            }
        

        // If a box is found, update the turret to aim and shoot
        if (nearestBox != null)
        {
            bigBox.updateTurret(elapsed, new FlxPoint(nearestBox.x + nearestBox.width / 2, nearestBox.y + nearestBox.height / 2));
        }

        // Update projectiles
        projectiles.update(elapsed);

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

    private function spawnRedBox(x:Float, y:Float):Void
    {
        var redBox = new RedBox(x, y);
        redBoxes.add(redBox);
    }

    private function spawnBlueBox(x:Float, y:Float):Void
    {
        var blueBox = new BlueBox(x, y);
        blueBoxes.add(blueBox);
    }

    private function spawnGreenBox(x:Float, y:Float):Void
    {
        var greenBox = new GreenBox(x, y);
        greenBoxes.add(greenBox);
    }
}
