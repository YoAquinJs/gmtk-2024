extends Node2D

@onready var citizen: Citizen =$"citizen"
@export var scene : Scene

func _process(_delta: float) -> void:
    if not is_instance_valid(citizen):
        return
    citizen.direction.x = Input.get_axis("left", "right")
    citizen.direction.y = Input.get_axis("up", "down")

# Handle end of city stage
func _on_citizen_destroy() -> void:
    scene.scene_manager.switch([Globals.SceneId.RADIO_TRANSITION, Globals.SceneId.HAND])
