https://youtu.be/mwG8BfOPCIk - YouTube Video for it



**All assets, gd. script files and scenes are in this folder.**

## Game Premise:

- You are given the choice between 3 areas (forest, valley and mountains), depending on the location, a different loop of music will play.
- There is a counter at the top to display the distance walked
- There is an autowalk button that will move the character for you
- If you tire of one area you can switch with [P] as displayed at the top right
- There is no end condition to the game or goal. Just a nice walk with good scenery.


### Scripts:
1. **character.gd** - contains all the movement features for the character and flags for the music
2. **global.gd** - contains all the defaults flags that are interchanged with the other external nodes (mainly just root and character)
3. **main_men.gd** - contains everything needed for the menu (canvaslayer with buttons and title label)
4. **root.gd** - all the scripting for the MIDI, connects the boolean variables to flag unique functions to trigger.

### Scenes:
1. **Character.tcsn** - Has all the nodes connected (Animated sprite sheet (tuned))
2. **Forest.tcsn** - Contains the moving image layers and sprites for the forest.
3. **mountains.tscn** - Contains the moving image layers and sprites for the mountains.
4. **valley.tscn** - Contains the moving image layers and sprites for the valley.
5. **main_me.tscn** - Layered image with all the buttons.
6. **root.tscn** - Contains MIDI Node, Camera (Canvas layers tied to it), world boundry

### Asset Packs:
1. **FreeKnight** - Contains the sprites pack for the character
2. **Pixel Art Forest** - Pack with forest sprites (layers)
3. **Pixel Art Hill** - Contains valley sprites (layers)
4. **Glacial-mountains-parallax** - Contains the layers for the mountains
5. **mainmen.webp** - Contains the layered image I used for the main menu
6. **TimGM6mb.sf2** - contains the sf file for the MIDI audio
7. **Tiny RPG Character Asset Pack** - Unused assets (had a plan for enemies but didnt do it)
