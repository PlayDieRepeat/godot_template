extends Node
class_name Initializer

@export var scene_override: RScene
@export var use_ovveride: bool

var ready_to_start_game:= false

func _process(delta: float) -> void:
    if ready_to_start_game == true:
        return
    
    if (SoundManager.has_loaded == true) and (MusicManager.has_loaded == true) and (AudioBankRobber.has_loaded == true):
        ready_to_start_game = true
        Scenester.load_initial_scene()