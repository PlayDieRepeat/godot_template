extends Node

var has_loaded:= false

func _process(_p_delta) -> void:
	if has_loaded:
		return

	has_loaded = true
