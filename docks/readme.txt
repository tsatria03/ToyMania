Welcome to toy mania! In this game, you must collect toys, find keys, and defeat enemies before being able to escape the store.
To play the game, you have to move around the store collecting toys, defeating enemies, and unlocking the final exit. The goal of the game is to find all of the keys and reach the exit before the time runs out.
As you progress, the game becomes more and more challenging. You'll have to deal with cars, guards, and eventually a powerful boss that will chase you around the store.
You can equip various weapons, each with different strengths and ranges, to help fight off enemies. If your health reaches zero, or the time expires, you lose.
Can you escape before the boss inevitably catches you? Let's find out!

Keyboard commands
Letter, Q: Announces how many guards you've killed, if pressed.
Letter, E: Announces how many killable guards there are on the field, if pressed.
Letter, F: Announces how many cars you've destroyed, if pressed.
Letter, J: Announces how many destroyable cars there are on the field, if pressed.
Letter, S: Announces how much health the store has in the normal game mode, if pressed. In the endless game mode, this shortcut brings up the shop menu.
Letter, H: Announces how much health you have, if pressed.
Letter, L: Announces what level you're on and the game mode at witch you are playing, if pressed.
Letter, Y: Announces how much time you've been playing the game for, if pressed. In the sixth level of the Normal game Mode, it announces how much time you have left to escape the store instead.
Letter, T: Announces how many toys you've collected, if pressed.
Letter, O: Announces how many collectible toys there are on the field, if pressed.
Letter, K: Announces how many keys you've collected, if pressed.
Letter, U: Announces how many collectible keys there are on the field, if pressed.
Shift plus letter D: Announces how many keys are required to unlock the winning door, if pressed.
Letter, D: Announces the position of the winning door in the Endless game Mode, including its coordinates, if pressed. In the Normal game Mode, it tells you how far the door is in feet.
Letter, C: Announces your current location, if pressed.
Letter, I: brings up the inventory menu, if pressed.
Letter, W: brings up the weapons menu, if pressed.
Letter, X: Announces how many steps you've taken, if pressed.
Letter, Z: Announces the ammo of all of the weapons that take them, if pressed.
Letter, P: brings up the pause menu, if pressed.
Letter, R: Reloads ammo into all of the weapons that take them, if pressed.
Letter, M: Announces how much money you currently have in the endless game mode, if pressed.
Alt plus letter A: brings up the audio settings menu within the current game session, if pressed.
Alt plus letter G: brings up the game settings menu within the current game session, if pressed.
Page up: Razes the in-game music volume by 1 decibel, if pressed/held down.
Page down: Lowers the in-game music volume by 1 decibel, if pressed/held down.
Shift plus Page up: Razes the in-game alarm volume by 1 decibel, if pressed/held down.
Shift plus Page down: Lowers the in-game alarm volume by 1 decibel, if pressed/held down.
Home: Razes the in-game ambience volume by 1 decibel, if pressed/held down.
End: Lowers the in-game ambience volume by 1 decibel, if pressed/ held down.
Shift plus Home: Razes the in-game heartbeat volume by 1 decibel, if pressed/held down.
Shift plus End: Lowers the in-game heartbeat volume by 1 decibel, if pressed/held down.
Left arrow: Moves left on the X axis, if pressed/held down.
Right arrow: Moves right on the X axis, if pressed/held down.
Up arrow: Moves forward on the y axis, if pressed/held down.
Down arrow: Moves backward on the Y axis, if pressed/ held down.
Shift plus left arrow: Faces left for aiming, if pressed.
Shift plus right arrow: Faces right for aiming, if pressed.
Shift plus up arrow: Faces forward for aiming, if pressed.
Shift plus down arrow: Faces backward for aiming, if pressed.
Alt or Control plus left arrow: Moves left at double speed on the X axis, if pressed/held down.
Alt or Control plus right arrow: Moves right at double speed on the X axis, if pressed/held down.
Alt or Control plus up arrow: Moves forward at double speed on the Y axis, if pressed/held down.
Alt or Control plus down arrow: Moves backward at double speed on the Y axis, if pressed/held down.
Number row: Draws weapons 1 through 9 for use, if pressed. In the normal game mode, pressing the number 9 key will draw the pistol, while in the endless game mode, pressing that same key again will draw the machine_gun.
Tab: Cycles forward through the available inventory items, if pressed/held down.
Shift plus tab: Cycles backward through the available inventory items, if pressed/held down.
Spacebar: Fires the currently drawn weapon, if pressed/held down.
Enter: Interacts with various game elements, such as doors, dialogs, and lots of other menu items, if pressed/held down.
Shift plus enter: Uses the current inventory item when it's focused, if pressed/held down.
Escape: Exits the current game session, and returns back to the main menu, if pressed/held down.

