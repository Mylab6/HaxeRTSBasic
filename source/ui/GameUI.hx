package ui;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class GameUI
{
    public var timerText:FlxText;
    public var hpText:FlxText;
	private var timerBackground:FlxSprite;
	private var hpBackground:FlxSprite;
    private var countdownTimer:FlxTimer;
    private var timeLeft:Int;
    private var bossHP:Int;

    public function new(time:Int, initialBossHP:Int)
    {
        timeLeft = time;
        bossHP = initialBossHP;

        // Initialize the countdown timer
        countdownTimer = new FlxTimer();
        countdownTimer.start(1, updateTimer, time);

		// Create the timer background
		timerBackground = new FlxSprite(5, 5);
		timerBackground.makeGraphic(220, 50, FlxColor.BLACK);
		timerBackground.alpha = 0.5; // 50% transparency

		// Create the HP background
		hpBackground = new FlxSprite(FlxG.width - 215, 5);
		hpBackground.makeGraphic(220, 50, FlxColor.BLACK);
		hpBackground.alpha = 0.5; // 50% transparency

        // Initialize the timer text
        timerText = new FlxText(10, 10, 200, "Time Left: " + timeLeft);
		timerText.setFormat(null, 24, 0xFFFFFF); // Set text color to white

        // Initialize the HP text
        hpText = new FlxText(FlxG.width - 210, 10, 200, "Boss HP: " + bossHP);
		hpText.setFormat(null, 24, 0xFFFFFF); // Set text color to white
    }

    private function updateTimer(timer:FlxTimer):Void
    {
        timeLeft--;

        // Update the timer text
        timerText.text = "Time Left: " + timeLeft;

        // Check if time has run out
        if (timeLeft <= 0)
		{
            // Handle what happens when the time runs out, e.g., end the game or damage the player
        }
    }

    public function updateBossHP(newHP:Int):Void
    {
        bossHP = newHP;
        hpText.text = "Boss HP: " + bossHP;
    }

    public function addToState(state:FlxState):Void
    {
		// Add the background boxes first
		state.add(timerBackground);
		state.add(hpBackground);

		// Then add the text elements on top of the background boxes
        state.add(timerText);
        state.add(hpText);
    }
}
