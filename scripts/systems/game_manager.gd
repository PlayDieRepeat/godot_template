extends Control

@export var start_menu_packed_scene: PackedScene
@export var credits_menu_packed_scene: PackedScene
@export var options_menu_packed_scene: PackedScene
@export var first_level_packed_scene: PackedScene
var start_menu_instance: Node
var credits_menu_instance: Node
var options_menu_instance: Node
var first_level_instance: Node

func _ready() -> void:
	ready_start_menu()

func ready_start_menu() -> void:
	start_menu_instance = start_menu_packed_scene.instantiate()
	add_child(start_menu_instance)
	start_menu_instance.connect("start_button_pressed", _on_start_button_pressed)
	start_menu_instance.connect("credits_button_pressed", _on_credits_button_pressed)
	start_menu_instance.connect("options_button_pressed", _on_options_button_pressed)
	start_menu_instance.connect("quit_button_pressed", _on_quit_button_pressed)

func ready_credits_menu() -> void:
	credits_menu_instance = credits_menu_packed_scene.instantiate()
	add_child(credits_menu_instance)
	credits_menu_instance.connect("back_to_start", _on_back_to_start_button_pressed)

func ready_options_menu() -> void:
	options_menu_instance = options_menu_packed_scene.instantiate()
	add_child(options_menu_instance)
	options_menu_instance.connect("back_to_start_from_options", _on_back_to_start_from_options)

func ready_first_level() -> void:
	first_level_instance = first_level_packed_scene.instantiate()
	add_child(first_level_instance)
	first_level_instance.connect("back_to_start_from_pause_menu", _on_back_to_start_from_pause_menu)

#
# START MENU HOOKUPS
func _on_start_button_pressed() -> void:
	$BloopPlayer.play()
	remove_child(start_menu_instance)
	ready_first_level()

func _on_credits_button_pressed() -> void:
	$BloopPlayer.play()
	remove_child(start_menu_instance)
	ready_credits_menu()

func _on_options_button_pressed() -> void:
	$BloopPlayer.play()
	remove_child(start_menu_instance)
	ready_options_menu()

func _on_quit_button_pressed() -> void:
	$BloopPlayer.play()
	get_tree().quit()

#
# CREDITS MENU HOOKUPS
func _on_back_to_start_button_pressed() -> void:
	remove_child(credits_menu_instance)
	ready_start_menu()

#
# OPTIONS MENU HOOKUPS
func _on_back_to_start_from_options() -> void:
	remove_child(options_menu_instance)
	ready_start_menu()

#
# PAUSE MENU HOOKUPS
func _on_back_to_start_from_pause_menu() -> void:
	remove_child(first_level_instance)
	ready_start_menu()

