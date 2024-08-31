package entities;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import openfl.geom.Point;
import openfl.geom.Rectangle;

class Spawner extends FlxSprite
{
    public function new(x:Float, y:Float, color:Int)
    {
        super(x, y);

        // Draw the white outline first (160x160)
        makeGraphic(160, 160, FlxColor.WHITE);

        // Draw the inner colored box on top (150x150)
        createInnerBox(color);
    }

    private function createInnerBox(color:Int):Void
    {
        // Create a separate FlxSprite for the inner box
        var innerBox = new FlxSprite(0, 0);
        innerBox.makeGraphic(150, 150, color);
        
        // Copy the inner box onto the current spawner graphic
        this.pixels.copyPixels(innerBox.pixels, new Rectangle(0, 0, 150, 150), new Point(5, 5));
        
        // Mark the graphic as dirty to update it
        this.dirty = true;
    }
}
