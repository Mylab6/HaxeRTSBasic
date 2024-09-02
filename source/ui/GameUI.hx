package ui;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxBar;
import flixel.ui.FlxButton;
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

	private var menuButton:FlxButton;
	private var menuGroup:FlxGroup;
	private var currentTab:String;

	private var energyBar:FlxBar;
	private var energyTimer:FlxTimer;
	private var energy:Int = 0;

	private static inline var MAX_ENERGY:Int = 3;

	public function new(time:Int)
    {
        timeLeft = time;

        // Initialize the countdown timer
        countdownTimer = new FlxTimer();
        countdownTimer.start(1, updateTimer, time);

		// Initialize the energy timer
		energyTimer = new FlxTimer();
		energyTimer.start(20, replenishEnergy, 0);

		// Create the timer background
		timerBackground = new FlxSprite(5, 5);
		timerBackground.makeGraphic(300, 70, FlxColor.BLACK);
		timerBackground.alpha = 0.5; // 50% transparency

		// Create the HP background
		hpBackground = new FlxSprite(FlxG.width - 315, 5);
		hpBackground.makeGraphic(300, 70, FlxColor.BLACK);
		hpBackground.alpha = 0.5; // 50% transparency

        // Initialize the timer text
		timerText = new FlxText(10, 10, 280, "Time Left: " + timeLeft);
		timerText.setFormat(null, 32, 0xFFFFFF); // Set text color to white and size to 32

        // Initialize the HP text
		hpText = new FlxText(FlxG.width - 310, 10, 280, "Boss HP: ");
		hpText.setFormat(null, 32, 0xFFFFFF); // Set text color to white and size to 32

		// Initialize the energy bar
		energyBar = new FlxBar(10, 80, FlxBarFillDirection.LEFT_TO_RIGHT, 200, 20, this, "energy", 0, MAX_ENERGY);
		energyBar.createFilledBar(FlxColor.GRAY, FlxColor.YELLOW);

		// Initialize the menu button
		menuButton = new FlxButton(FlxG.width - 330, FlxG.height - 165, "Menu", openMenu);
		menuButton.scale.set(3, 3); // Make the button 3x bigger
		menuButton.label.setFormat(null, 24, 0xFFFFFF); // Set button text color to white and size to 24

		// Initialize the menu group (initially hidden)
		menuGroup = new FlxGroup();
		menuGroup.visible = false;

		// Create the menu background
		var menuBackground:FlxSprite = new FlxSprite((FlxG.width - 660) / 2, (FlxG.height - 250) / 2);
		menuBackground.makeGraphic(660, 250, FlxColor.GRAY);
		menuBackground.alpha = 0.9; // 90% transparency
		menuGroup.add(menuBackground);

		// Add tabs and descriptions to the menu (arranged horizontally)
		addTab("Red", "Upgrade Reds", 10, Std.int((FlxG.width - 660) / 2));
		addTab("Green", "Upgrade Greens", 10, Std.int((FlxG.width - 460) / 2));
		addTab("Blue", "Upgrade Blues", 10, Std.int((FlxG.width - 260) / 2));
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

	private function replenishEnergy(timer:FlxTimer):Void
	{
		if (energy < MAX_ENERGY)
		{
			energy++;
			energyBar.value = energy;
		}
	}

    public function updateBossHP(newHP:Int):Void
    {
		// Update the boss HP text
		hpText.text = "Boss HP: " + newHP;
    }

    public function addToState(state:FlxState):Void
    {
		// Add the background boxes first
		state.add(timerBackground);
		state.add(hpBackground);

		// Then add the text elements on top of the background boxes
        state.add(timerText);
        state.add(hpText);
		state.add(energyBar); // Add the energy bar to the state

		// Add the menu button to the state
		state.add(menuButton);

		// Add the menu group (with the menu background and tabs) to the state
		state.add(menuGroup);
	}

	private function openMenu():Void
	{
		// Toggle the menu visibility
		menuGroup.visible = !menuGroup.visible;
	}

	private function addTab(tabName:String, description:String, yPosition:Int, xPosition:Int):Void
	{
		// Create the tab button
		var tabButton:FlxButton = new FlxButton(xPosition, FlxG.height - 250 + yPosition, tabName, function()
		{
			switchTab(tabName, description);
		});
		tabButton.scale.set(3, 3); // Make the tab button 3x bigger
		tabButton.label.setFormat(null, 24, 0xFFFFFF); // Set button text color to white and size to 24
		menuGroup.add(tabButton);
	}

	private function switchTab(tabName:String, description:String):Void
	{
		// Keep track of the current tab and update the tab's description text
		currentTab = tabName;

		// Loop through the menuGroup members and remove any FlxText objects
		for (i in 0...menuGroup.length)
		{
			var member = menuGroup.members[i];
			if (member is FlxText)
			{
				menuGroup.remove(member, true);
				// i--; // Decrement the index since the group length has changed
			}
		}

		// Add the description text for the current tab
		var descriptionText:FlxText = new FlxText((FlxG.width - 660) / 2 + 10, (FlxG.height - 250) / 2 + 50, 640, description);
		descriptionText.setFormat(null, 24, 0xFFFFFF); // Set text color to white and size to 24
		menuGroup.add(descriptionText);

		// Add upgrade options for Speed, HP, and Special Ability
		addUpgradeOption("Speed", upgradeSpeed);
		addUpgradeOption("HP", upgradeHP);
		addUpgradeOption("Special Ability", upgradeSpecialAbility);
	}

	private function addUpgradeOption(optionName:String, callback:Void->Void):Void
	{
		var upgradeButton:FlxButton = new FlxButton((FlxG.width - 660) / 2 + 10, (FlxG.height - 250) / 2 + 100 + menuGroup.length * 50, optionName, callback);
		upgradeButton.label.setFormat(null, 24, 0xFFFFFF); // Set button text color to white and size to 24
		menuGroup.add(upgradeButton);
	}

	private function upgradeSpeed():Void
	{
		// Logic for upgrading speed
    }
	private function upgradeHP():Void
	{
		// Logic for upgrading HP
	}

	private function upgradeSpecialAbility():Void
	{
		if (energy >= 3)
		{
			energy -= 3;
			energyBar.value = energy;
			// Logic for upgrading special ability
		}
	}
}