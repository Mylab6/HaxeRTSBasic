// src/utils/MazeGenerator.hx
package utils;

import flixel.math.FlxPoint;
import flixel.math.FlxRandom;

class MazeGenerator {
    public var width:Int;
    public var height:Int;
    public var grid:Array<Array<Int>>;
    
    public static var WALL:Int = 1;
    public static var PATH:Int = 0;
    
    private var mazeHeight:Int;
    private var mazeStartY:Int;
    
    public function new(width:Int, height:Int, topSpace:Int, bottomSpace:Int) {
        this.width = width;
        this.height = height;
        this.mazeHeight = height - topSpace - bottomSpace; // Space for maze
        this.mazeStartY = topSpace;
        
        grid = [];
        
        // Initialize the grid with walls
        for (y in 0...height) {
            var row:Array<Int> = [];
            for (x in 0...width) {
                row.push(WALL);
            }
            grid.push(row);
        }
        
        // Create empty spaces for the turret (top) and speakers (bottom)
        for (x in 1...(width - 1)) {
            for (y in 0...topSpace) {
                grid[y][x] = PATH;
            }
            for (y in (height - bottomSpace)...height) {
                grid[y][x] = PATH;
            }
        }
    }
    
    public function generate():Void {
        // Start the maze generation from (1, mazeStartY + 1)
        carvePath(1, mazeStartY + 1);
    }
    
    private function carvePath(x:Int, y:Int):Void {
        grid[y][x] = PATH;
        
        // Randomized directions
        var directions = [FlxPoint.get(0, -2), FlxPoint.get(2, 0), FlxPoint.get(0, 2), FlxPoint.get(-2, 0)];
       new  FlxRandom().shuffle(directions);
        
        for (dir in directions) {
            var nx:Int = x + Std.int(dir.x);
            var ny:Int = y + Std.int(dir.y);
            
            if (isInBounds(nx, ny) && grid[ny][nx] == WALL) {
                grid[y + Std.int(dir.y / 2)][x + Std.int(dir.x / 2)] = PATH; // Remove wall between cells
                carvePath(nx, ny);
            }
        }
    }
    
    private function isInBounds(x:Int, y:Int):Bool {
        return x > 0 && y > mazeStartY && x < width - 1 && y < (mazeStartY + mazeHeight - 1);
    }
}
