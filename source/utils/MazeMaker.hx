package utils;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;

class MazeMaker
{
    public var mazeWalls:FlxGroup;

    private var tileSize:Int;
    private var gridWidth:Int;
    private var gridHeight:Int;
    private var topOffset:Int;
    private var bottomOffset:Int;

    public function new(gridWidth:Int, gridHeight:Int, topOffset:Int, bottomOffset:Int, tileSize:Int = 32)
    {
        this.tileSize = tileSize;
        this.gridWidth = gridWidth;
        this.gridHeight = gridHeight;
        this.topOffset = topOffset;
        this.bottomOffset = bottomOffset;

        mazeWalls = new FlxGroup();
		createBarriers();
    }

	private function createBarriers():Void
    {
		// Define the number of barriers and the spacing between them
		var numberOfBarriers:Int = 3; // You can change this to have more or fewer barriers
		var spacing:Int = Std.int(gridHeight / (numberOfBarriers + 1));

		for (i in 1...numberOfBarriers + 1)
        {
			createHorizontalBarrier(spacing * i);
		}
	}

	private function createHorizontalBarrier(row:Int):Void
	{
		// Create a horizontal barrier across the screen
		for (i in 1...(gridWidth - 1)) // Leave a gap at the sides
		{
			createWall(i * tileSize, topOffset + row * tileSize);
        }
    }

    private function createWall(x:Float, y:Float):Void
    {
		var wall = new FlxSprite(x, y).makeGraphic(tileSize * 3, tileSize, FlxColor.GRAY);
        mazeWalls.add(wall);
    }

    public function addToState(state:FlxGroup):Void
    {
        state.add(mazeWalls);
    }
}
