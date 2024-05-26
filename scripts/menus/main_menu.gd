extends Node
class_name MainMenu

@export_group("Menu Sub Scenes")
@export var start_menu_packed_scene: PackedScene
@export var credits_menu_packed_scene: PackedScene
@export var options_menu_packed_scene: PackedScene

@export_group("Game Scenes")
@export var game_scene: RScene

var sub_menu_instance: Control
var button_hover_sfx_instance: PooledAudioStreamPlayer
var button_click_sfx_instance: PooledAudioStreamPlayer

func _ready() -> void:
	button_hover_sfx_instance = SoundManager.instance("ui", "ui_bloop", "UI Sounds")
	button_click_sfx_instance = SoundManager.instance("ui", "ui_buzz", "UI Sounds")
	ready_start_menu()

func ready_start_menu() -> void:
	sub_menu_instance = start_menu_packed_scene.instantiate()
	add_child(sub_menu_instance)
	register_button_ui_sounds()
	sub_menu_instance.connect("start_button_pressed", _on_start_game)
	sub_menu_instance.connect("credits_button_pressed", _on_go_to_credits)
	sub_menu_instance.connect("options_button_pressed", _on_go_to_options)
	sub_menu_instance.connect("quit_button_pressed", _on_quit)

func ready_credits_menu() -> void: 
	sub_menu_instance = credits_menu_packed_scene.instantiate() 
	add_child(sub_menu_instance)
	register_button_ui_sounds()
	sub_menu_instance.connect("back_to_start", _on_return_to_start)

func ready_options_menu() -> void:
	sub_menu_instance = options_menu_packed_scene.instantiate()
	add_child(sub_menu_instance)
	register_button_ui_sounds()
	sub_menu_instance.connect("back_to_start_from_options", _on_return_to_start)
	
func register_button_ui_sounds() -> void:
	for child in get_tree().get_nodes_in_group("Buttons"):
		child.connect("mouse_entered", _on_button_mouse_entered)
		child.connect("pressed", _on_button_clicked)

#
# EVENT HOOKUPS
func _on_start_game() -> void:
	Scenester.switch_scene(game_scene)
	
func _on_go_to_credits() -> void:
	remove_child(sub_menu_instance)
	button_hover_sfx_instance.release()
	ready_credits_menu()

func _on_go_to_options() -> void:
	remove_child(sub_menu_instance)
	button_hover_sfx_instance.release()
	ready_options_menu() 
	
func _on_return_to_start() -> void:
	remove_child(sub_menu_instance)
	button_hover_sfx_instance.release()
	ready_start_menu()

func _on_quit() -> void:
	Scenester.quit_game()

func _on_button_mouse_entered() -> void:
	button_hover_sfx_instance.trigger()

func _on_button_clicked() -> void:
	button_click_sfx_instance.trigger()
