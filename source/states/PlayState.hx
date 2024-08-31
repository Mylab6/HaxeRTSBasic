package states;

import entities.BigBox;
import entities.BlueBox;
import entities.GreenBox;
import entities.RedBox;
import entities.Spawner;
import filters.Scanline;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import managers.EnemyBehaviorManager;
import managers.SpawnManager;
import managers.SpawnerInfo; // Import SpawnerInfo type
import openfl.filters.BitmapFilter;
import openfl.filters.ShaderFilter;
#if shaders_supported
import filters.*;
import openfl.Lib;
import openfl.display.Shader;
import openfl.utils.Assets;
#end


class PlayState extends FlxState
{
    private var redBoxes:FlxGroup;
    private var blueBoxes:FlxGroup;
    private var greenBoxes:FlxGroup;
    private var projectiles:FlxGroup;
    private var bigBox:BigBox;
	private var redSpawner:Spawner;
	private var blueSpawner:Spawner;
	private var greenSpawner:Spawner;

	private var spawnManager:SpawnManager;
	private var behaviorManager:EnemyBehaviorManager;

    override public function create():Void
    {
		super.create();

		// Initialize groups for enemies and projectiles
        redBoxes = new FlxGroup();
        blueBoxes = new FlxGroup();
        greenBoxes = new FlxGroup();
		projectiles = new FlxGroup();

		// Apply the scanline filter if supported
		var filters:Array<BitmapFilter> = [];
		#if shaders_supported
		var scanLine = new ShaderFilter(new Scanline());
		filters.push(scanLine);
		FlxG.camera.filters = filters;
		FlxG.game.filters = filters;
		#end

		// Add groups to the state
        add(redBoxes);
        add(blueBoxes);
        add(greenBoxes);
		add(projectiles);

		// Initialize and add the BigBox
		bigBox = new BigBox(FlxG.width / 2 - 50, FlxG.height / 2 - 50, projectiles);
		add(bigBox);
		add(bigBox.aimLine);

		// Create and add the spawners with outlines using the Spawner class
		redSpawner = createSpawnerWithOutline(FlxG.width * 0.2, FlxG.height * 0.5, FlxColor.RED);
		blueSpawner = createSpawnerWithOutline(FlxG.width * 0.5, FlxG.height * 0.2, FlxColor.BLUE);
		greenSpawner = createSpawnerWithOutline(FlxG.width * 0.8, FlxG.height * 0.5, FlxColor.ORANGE);

		add(redSpawner);
		add(blueSpawner);
		add(greenSpawner);

		// Create SpawnerInfo array
		var spawners:Array<SpawnerInfo> = [
			{spawner: redSpawner, enemyGroup: redBoxes},
			{spawner: blueSpawner, enemyGroup: blueBoxes},
			{spawner: greenSpawner, enemyGroup: greenBoxes}
		];

		// Initialize managers with the spawners
		spawnManager = new SpawnManager(spawners);
		behaviorManager = new EnemyBehaviorManager(redBoxes, blueBoxes, greenBoxes, bigBox);

		// Start spawning enemies
		spawnManager.startSpawning();
	}

	private function createSpawnerWithOutline(x:Float, y:Float, color:Int):Spawner
	{
		// Create the spawner with an outline
		var spawner = new Spawner(x, y, color);

		// Add it to the state
		return spawner;
    }

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		// Update nearest target and aim
		var nearestBox:FlxSprite = behaviorManager.findNearestBox(bigBox);
		if (nearestBox != null)
		{
			bigBox.updateTurret(elapsed, new FlxPoint(nearestBox.x + nearestBox.width / 2, nearestBox.y + nearestBox.height / 2));
		}

		// Update enemy behaviors
		behaviorManager.updateBehaviors(elapsed);
	}
}
