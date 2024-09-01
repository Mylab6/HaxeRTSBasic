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
	private var numberOfBarriers:Int;

	public function new(tileSize:Int = 24, numberOfBarriers:Int = 8)
    {
        this.tileSize = tileSize;
		this.gridWidth = Math.ceil(FlxG.width / tileSize);
		this.gridHeight = Math.ceil(FlxG.height / tileSize);
		this.numberOfBarriers = numberOfBarriers;
		mazeWalls = new FlxGroup();
		createBorderWalls();
		createHorizontalBarriers();
	}

	private function createBorderWalls():Void
	{
		// Top and Bottom Borders
		for (i in 0...gridWidth)
		{
			createWall(i * tileSize, 0); // Top border
			createWall(i * tileSize, (gridHeight - 1) * tileSize); // Bottom border
		}

		// Left and Right Borders
		for (j in 0...gridHeight)
		{
			createWall(0, j * tileSize); // Left border
			createWall((gridWidth - 1) * tileSize, j * tileSize); // Right border
		}
	}

	private function createHorizontalBarriers():Void
    {
		// Define the number of barriers and the spacing between them
		var spacing:Int = Math.ceil(gridHeight / (numberOfBarriers + 1));

		for (i in 1...numberOfBarriers + 1)
        {
			var barrierLengthRatio = 0.7 + FlxG.random.float(0.15, 0.15); // Random length between 70% to 85%
			createHorizontalBarrier(spacing * i, barrierLengthRatio);
		}
	}

	private function createHorizontalBarrier(row:Int, lengthRatio:Float):Void
	{
		// Calculate the length of the barrier
		var barrierLength:Int = Math.round(gridWidth * lengthRatio);
		var startX:Int = FlxG.random.int(1, gridWidth - barrierLength - 1); // Ensure it doesn't touch the borders

		// Create a horizontal barrier that spans the calculated length
		for (i in startX...(startX + barrierLength))
		{
			createWall(i * tileSize, row * tileSize);
        }
    }

    private function createWall(x:Float, y:Float):Void
    {
		var wall = new FlxSprite(x, y).makeGraphic(tileSize, tileSize, FlxColor.GRAY);
        mazeWalls.add(wall);
    }

    public function addToState(state:FlxGroup):Void
    {
        state.add(mazeWalls);
    }
}
