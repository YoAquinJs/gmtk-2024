class_name Scene

extends Node2D

signal freeing

@export var scene_id : Globals.SceneId
var scene_manager: SceneManager

func free_scene() -> void:
    freeing.emit()
    queue_free()
