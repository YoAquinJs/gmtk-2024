extends Node

@onready var scene_manager := \
    preload("res://scenes/global/scene_manager.tscn").instantiate() as SceneManager

@onready var game_manager := \
    preload("res://scenes/global/game_manager.tscn").instantiate() as GameManager

@onready var dialog_system := \
    preload("res://scenes/global/dialog_system.tscn").instantiate() as DialogSystem

func _ready() -> void:
    add_child(scene_manager)
    add_child(game_manager)
    add_child(dialog_system)
