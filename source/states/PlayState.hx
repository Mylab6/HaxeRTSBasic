package states;

import col_callback.ProjectileCallback;
import entities.BaseBox;
import entities.EnemyBox;
import entities.GreenBox;
import entities.Projectile;
import entities.RedBox;
import entities.Spawner;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import haxe.Log;
import managers.EnemyBehaviorManager;
import managers.SpawnManager;
import managers.SpawnerInfo;
import openfl.display.Tilemap;
import openfl.filters.BitmapFilter;
import openfl.filters.ShaderFilter;
import ui.GameUI;
import utils.BasicTileMap;
import utils.MapGenerator;

class PlayState extends FlxState
{
	var redBoxes:FlxGroup;
	var blueBoxes:FlxGroup;
	var greenBoxes:FlxGroup;
	var projectiles:FlxGroup;
	var enemyBox:EnemyBox;
	var redSpawner:Spawner;
	var blueSpawner:Spawner;
	var greenSpawner:Spawner;
	var redBoxEmitters:FlxGroup;
	var blueBoxEmitters:FlxGroup;
	var greenBoxEmitters:FlxGroup;
	var spawnManager:SpawnManager;
	var behaviorManager:EnemyBehaviorManager;
	var gameUI:GameUI;

	override public function create():Void
	{
		super.create();
		redBoxes = new FlxGroup();
		blueBoxes = new FlxGroup();
		greenBoxes = new FlxGroup();
		projectiles = new FlxGroup();
		greenBoxEmitters = new FlxGroup();
		redBoxEmitters = new FlxGroup();
		blueBoxEmitters = new FlxGroup();
		bgColor = FlxColor.fromString("#F0E68C");
		var filters:Array<BitmapFilter> = [];
		#if shaders_supported
		var scanLine = new ShaderFilter(new Scanline());
		filters.push(scanLine);
		FlxG.camera.filters = filters;
		FlxG.game.filters = filters;
		#end
		enemyBox = new EnemyBox(FlxG.width / 2 - 50, 10, projectiles);
		var mapGenerator:MapGenerator;
		var tileSize:Int = 16;
		var mapWidth:Int;
		var mapHeight:Int = FlxG.height;

		// Calculate the number of tiles that fit horizontally based on the screen width
		mapWidth = Math.ceil(FlxG.width / tileSize);

		// Create the map generator
		mapGenerator = new MapGenerator(tileSize, mapWidth, mapHeight);

		// Generate the edge tiles
		var edgeTiles = mapGenerator.generateEdgeMap();

		// Add the group of edge tiles to the state
		add(edgeTiles);
		add(enemyBox);
		add(enemyBox.aimLine);
		var spawnerWidth = 160,
			totalWidth = spawnerWidth * 3,
			spacing = (FlxG.width - totalWidth) / 4,
			yPosition = FlxG.height - spawnerWidth - 10;
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
		// var newMap = new BasicTileMap();
		// add(newMap.map);
		var listOfWallCol:Array<FlxGroup> = [
			redBoxEmitters,
			blueBoxEmitters,
			greenBoxEmitters,
			redBoxes,
			blueBoxes,
			greenBoxes,
			projectiles
		];
		var spawners:Array<SpawnerInfo> = [
			{spawner: redSpawner, enemyGroup: redBoxes, enemyEmitterGroup: redBoxEmitters},
			{spawner: blueSpawner, enemyGroup: blueBoxes, enemyEmitterGroup: blueBoxEmitters},
			{spawner: greenSpawner, enemyGroup: greenBoxes, enemyEmitterGroup: greenBoxEmitters}
		];
		spawnManager = new SpawnManager(spawners, projectiles);
		behaviorManager = new EnemyBehaviorManager(redBoxes, blueBoxes, greenBoxes, enemyBox);
		spawnManager.startSpawning();
		gameUI = new GameUI(120);
		gameUI.addToState(this);
	}

	private function createSpawnerWithOutline(x:Float, y:Float, color:Int):Spawner
	{
		var spawner = new Spawner(x, y, color);
		return spawner;
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		gameUI.updateBossHP(enemyBox.HP);
		var nearestBox:FlxSprite = behaviorManager.findNearestBox(enemyBox);
		if (nearestBox != null)
		{
			enemyBox.updateTurret(elapsed, new FlxPoint(nearestBox.x + nearestBox.width / 2, nearestBox.y + nearestBox.height / 2));
		}
		behaviorManager.updateBehaviors(elapsed);
		FlxG.overlap(redBoxes, projectiles, ProjectileCallback.onProjectileHitBox);
		FlxG.overlap(blueBoxes, projectiles, ProjectileCallback.onProjectileHitBox);
		FlxG.overlap(greenBoxes, projectiles, ProjectileCallback.onProjectileHitBox);
		FlxG.overlap(enemyBox, projectiles, ProjectileCallback.onProjectileHitEnemy);
	}

}
