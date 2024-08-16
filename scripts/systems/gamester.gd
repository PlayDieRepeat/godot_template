extends Node
## This scene will check to make sure any autoloads are ready and then load
## the initial scene set in the Scenester.  If you're iterating on a different scene
## locally, you can add it here and set the override to true to load that instead.
## IMPORTANT :: ALL Autoloads should be hooked up here (idealy we could do this automatically)
## This scene also grabs platform, build, and gamepad information

enum InputType {AUTO_DETECT, FORCE_CONTROLLER, FORCE_MOUSE_KEYBOARD}
@export_group("Game Options")
@export var input_detect_type: InputType

@export_group("Scene Override Options")
@export var scene_override: RScene
@export var use_override: bool

var ready_to_start_game:= false
var platform_name:= ""
var is_debug_build:= false
var gamepads: Array[int]= []
var gamepad_info: Array[Dictionary]= []

func _detect_gamepads() -> bool:
	gamepads= Input.get_connected_joypads()
	
	if !gamepads.is_empty():
		print("Gamepad(s) detected!")
		for pad in gamepads:
			gamepad_info.append(Input.get_joy_info(pad))
		return true
	else:
		return false

func _ready() -> void:
	is_debug_build= OS.is_debug_build()
	print("Is dev build: ", is_debug_build)
	
	var platform_name: String= OS.get_name()
	match platform_name:
		"Windows":
			print("Platform: Windows")
		"macOS":
			print("Platform: Mac OS")
		"Web":
			print("Platform: Web")

	match input_detect_type:
		InputType.AUTO_DETECT:
			print("Auto-Detecting input type")
			if _detect_gamepads():
				pass
		InputType.FORCE_CONTROLLER:
			print("Forcing controller input type")
			if _detect_gamepads():
				pass
		InputType.FORCE_MOUSE_KEYBOARD:
			print("Forcing KnM input type")

func _process(delta: float) -> void:
	if ready_to_start_game == true:
		return
	
	if (SoundManager.has_loaded == true) and (MusicManager.has_loaded == true) and (AudioBankRobber.has_loaded == true):
		ready_to_start_game = true
		if (use_override == true) and (scene_override != null):
			Scenester.switch_scene(scene_override)
		else:
			Scenester.load_initial_scene()
