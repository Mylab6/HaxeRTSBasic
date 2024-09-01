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
        createMazeWalls();
    }

    private function createMazeWalls():Void
    {
        // Create the outer walls, leaving the top and bottom ends open
        for (i in 0...gridWidth)
        {
            // Skip creating walls at the start (top) and end (bottom)
            if (i == gridWidth / 2) continue;

            createWall(i * tileSize, topOffset); // Top wall
            createWall(i * tileSize, topOffset + gridHeight * tileSize); // Bottom wall
        }
        for (j in 0...gridHeight)
        {
            createWall(0, topOffset + j * tileSize); // Left wall
            createWall((gridWidth - 1) * tileSize, topOffset + j * tileSize); // Right wall
        }

        // Generate the inner maze structure
        for (i in 1...(gridWidth - 1))
        {
            for (j in 1...(gridHeight - 1))
            {
                if (FlxG.random.float(0, 1) < 0.3) // Randomly place walls
                {
                    createWall(i * tileSize, topOffset + j * tileSize);
                }
            }
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
