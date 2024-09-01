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

	public function new(spawners:Array<SpawnerInfo>, projectiles:FlxGroup)

    {
        this.spawners = spawners;
		this.projectiles = projectiles; 
        redBoxTimer = new FlxTimer();
        blueBoxTimer = new FlxTimer();
        greenBoxTimer = new FlxTimer();
    }

    public function startSpawning():Void
    {
        redBoxTimer.start(2, spawnRedBox, 0); // Spawn a red box every 2 seconds
		blueBoxTimer.start(3, spawnBlueBox, 0); // Spawn a blue box every 3 seconds
        greenBoxTimer.start(4, spawnGreenBox, 0); // Spawn a green box every 4 seconds
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
}
