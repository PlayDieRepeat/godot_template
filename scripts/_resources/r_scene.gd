extends Resource
class_name RScene

@export var scene: PackedScene
@export var scene_id: String

func _init(p_scene: PackedScene = null, p_scene_id:= "") -> void:
    scene = p_scene
    scene_id = p_scene_id