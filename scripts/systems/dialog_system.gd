class_name DialogSystem

extends Control

class Dialog:
    var _step : int
    var stream_size : int
    var stream: PackedStringArray:
        get: return stream
    var user_skipable: bool:
        get: return user_skipable

    func _init(_text: String, _user_skipable: bool) -> void:
        stream = _text.split(" ")
        _step = 0
        stream_size = len(stream)
        user_skipable = _user_skipable

    func next() -> String:
        var s = stream[_step]
        _step += 1
        return s

    func empty() -> bool:
        return _step == stream_size

signal dequeued_dialog
# dequeued_dialog.connect(skip_dialog)

@onready var label: Label = $"label"
@onready var skip_label: Label = $"skiplabel"
@onready var timer: Timer = $"timer"

@export_range(0.1, 1, 0.05) var type_speed : float
var queue : Array[Dialog] = []
var curr_dialog : Dialog = null

func _ready() -> void:
    # singleton
    GameManager.dialog_system = self

    timer.wait_time = type_speed

    var skip_dialog_action = InputMap.action_get_events("skip_dialog")[0]
    var skip_dialog_key = OS.get_keycode_string(skip_dialog_action.physical_keycode)
    skip_label.text = "Skip ({0})".format([skip_dialog_key])
    skip_label.hide()
    label.text = ""

func _process(_delta: float) -> void:
    if curr_dialog and curr_dialog.user_skipable:
        if Input.is_action_just_pressed("skip_dialog"):
            skip_dialog()

    if not curr_dialog and queue:
        _process_dialog()

func enqueue_dialog(dialog: Dialog) -> void:
    queue.append(dialog)

func _process_dialog() -> void:
    curr_dialog = queue.pop_front()
    if curr_dialog.user_skipable:
        skip_label.show()
    else:
        skip_label.hide()

    timer.start()

func skip_dialog() -> void:
    if not queue and curr_dialog.user_skipable:
        skip_label.hide()

    curr_dialog = null
    timer.stop()
    label.text = ""
    dequeued_dialog.emit()

func _on_timer_timeout() -> void:
    label.text += curr_dialog.next()
    if curr_dialog.empty():
        timer.stop()
        dequeued_dialog.emit()

    label.text += " "
