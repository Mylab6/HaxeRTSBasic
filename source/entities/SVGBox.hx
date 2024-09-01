package entities;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flxsvg.FlxSvgSprite;
import openfl.Assets;
import openfl.geom.Rectangle;

class SVGBox extends FlxSprite
{
    var svg:FlxSvgSprite;

	public function new(x:Float, y:Float, outerSize:Int, outerColor:Int, svgPath:String = null)
    {
        super(x, y);

        // Set the thickness of the border
        var borderThickness:Int = 5;
        var innerSize:Int = outerSize - borderThickness * 2;

        // Create a unique graphic for this sprite
        makeGraphic(outerSize, outerSize, FlxColor.TRANSPARENT, true);

        // Draw the white border
        pixels.fillRect(new Rectangle(0, 0, outerSize, outerSize), FlxColor.WHITE);

        // Draw the inner colored box
        pixels.fillRect(new Rectangle(borderThickness, borderThickness, innerSize, innerSize), outerColor);

        // Load and render the SVG
        if (svgPath != null)
        {
			try {}
            
            svg = new FlxSvgSprite(Assets.getText(svgPath));

			// Position the SVG in the center of the inner box
			svg.x = x + borderThickness;
			svg.y = y + borderThickness;

			// Scale the SVG to fit within the inner box
			svg.scale.set(innerSize / svg.width / 2, innerSize / svg.height / 2);
        }

        // Set the position
        this.x = x;
        this.y = y;
	}

	override public function draw():Void
	{
		// First, draw the box (border and background)
		super.draw();

		// Now, draw the SVG inside the box
		if (svg != null)
		{
			// Render the SVG manually at its scaled position
			svg.draw();
		}
    }
}
