class_name CHAIN_SceneSelector
extends Node
## The starting scene for your CHAIN 3 game.

## An array of "doors" this is how the game decides what scene to send you.
@export var _doorScenes : Array[ChainDoor];
## The scene you will first load into if the game has no entrance yet
@export var _defaultScene : PackedScene;

@export_category("streaming folder")
## Just the folder name for your streaming assets. 
## Folder name taken from Adam's Docs
@export var _streamingAssetsFolder : String = "./StreamingAssets";

func _ready() -> void:
	var doorPath : String = _streamingAssetsFolder + "/enter.door";
	
	if (FileAccess.file_exists(doorPath)):
		var doorID : String = FileAccess.open(doorPath, FileAccess.READ).get_as_text().to_lower();
		
		var matchingDoor : PackedScene = _defaultScene;
		# From my understanding comporable to unity's FirstOrDefault
		for door in _doorScenes:
			if (doorID == door.doorID.to_lower()):
				matchingDoor = load(door.myScene);
				chain3.DoorID = doorID;
				break;
		
		#once we are done switch to a packed scene
		if (matchingDoor):
			get_tree().change_scene_to_packed(matchingDoor);
	else:
		if (_defaultScene):
			get_tree().change_scene_to_packed(_defaultScene);
