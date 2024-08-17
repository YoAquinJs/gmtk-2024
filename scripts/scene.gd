class_name Scene

extends Node2D

signal freeing
signal switch(scenes: Array[Globals.SceneId])

@export var scene_id : Globals.SceneId

func free_scene() -> void:
    freeing.emit()
    queue_free()

# func _ready() -> void:
#     pass # Replace with function body.

# func _process(delta: float) -> void:
#     pass
