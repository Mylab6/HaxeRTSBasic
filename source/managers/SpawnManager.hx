package managers;

import entities.BlueBox;
import entities.GreenBox;
import entities.RedBox;
import flixel.group.FlxGroup;
import flixel.util.FlxTimer;

class SpawnManager
{
    private var spawners:Array<SpawnerInfo>;
    private var redBoxTimer:FlxTimer;
    private var blueBoxTimer:FlxTimer;
    private var greenBoxTimer:FlxTimer;
	private var projectiles:FlxGroup;
	private var redBoxSpawnRate:Float;
	private var blueBoxSpawnRate:Float;
	private var greenBoxSpawnRate:Float;

	public function new(spawners:Array<SpawnerInfo>, projectiles:FlxGroup)
    {
        this.spawners = spawners;
		this.projectiles = projectiles; 
        redBoxTimer = new FlxTimer();
        blueBoxTimer = new FlxTimer();
        greenBoxTimer = new FlxTimer();
		redBoxSpawnRate = 2; // Default spawn rate for red box
		blueBoxSpawnRate = 6; // Default spawn rate for blue box
		greenBoxSpawnRate = 4; // Default spawn rate for green box
    }

    public function startSpawning():Void
    {
		redBoxTimer.start(redBoxSpawnRate, spawnRedBox, 0); // Spawn a red box every redBoxSpawnRate seconds
		blueBoxTimer.start(blueBoxSpawnRate, spawnBlueBox, 0); // Spawn a blue box every blueBoxSpawnRate seconds
		greenBoxTimer.start(greenBoxSpawnRate, spawnGreenBox, 0); // Spawn a green box every greenBoxSpawnRate seconds
		// blueBoxTimer.reset(1); // Reset the blue box timer to start spawning immediately
    }

    private function spawnRedBox(timer:FlxTimer):Void
    {
        var info = spawners[0]; // Assuming first spawner is for RedBox
        var x = info.spawner.x + info.spawner.width / 2 - 25;
        var y = info.spawner.y + info.spawner.height / 2 - 25;
        var redBox = new RedBox(x, y);
        info.enemyGroup.add(redBox);
		info.enemyEmitterGroup.add(redBox.emitter); 
    }

    private function spawnBlueBox(timer:FlxTimer):Void
    {
        var info = spawners[1]; // Assuming second spawner is for BlueBox
        var x = info.spawner.x + info.spawner.width / 2 - 25;
        var y = info.spawner.y + info.spawner.height / 2 - 25;
        var blueBox = new BlueBox(x, y);
        info.enemyGroup.add(blueBox);
		info.enemyEmitterGroup.add(blueBox.emitter);
    }

    private function spawnGreenBox(timer:FlxTimer):Void
    {
        var info = spawners[2]; // Assuming third spawner is for GreenBox
        var x = info.spawner.x + info.spawner.width / 2 - 25;
        var y = info.spawner.y + info.spawner.height / 2 - 25;
		var greenBox = new GreenBox(x, y, projectiles);
        info.enemyGroup.add(greenBox);
		info.enemyEmitterGroup.add(greenBox.emitter);
	}

	public function updateSpawnRates(redBoxRate:Float, blueBoxRate:Float, greenBoxRate:Float):Void
	{
		redBoxSpawnRate = redBoxRate;
		blueBoxSpawnRate = blueBoxRate;
		greenBoxSpawnRate = greenBoxRate;
		redBoxTimer.reset(redBoxSpawnRate);
		blueBoxTimer.reset(blueBoxSpawnRate);
		greenBoxTimer.reset(greenBoxSpawnRate);
    }
}
