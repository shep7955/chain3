class_name ChainDoor
extends Resource

## The door ID
@export var doorID : String;
## The path to your scene
@export var myScene : String;

@export_category("streaming folder")
## Just the folder name for your streaming assets. 
## Folder name taken from Adam's Docs
@export var _streamingAssetsFolder : String = "./StreamingAssets";

func ExitGame(callingNode : Node):
	var doorPath : String = _streamingAssetsFolder + "/exit.door";
	FileAccess.open(doorPath,FileAccess.WRITE_READ).store_string(doorID);
	
	callingNode.get_tree().quit();
