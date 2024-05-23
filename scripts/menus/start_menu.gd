extends Control

signal start_button_pressed
signal credits_button_pressed
signal options_button_pressed
signal quit_button_pressed
signal start_button_hovered
signal credits_button_hovered
signal options_button_hovered
signal quit_button_hovered

func _on_start_button_pressed() -> void:
	emit_signal("start_button_pressed")

func _on_credits_button_pressed() -> void:
	emit_signal("credits_button_pressed")

func _on_options_button_pressed() -> void:
	emit_signal("options_button_pressed")

func _on_quit_button_pressed() -> void:
	emit_signal("quit_button_pressed")

func _on_start_button_mouse_entered() -> void:
	emit_signal("start_button_hovered")

func _on_credits_button_mouse_entered() -> void:
	emit_signal("start_button_hovered")

func _on_options_button_mouse_entered() -> void:
	emit_signal("start_button_hovered")

func _on_quit_button_mouse_entered() -> void:
	emit_signal("start_button_hovered")
