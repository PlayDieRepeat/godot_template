extends Node

@export var main_menu_scene: RScene
@export var initial_scene: RScene
var current_scene_id:= ""
var current_scene = null

func _ready() -> void:
	assert(main_menu_scene != null,"Main menu scene is not set")
	if initial_scene == null:
		initial_scene = main_menu_scene
	var root := get_tree().root
	current_scene = root.get_child(root.get_child_count() -1)
	
# Returns the id of the current scene
func get_curren_scene_id() -> String:
	return current_scene_id
	
func load_initial_scene() -> void:
	call_deferred("_deferred_switch_scene", initial_scene)	

# Switch to a scene based on its id
# 	p_scene_id: The scene id to switch to
func switch_scene(p_scene: RScene) -> void:
	call_deferred("_deferred_switch_scene", p_scene)

func _deferred_switch_scene(p_scene: RScene):
	if current_scene != null:
		current_scene.free()

	var scene_to_load = ResourceLoader.load(p_scene.scene.get_path())
	current_scene = scene_to_load.instantiate()
	
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
	
	current_scene_id = p_scene.scene_id
	
# Restart the current scene
func restart_scene() -> void:
	get_tree().reload_current_scene()

# Quit the game
func quit_game() -> void:
	get_tree().quit()