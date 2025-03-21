Note you are going to have to create a StreamingAssets folder in your exported project.
This is because godot 4.3's FileAccess.open won't create a file.
if neccesary make a exit.door and enter.door file

When the plugin is installed make sure to restart godot to have the autoload take effect

When you start working on your project make sure a CHAIN_SceneSelector is your main scene
so that when your game is loaded up your game will be able to load the correct scene based

To create a door make a ChainDoor resource. If you want to exit through a door
call the ExitGame function on your door resource passing in a node from your scene.
