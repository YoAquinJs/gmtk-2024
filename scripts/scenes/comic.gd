class_name comic extends Scene


@export var delay : int
@export var vignette_dialogs : Array[VignetteDialogues]
@export var vignette_images : Array[Control]

@onready var animator : AnimationPlayer = $"VignetteTransition/AnimationPlayer"
@onready var anim_overlay : ColorRect = $"VignetteTransition/Overlay"
@onready var timer: Timer = $"Timer"

var next_vignette_queue : Array[int]
var prev_vignette_img: Control = null

func _ready() -> void:
    anim_overlay.color.a = 0

    if len(vignette_dialogs) != len(vignette_images):
        push_error("incompatible dialogue and image vignette size")

    if len(vignette_dialogs) == 0:
        push_warning("no vignettes to show (skiping scene)")
        Singletons.game_manager.end_introduction()

    timer.wait_time = delay
    timer.start()

    next_vignette_queue.assign(vignette_dialogs.map(func (vig): return len(vig.value)))
    if next_vignette_queue.any(func (d_len): return d_len == 0):
        push_error("empty vignette dialogue")

    for img in vignette_images:
        _toogle_img(img, false)

func _on_timer_timeout():
    var dialog_sys = Singletons.dialogue_system
    dialog_sys.dequeued_dialog.connect(_on_dequeued_dialog)

    for vig in vignette_dialogs:
        var last_dialogue = DialogueSystem.Dialog.new(vig.value.pop_back(), true, false)
        vig.value.map(func (d): dialog_sys.enqueue_dialog(DialogueSystem.Dialog.new(d, true)))
        dialog_sys.enqueue_dialog(last_dialogue)

    prev_vignette_img = vignette_images.pop_front()
    _toogle_img(prev_vignette_img, true)

func next_vignette() -> void:
    _toogle_img(prev_vignette_img, false)
    prev_vignette_img = vignette_images.pop_front()
    _toogle_img(prev_vignette_img, true)

    Singletons.dialogue_system.process_dialog()
    next_vignette_queue.pop_front()

    if len(next_vignette_queue) == 0:
        Singletons.game_manager.end_introduction()

func _on_dequeued_dialog() -> void:
    next_vignette_queue[0] -= 1
    if next_vignette_queue[0] > 0:
        return

    animator.play("transition")

func _toogle_img(img: Control, show: bool) -> void:
    if not img:
        return
    if show:
        img.show()
    else:
        img.hide()
