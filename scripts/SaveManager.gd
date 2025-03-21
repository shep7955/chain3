extends Node


@export var SaveLocation := "user://SaveData01.sav"
@export var SaveNodeGroup := "Persistence"

var SaveData = {}

var SaveDataInformation = {
	"Filename": "SaveDataInformation", 
	"SaveVersion": 1.0,
	"Description": """I know, it's not a binary format.
	It's totally wasting all the space on your SSD, right?
	Don't worry, I'll do a binary format next time."""
	}



const SavePassword = "EncryptionLOLIKnowYouGuysWillCrackThisInSeconds"



func InitSaveData():
	#print("InitSaveData")
	if !LoadGameData():
		#print("Save data incomplete or corrupted, repairing")
		if !SaveGameData():
			print("Unable to create save file, returning")
			return false
	return true


func EraseSaveData() -> bool:
	var FileManager = FileAccess.open_encrypted_with_pass(SaveLocation, FileAccess.WRITE, SavePassword)
	FileManager.close()
	return true


func SaveGameData() -> bool:
	UpdateLocalData()
	
	var FileManager = FileAccess.open_encrypted_with_pass(SaveLocation, FileAccess.WRITE, SavePassword)
	#var error = FileManager.open(SaveLocation, File.WRITE)
	#if error != OK:
	#	FileManager.close()
	#	return false
	
	for i in SaveData.keys():
		FileManager.store_string(JSON.stringify(SaveData[i]))
	
	FileManager.close()
	return true


func LoadGameData() -> bool:
	if !FileAccess.file_exists(SaveLocation):
		print("No Save Data found")
		UpdateNodeData("SaveDataInformation", SaveDataInformation)
		return false
	
	var FileManager = FileAccess.open_encrypted_with_pass(SaveLocation, FileAccess.READ, SavePassword)
	
	print("FileManager: file %s is size %s" % [SaveLocation, FileManager.get_len()])
	
	var json = JSON.new()
	
	while(FileManager.get_position() < FileManager.get_len()):
		var line = FileManager.get_line()
		if line == null:
			print("Should never happen, clearly something's gone wrong here")
			FileManager.close()
			return false
		
		var error = json.parse(line)
		if error == OK:
			var data = JSON.parse_string(line)
			SaveData[data["Filename"]] = data
	
	FileManager.close()
	
	if !SaveData.has("SaveDataInformation"):
		return false
	
	return true


func UpdateNodeData(filename, newdata):
	SaveData[filename] = newdata
	

func GetNodeData(filename):
	if SaveData.has(filename):
		return SaveData[filename]
	else:
		return null


func UpdateLocalData():
	var saveNodes = get_tree().get_nodes_in_group(SaveNodeGroup)
	for i in saveNodes:
		if i.OwnerName == null:
			#node isn't currently in tree
			continue
		i.call("SavePersistenceData")
