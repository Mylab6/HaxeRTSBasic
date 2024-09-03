package utils;

import flixel.FlxG;
import flixel.FlxState;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;

class BasicTileMap
{
	public var map:FlxTilemap;

	public function new()
	{
		// Define the tile size
		var tileSize:Int = 1;

		// Calculate the number of tiles that fit horizontally based on the screen width
		var mapWidth:Int = Math.ceil(FlxG.width / tileSize);
		var mapHeight:Int = Math.ceil(FlxG.height / tileSize);
		// ; // You can adjust this as needed

		// Create an empty tilemap
		map = new FlxTilemap();
		map.loadMapFromArray(generateEdgeMap(mapWidth, mapHeight), mapWidth, mapHeight, "assets/images/tiles.png", tileSize, tileSize, AUTO);
		// return map;
		// add(map);
	}

	// Function to generate a map with tiles around the edge
	function generateEdgeMap(width:Int, height:Int):Array<Int>
	{
		var mapArray:Array<Int> = [];

		for (y in 0...height)
		{
			for (x in 0...width)
			{
				if (x == 0 || x == width - 1 || y == 0 || y == height - 1)
				{
					mapArray.push(1); // Tile index for the edge
				}
				else
				{
					mapArray.push(0); // Tile index for empty space
				}
			}
		}

		return mapArray;
	}
}