package utils;

import flixel.FlxSprite;
import flixel.group.FlxGroup;

class MapGenerator
{
	public var tileSize:Int;
	public var mapWidth:Int;
	public var mapHeight:Int;
	public var edgeTiles:FlxGroup;

	public function new(tileSize:Int, mapWidth:Int, mapHeight:Int)
	{
		this.tileSize = tileSize;
		this.mapWidth = mapWidth;
		this.mapHeight = mapHeight;
		this.edgeTiles = new FlxGroup();
	}

	public function generateEdgeMap():FlxGroup
	{
		// Top and bottom edges
		for (x in 0...mapWidth)
		{
			// Top edge
			var topTile = createTile(x * tileSize, 0);
			edgeTiles.add(topTile);

			// Bottom edge
			var bottomTile = createTile(x * tileSize, (mapHeight - 1) * tileSize);
			edgeTiles.add(bottomTile);
		}

		// Left and right edges
		for (y in 1...mapHeight - 1)
		{
			// Left edge
			var leftTile = createTile(0, y * tileSize);
			edgeTiles.add(leftTile);

			// Right edge
			var rightTile = createTile((mapWidth - 1) * tileSize, y * tileSize);
			edgeTiles.add(rightTile);
		}

		return edgeTiles;
	}

	// Function to create a tile sprite
	function createTile(x:Float, y:Float):FlxSprite
	{
		var tile = new FlxSprite(x, y);
		tile.makeGraphic(tileSize, tileSize, 0xFF000000); // Black color for the edge tiles
		return tile;
	}
}