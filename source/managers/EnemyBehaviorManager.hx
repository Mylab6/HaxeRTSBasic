package managers;

import entities.BlueBox;
import entities.EnemyBox;
import entities.GreenBox;
import entities.RedBox;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;

class EnemyBehaviorManager
{
    private var redBoxes:FlxGroup;
    private var blueBoxes:FlxGroup;
    private var greenBoxes:FlxGroup;
	private var enemyBox:EnemyBox;

	public function new(redBoxes:FlxGroup, blueBoxes:FlxGroup, greenBoxes:FlxGroup, enemyBox:EnemyBox)
    {
        this.redBoxes = redBoxes;
        this.blueBoxes = blueBoxes;
        this.greenBoxes = greenBoxes;
		this.enemyBox = enemyBox;
    }

	public function findNearestBox(enemyBox:EnemyBox):FlxSprite
    {
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
				var bigBoxPoint = new FlxPoint(enemyBox.x + enemyBox.width / 2, enemyBox.y + enemyBox.height / 2);
                var distance = bigBoxPoint.distanceTo(boxPoint);

                if (distance < minDistance)
                {
                    minDistance = distance;
                    nearestBox = box;
                }
            }
        }

        return nearestBox;
    }

    public function updateBehaviors(elapsed:Float):Void
    {
        for (redBox in redBoxes.members)
        {
            var box = cast(redBox, RedBox);
			box.updateBehavior(enemyBox);
        }
        for (blueBox in blueBoxes.members)
        {
            var box = cast(blueBox, BlueBox);
			box.updateBehavior(enemyBox);
        }
        for (greenBox in greenBoxes.members)
        {
            var box = cast(greenBox, GreenBox);
			box.updateBehavior(enemyBox);
        }
    }
}
