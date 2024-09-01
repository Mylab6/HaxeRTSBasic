package entities;

import flixel.addons.display.shapes.FlxShapeSquareDonut;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil.LineStyle;

class OutlinedBox extends FlxShapeSquareDonut
{
    public function new(x:Float, y:Float, outerColor:Int)
    {
		// Define the sizes for the outer and inner boxes
		var outerSize:Int = 100;
		var innerSize:Int = 60; // This will create the central white box

		// Define the line style for the outer border (white color with thickness)
		var lineStyle:LineStyle = {
			thickness: 5, // 5px thick outline
			color: FlxColor.WHITE, // White color
			// Line joint style
			miterLimit: 3, // Miter limit
			pixelHinting: true // Pixel hinting
		};
		// Call the super constructor with the desired parameters
		super(outerSize, innerSize, 20, 20, lineStyle, outerColor);

		// Set the position
		this.x = x;
		this.y = y;
    }
}
