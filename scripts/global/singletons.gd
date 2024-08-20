extends Node

@onready var scene_manager := \
    preload("res://scenes/global/scene_manager.tscn").instantiate() as SceneManager

@onready var game_manager := \
    preload("res://scenes/global/game_manager.tscn").instantiate() as GameManager

@onready var dialogue_system := \
    preload("res://scenes/global/dialogue_system.tscn").instantiate() as DialogueSystem

func _ready() -> void:
    add_child(scene_manager)
    add_child(game_manager)
    add_child(dialogue_system)
