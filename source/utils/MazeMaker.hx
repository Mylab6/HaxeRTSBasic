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
	private var topDeadzone:Int;
	private var bottomDeadzone:Int;

	public function new(tileSize:Int = 32, topDeadzone:Int = 100, bottomDeadzone:Int = 200)
    {
        this.tileSize = tileSize;
		this.gridWidth = Math.ceil(FlxG.width / tileSize);
		this.gridHeight = Math.ceil(FlxG.height / tileSize);
		this.topDeadzone = Math.round(topDeadzone / tileSize);
		this.bottomDeadzone = Math.round((FlxG.height - bottomDeadzone) / tileSize);

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
		var numberOfBarriers:Int = 3; // You can change this to have more or fewer barriers
		var spacing:Int = Math.round((bottomDeadzone - topDeadzone) / (numberOfBarriers + 1));

		for (i in 1...numberOfBarriers + 1)
        {
			var barrierLengthRatio = 0.7 + FlxG.random.float(0.15, 0.15); // Random length between 70% to 85%
			createHorizontalBarrier(topDeadzone + spacing * i, barrierLengthRatio);
		}
	}

	private function createHorizontalBarrier(row:Int, lengthRatio:Float):Void
	{
		// Calculate the length of the barrier
		var barrierLength:Int = Math.round(gridWidth * lengthRatio);
		var startX:Int = FlxG.random.int(1, gridWidth - barrierLength - 1); // Ensure it doesn't touch the borders

		// Randomly decide whether to create a gap in the barrier
		var hasGap:Bool = FlxG.random.bool(0.5); // 50% chance to have a gap
		var gapStart:Int = hasGap ? startX + Math.round(barrierLength / 3) : -1;
		var gapEnd:Int = hasGap ? gapStart + Math.round(barrierLength / 3) : -1;

		// Create a horizontal barrier that spans the calculated length, with a possible gap in the middle
		for (i in startX...(startX + barrierLength))
		{
			if (hasGap && i >= gapStart && i <= gapEnd)
				continue; // Skip creating walls within the gap

			createWall(i * tileSize, row * tileSize);
        }
    }

    private function createWall(x:Float, y:Float):Void
    {
		var wall = new FlxSprite(x, y).makeGraphic(tileSize, tileSize, FlxColor.GRAY);
		wall.immovable = true; // Ensure the wall doesn't move
        mazeWalls.add(wall);
    }

    public function addToState(state:FlxGroup):Void
    {
        state.add(mazeWalls);
    }
}
