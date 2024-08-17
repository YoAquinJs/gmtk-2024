class_name Citizen

extends CharacterBody2D

signal destroy

@export var speed : float
@export var acceleration : float

var direction = Vector2()

func _process(delta: float) -> void:
    velocity = lerp(velocity, direction.normalized() * speed, delta * acceleration)

    move_and_slide()

func trigger_destroy():
    destroy.emit()
    queue_free()
