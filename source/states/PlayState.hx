package states;

import entities.BaseBox;
import entities.BlueBox;
import entities.EnemyBox;
import entities.GreenBox;
import entities.Projectile;
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
import ui.GameUI;
import utils.MazeMaker;
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
	private var enemyBox:EnemyBox;
	private var redSpawner:Spawner;
	private var blueSpawner:Spawner;
	private var greenSpawner:Spawner;
	private var redBoxEmitters:FlxGroup;
	private var blueBoxEmitters:FlxGroup;
	private var greenBoxEmitters:FlxGroup;
	private var spawnManager:SpawnManager;
	private var behaviorManager:EnemyBehaviorManager;
	private var gameUI:GameUI;

	private var mazeMaker:MazeMaker;

    override public function create():Void
    {
		super.create();

		// Initialize groups for enemies and projectiles
        redBoxes = new FlxGroup();
        blueBoxes = new FlxGroup();
        greenBoxes = new FlxGroup();
		projectiles = new FlxGroup();
		greenBoxEmitters = new FlxGroup();
		redBoxEmitters = new FlxGroup();
		blueBoxEmitters = new FlxGroup(); 
		bgColor = FlxColor.fromString("#F0E68C"); 
		// Apply the scanline filter if supported
		var filters:Array<BitmapFilter> = [];
		#if shaders_supported
		var scanLine = new ShaderFilter(new Scanline());
		filters.push(scanLine);
		FlxG.camera.filters = filters;
		FlxG.game.filters = filters;
		#end

		// Add groups to the state


		// Initialize and add the BigBox

		enemyBox = new EnemyBox(FlxG.width / 2 - 50, 10, projectiles); // Positioned at the top
		add(enemyBox);
		add(enemyBox.aimLine);

		var gridWidth:Int = Std.int(FlxG.width / 32);
		var gridHeight:Int = Std.int((FlxG.height - 300) / 32); // 300 accounts for top and bottom space
		//	gridWidth = Std.int(gridWidth);
		//		gridHeight = Std.int(gridHeight);
		var topOffset:Int = 100; // Space reserved for the turret
		var bottomOffset:Int = 200; // Space reserved for the spawners

		// Create and add the maze
		mazeMaker = new MazeMaker(gridWidth, gridHeight, topOffset, bottomOffset);
		mazeMaker.addToState(this);

		// Position the spawners at the bottom
		var spawnerWidth = 160; // Width of each spawner
		var totalWidth = spawnerWidth * 3;
		var spacing = (FlxG.width - totalWidth) / 4; // Calculate the spacing between the spawners
		var yPosition = FlxG.height - spawnerWidth - 10; // Positioning 10 pixels above the bottom

		redSpawner = createSpawnerWithOutline(spacing, yPosition, FlxColor.RED);
		greenSpawner = createSpawnerWithOutline(spacing * 2 + spawnerWidth, yPosition, FlxColor.GREEN);
		blueSpawner = createSpawnerWithOutline(spacing * 3 + spawnerWidth * 2, yPosition, FlxColor.BLUE);

		add(redSpawner);
		add(blueSpawner);
		add(greenSpawner);
		add(redBoxEmitters);
		add(blueBoxEmitters);
		add(greenBoxEmitters);
		add(redBoxes);
		add(blueBoxes);
		add(greenBoxes);
		add(projectiles);

		// Create SpawnerInfo array
		var spawners:Array<SpawnerInfo> = [
			{spawner: redSpawner, enemyGroup: redBoxes, enemyEmitterGroup: redBoxEmitters},
			{spawner: blueSpawner, enemyGroup: blueBoxes, enemyEmitterGroup: blueBoxEmitters},
			{spawner: greenSpawner, enemyGroup: greenBoxes, enemyEmitterGroup: greenBoxEmitters}
		];

		// Initialize managers with the spawners
		spawnManager = new SpawnManager(spawners, projectiles);
		behaviorManager = new EnemyBehaviorManager(redBoxes, blueBoxes, greenBoxes, enemyBox);

		// Start spawning enemies
		spawnManager.startSpawning();
		gameUI = new GameUI(120);
		gameUI.addToState(this);
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
		// Example of updating the boss HP, e.g., after taking damage
		// Call this method wherever necessary, e.g., after the boss takes damage
		gameUI.updateBossHP(enemyBox.HP);
		// Update nearest target and aim
		var nearestBox:FlxSprite = behaviorManager.findNearestBox(enemyBox);
		if (nearestBox != null)
		{
			enemyBox.updateTurret(elapsed, new FlxPoint(nearestBox.x + nearestBox.width / 2, nearestBox.y + nearestBox.height / 2));
		}

		// Update enemy behaviors
		behaviorManager.updateBehaviors(elapsed);
		FlxG.overlap(redBoxes, projectiles, onProjectileHitBox);
		FlxG.overlap(blueBoxes, projectiles, onProjectileHitBox);
		FlxG.overlap(greenBoxes, projectiles, onProjectileHitBox);
		FlxG.overlap(enemyBox, projectiles, onProjectileHitEnemy); 
	}

	private function onProjectileHitEnemy(box:FlxSprite, projectile:FlxSprite):Void
	{
		var projectileF = cast(projectile, Projectile); // Cast to BaseBox to access the hit method
		if (projectileF.EnemyProjectile)
		{
			return;
		}
		enemyBox.TakeDamage(projectileF.Damage);
		projectile.kill(); // Destroy the projectile on impact
	}
	private function onProjectileHitBox(box:FlxSprite, projectile:FlxSprite):Void
	{
		// Cast to BaseBox to access the hit method
		var projectileF = cast(projectile, Projectile); // Cast to BaseBox to access the hit method
		if (!projectileF.EnemyProjectile)
		{
			return;
		}
		var pos = projectileF.getPosition();
		var baseBox = cast(box, BaseBox);
		baseBox.hit(projectileF.Damage, pos.x, pos.y); // Trigger the hit effect and kill the box

		projectile.kill(); // Destroy the projectile on impact
	}
}
