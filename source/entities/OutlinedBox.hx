package entities;

import flixel.FlxSprite;
import openfl.display.Graphics;
import openfl.display.Shape;

class OutlinedBox extends FlxSprite
{
    public function new(x:Float, y:Float, outerColor:Int)
    {
        super(x, y);
        
        // Set the size of the main box
        var boxSize:Int = 100;
        var outlineThickness:Int = 5;
        var centerBoxSize:Int = 40;

        // Create a Shape to draw the box using Graphics API
        var shape:Shape = new Shape();
        var g:Graphics = shape.graphics;

        // Draw the white outline
        g.beginFill(0xFFFFFF);
        g.drawRect(0, 0, boxSize + outlineThickness * 2, boxSize + outlineThickness * 2);
        g.endFill();

        // Draw the inner colored box
        g.beginFill(outerColor);
        g.drawRect(outlineThickness, outlineThickness, boxSize, boxSize);
        g.endFill();

        // Draw the center white box
        g.beginFill(0xFFFFFF);
        g.drawRect(
            (boxSize + outlineThickness * 2 - centerBoxSize) / 2,
            (boxSize + outlineThickness * 2 - centerBoxSize) / 2,
            centerBoxSize,
            centerBoxSize
        );
        g.endFill();

        // Convert the Shape to BitmapData and apply it to the FlxSprite
        pixels.draw(shape);
        this.dirty = true;
    }
}
