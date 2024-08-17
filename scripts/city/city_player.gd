extends Node2D

@onready var citizen: Citizen =$citizen

func _process(_delta: float) -> void:
    citizen.direction.x = Input.get_axis("left", "right")
    citizen.direction.y = Input.get_axis("up", "down")

# Handle end of city stage
func _on_citizen_destroy() -> void:
    pass
