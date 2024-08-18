class_name SceneManager

extends Node

@export var default_scene : Globals.SceneId

var current_scene: Scene = null
var switch_queue: Array[Globals.SceneId] = []
@onready var anim = $"OverlayAnimator"

func _ready() -> void:
    _instance_scene(default_scene)

func _instance_scene(scene_id: Globals.SceneId) -> void:
    if not Globals.preloaded_scenes.has(scene_id):
        push_error("Trying to switch to invalid id scene")

    if current_scene != null:
        current_scene.free_scene()

    current_scene = Globals.preloaded_scenes[scene_id].instantiate()
    current_scene.scene_manager = self
    add_child(current_scene)

func switch(scenes: Array[Globals.SceneId]) -> void:
    anim.play("overlay_fadein")
    switch_queue.append_array(scenes)

func _on_overlay_animator_animation_finished(anim_name: StringName) -> void:
    if anim_name == "overlay_fadein":
        _instance_scene(switch_queue.pop_front())
        anim.play("overlay_fadeout")
