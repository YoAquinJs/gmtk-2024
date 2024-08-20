class_name comic extends Scene


@export var delay : int
@export var vignette_dialogs : Array[VignetteDialogues]
@export var vignette_images : Array[Control]

@onready var timer: Timer = $"Timer"
var next_vignette_queue : Array[int]
var prev_vignette_img: Control = null

func _ready() -> void:
    if len(vignette_dialogs) != len(vignette_images):
        push_error("incompatible dialogue and image vignette size")

    if len(vignette_dialogs) == 0:
        push_warning("no vignettes to show (skiping scene)")
        Singletons.game_manager.end_introduction()

    next_vignette_queue.assign(vignette_dialogs.map(func (vig): return len(vig.value)))
    if next_vignette_queue.any(func (d_len): return d_len == 0):
        push_error("empty vignette dialogue")

    timer.wait_time = delay
    timer.start()

func _on_timer_timeout():
    var dialog_sys = Singletons.dialog_system
    dialog_sys.dequeued_dialog.connect(_on_dequeued_dialog)
    for vig in vignette_dialogs:
        vig.value.map(func (d): dialog_sys.enqueue_dialog(DialogSystem.Dialog.new(d, true)))

func _on_dequeued_dialog() -> void:
    print("deque")
    next_vignette_queue[0] -=1
    if next_vignette_queue[0] > 0:
        return

    if prev_vignette_img != null:
        prev_vignette_img.hide()
    prev_vignette_img = vignette_images.pop_front()
    if prev_vignette_img != null:
        prev_vignette_img.show()

    next_vignette_queue.pop_front()

    if len(next_vignette_queue) == 0:
        Singletons.game_manager.end_introduction()
