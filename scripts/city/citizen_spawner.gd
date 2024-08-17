extends Node2D

var citizen = preload("res://scenes/city/citizen.tscn")

@export_range(0.1, 2, 0.1) var spawn_freq : float
@export var spawn_dir : Vector2

func _ready() -> void:
    var timer: Timer = $Timer
    timer.wait_time = spawn_freq

# func _process(delta: float) -> void:
#     pass

func instance_citizen():
    var instance: Citizen = citizen.instantiate()
    instance.position = position
    instance.direction = spawn_dir
    add_child(instance)

func _on_timer_timeout():
    instance_citizen()
