extends Node

@export var DoorID : String = "START";
@export var _streamingAssetsFolder : String = "./StreamingAssets";

#flag existance
func doesFlagExist(flagName : String):
	return getFlags().has(flagName);

#Get all flags
func getFlags():
	var path : String = _streamingAssetsFolder + "/shareddata.data";
	
	#get if file exists
	if (FileAccess.file_exists(path)):
		return [];
	
	#Return flags
	return FileAccess.open(path, FileAccess.READ).get_as_text().strip_edges().split("\n");

#Just a simple save function
func saveFlags(flags : Array):
	var path : String = _streamingAssetsFolder + "/shareddata.data";
	FileAccess.open(path,FileAccess.WRITE_READ).store_string("\n".join(flags));

func createFlag(flagName : String):
	var flags : Array = getFlags();
	
	#Append and save the flag
	if (not flags.has(flagName)):
		flags.append_array([flagName]);
		saveFlags(flags);

func deleteFlag(flagName: String):
	var flags : Array = getFlags();
	
	#Erase and save flags
	if (flags.has(flagName)):
		flags.erase(flagName);
		saveFlags(flags);
