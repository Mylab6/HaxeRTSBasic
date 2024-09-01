package entities;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flxsvg.FlxSvgSprite;
import format.SVG;
import format.SVG;
import openfl.Assets;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.geom.Rectangle;


class SVGBox extends FlxSprite
{
    var svg:FlxSvgSprite;

    public function new(x:Float, y:Float, outerSize:Int, outerColor:Int, svgPath:String)
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
            svg = new FlxSvgSprite(Assets.getText(svgPath));

        }

        // Set the position
        this.x = x;
        this.y = y;

        // Mark the graphic as dirty to ensure it's updated
        this.dirty = true;
    }
}
