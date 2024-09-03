package utils;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tile.FlxBaseTilemap.FlxTilemapAutoTiling;
import flixel.tile.FlxTileblock;
import flixel.tile.FlxTilemap;

class MapGenerator
{
	public var tileSize:Int;
	public var mapWidth:Int;
	public var mapHeight:Int;

	public function new(tileSize:Int, mapWidth:Int, mapHeight:Int)
	{
		this.tileSize = tileSize;
		this.mapWidth = mapWidth;
		this.mapHeight = mapHeight;
	}

	public function generateEdgeMap():FlxTileblock
	{
		var mapArray:Array<Int> = [];

		for (y in 0...mapHeight)
		{
			for (x in 0...mapWidth)
			{
				if (y < 3 || y >= mapHeight - 3 || x < 3 || x >= mapWidth - 3)
				{
					mapArray.push(1); // Tile index for the edge
				}
				else if (y == Math.floor(mapHeight / 2) && x % 5 == 0)
				{
					mapArray.push(1); // Tile index for barriers
				}
				else
				{
					mapArray.push(0); // Tile index for empty space
				}
			}
		}

		var block = new FlxTileblock(16, 16, FlxG.width - 32, FlxG.height - 32);
		block.loadTiles("assets/images/tiles.png", 16, 16);
		return block;
	}
}
