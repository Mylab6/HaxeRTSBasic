package ui;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxTimer;

class GameUI
{
    public var timerText:FlxText;
    public var hpText:FlxText;
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

        // Initialize the timer text
        timerText = new FlxText(10, 10, 200, "Time Left: " + timeLeft);
        timerText.setFormat(null, 40, 0xF7F7F7); // Set text to red color

        // Initialize the HP text
        hpText = new FlxText(FlxG.width - 210, 10, 200, "Boss HP: " + bossHP);
        hpText.setFormat(null, 40, 0xFFFFFF); // Set text to red color
    }

    private function updateTimer(timer:FlxTimer):Void
    {
        timeLeft--;

        // Update the timer text
        timerText.text = "Time Left: " + timeLeft;

        // Check if time has run out
        if (timeLeft <= 0)
        {
            //countdownTimer.
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
        state.add(timerText);
        state.add(hpText);
    }
}
