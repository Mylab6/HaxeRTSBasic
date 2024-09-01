package entities;

import flixel.addons.display.shapes.FlxShapeDoubleCircle;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil.LineStyle;

class OutlineCircle extends FlxShapeDoubleCircle
{
	public function new(x:Float, y:Float, outerSize:Int, outerColor:Int)
    {
		// Define the sizes for the outer and inner boxes
		var innerSize:Int = 20; // This will create the central white box

		// Define the line style for the outer border (white color with thickness)
		var lineStyle:LineStyle = {
			thickness: 5, // 5px thick outline
			color: FlxColor.WHITE, // White color
			// Line joint style
			miterLimit: 3, // Miter limit
			pixelHinting: true // Pixel hinting
		};
		// Call the super constructor with the desired parameters
		super(outerSize, innerSize, outerSize, outerSize, lineStyle, outerColor);

		// Set the position
		this.x = x;
		this.y = y;
    }
}
