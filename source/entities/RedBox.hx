package entities;

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

class RedBox extends BaseBox
{
    public function new(x:Float, y:Float)
	{
		super(x, y, FlxColor.RED);
	}

	public function updateBehavior(bigBox:EnemyBox):Void
	{
		var boxPoint:FlxPoint = new FlxPoint(x, y);
		var bigBoxPoint:FlxPoint = new FlxPoint(bigBox.x, bigBox.y);
		var distance:Float = boxPoint.distanceTo(bigBoxPoint);
		MoveTowards(bigBox, distance);
	}
}
