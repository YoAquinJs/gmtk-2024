class_name SceneManager

extends Node

@export var default_scene : Globals.SceneId

@onready var anim: AnimationPlayer = $"Overlay/OverlayAnimator"
@onready var overlay: ColorRect = $"Overlay/OverlayLayer/Overlay"

var current_scene: Scene = null
var switch_queue: Array[Globals.SceneId] = []
# var loaded_scenes: Dictionary = {}

func _ready() -> void:
    overlay.color.a = 0
    _instance_scene(default_scene)

func _instance_scene(scene_id: Globals.SceneId) -> void:
    if not Globals.resource_scenes.has(scene_id):
        push_error("Trying to switch to invalid id scene")

    if current_scene != null:
        current_scene.free_scene()

    current_scene = load(Globals.resource_scenes[scene_id]).instantiate()
    current_scene.scene_manager = self

    add_child(current_scene)

func switch(scenes: Array[Globals.SceneId] = []) -> void:
    switch_queue.append_array(scenes)
    if len(switch_queue) == 0:
        push_warning("no scene to switch to")
        return

    anim.play("overlay_fadein")
    # for scene in scenes:
    #     loaded_scenes[scene] = load(Globals.resource_scenes[scene])

func _on_overlay_animator_animation_finished(anim_name: StringName) -> void:
    if anim_name == "overlay_fadein":
        _instance_scene(switch_queue.pop_front())
        anim.play("overlay_fadeout")