Creating sound packs.
This game allows you to create customizable sound packs that can be used to change the way the game sounds in various situations. These sound packs can include new dialog voices, menu sounds, toy collection sounds, weapon sounds, background ambiences, and much more.
Each created sound pack must be placed inside its own folder within the main sounds/ directory. For example, if you're making a winter-themed sound pack, you would create a folder named sounds/winter.
You could also have folders like sounds/default, sounds/summer, or any other name you like. Inside each sound pack folder, you can include specific subfolders that match the structure used by the game.
These include folders such as ui/dialogs, ui/menus, npc/bosses, npc/guards, and much more. The game will automatically scan for sounds in these folders and use them when appropriate.
You can change the sound pack at any time using the sound settings menu from within the game. This menu also lets you choose different dialog and menu themes from within a selected sound pack, giving you even more control over how the game will sound.
One thing to note is that not all sound folders are modifiable in the same way. Some parts of the game are hardcoded and intentionally do not support custom categories or subfolders.
This is to maintain the structure, balance, and intended design of the game. For example, the equipments/weapons/artillery folder only supports two hardcoded ammo-based weapons.
Adding more weapons to that folder will be ignored by the game. Similarly, the equipments/weapons/melee folder supports only eight short to long-ranged melee weapons.
These are the only weapons the game recognizes, and attempting to add more will have no effect on the game. The objects/platforms folder is also limited in that only three platform types exist in the game, and no new ones can be added.
Likewise, the folders objects/healers and objects/sources are hardcoded for specific game events, and while you can replace the sound files inside them, you can't create new categories or folders under them. The other restricted folders include misc/player, misc/game, and misc/store.
These contain system sounds for events like game start, buying items, player death, and so on. You can swap out the sounds in these folders, but again, adding new folders or custom categories here won’t work.
The equipments/items/endless folder is also not expandable. It only supports predefined items used in endless mode, and the game will ignore any new subfolders you try to add here.
On the other hand, several of the other folders are fully modifiable and designed to support custom content. For example, you can create your own folders under npc/bosses, npc/guards, and npc/cars to add new voice packs or sound styles for these characters.
You can also create new subfolders in ui/dialogs and ui/menus to build your own dialog or menu sound themes. Additionally, the folders equipments/items/normal/keys/common, equipments/items/normal/keys/other, equipments/items/normal/toys/common, and equipments/items/normal/toys/other support the creation of new folders.
This means you can add your own toy and key sounds freely in these locations, and the game will detect them automatically. This game gives you a great deal of freedom when customizing the audio experience, but it's balanced with intentional restrictions to protect the core structure of the game.
The game is not intended to be a realistic map builder. Instead, global sound packs give you a safe, creative way to personalize your experience without disrupting the game’s balance or it's core logic.

Character sound listing: 8 total.
buy.ogg: This sound is played when your character purchases upgrades.
death.ogg: This sound is played when your character dies.
heal.ogg: This sound is played When your character is healing.
hurt.ogg: This sound is played when your character gets hurt.
inv.ogg: This sound is played when your character cycles through there inventory.
land.ogg: This sound is played when your character lands on a platform.
lev.ogg: This sound is played when your character levels up.
turn.ogg: This sound is played when your character turns on the spot.

Item sound listing: 5 total.
break.ogg: This sound is played when an item is being broken.
fire.ogg: This sound is played when an item is being used.
get.ogg: This sound is played when an item is being grabbed.
hit.ogg: This sound is played when an item is used.
loop.ogg: This sound is played when an item is being looped.

Weapon sound listing: 6 total.
draw.ogg: This sound is played when a weapon is being drawn.
empty.ogg: This sound is played when a non melee weapon is being emptyed.
fire.ogg: This sound is played when a weapon is being used.
hit.ogg: This sound is played when a weapon is used.
reload.ogg: This sound is played when a non melee weapon is being reloaded with ammo.
shell.ogg: This sound is played when a non melee weapon dropps ammo shells.

Menu sound listing: 7 total.
click.ogg: This sound is played when you go through menu items.
close.ogg: This sound is played when a menu is being closed.
edge.ogg: This sound is played when a menu has reached a boundary.
enter.ogg: This sound is played when a menu item has been selected.
music.ogg: This sound is played when a menu has music.
open.ogg: This sound is played when a menu is being opened.

Npc sound listing: 11 total.
death.ogg: This sound is played when an entity dies.
heal.ogg: This sound is played when a boss enemy is healing.
hit.ogg: This sound is played when an entity hits your character.
hurt.ogg: This sound is played when an entity gets hurt.
launch.ogg: This sound is played when an entity launches another entity or object.
loop.ogg: This sound is played when a projectile is being looped.
spawn.ogg: This sound is played when an entity is being spawned.
step.ogg: This sound is played when an entity is moving.
take.ogg: This sound is played when an entity takes something.
taunt.ogg: This sound is played when an entity is taunting your character.
tel.ogg: This sound is played when a boss enemy teleports on the x or y axes of a map.
