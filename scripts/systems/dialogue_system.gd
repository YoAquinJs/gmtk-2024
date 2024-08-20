class_name DialogueSystem

extends Control

class Dialog:
    var _step : int
    var _stream_size : int
    var stream: PackedStringArray:
        get: return stream
    var skiped_by_user: bool:
        get: return skiped_by_user
    var continue_deque: bool:
        get: return continue_deque

    func _init(_text: String, _skiped_by_user: bool, _continue_deque: bool=true) -> void:
        stream = _text.split(" ")
        _step = 0
        _stream_size = len(stream)
        skiped_by_user = _skiped_by_user
        continue_deque = _continue_deque

    func next() -> String:
        var s = stream[_step]
        _step += 1
        return s

    func empty() -> bool:
        return _step == _stream_size

signal dequeued_dialog
signal timeout_dialog

@onready var label: Label = $"label"
@onready var skip_label: Label = $"skiplabel"
@onready var timer: Timer = $"timer"

@export_range(0.1, 1, 0.05) var type_speed : float
var _queue : Array[Dialog] = []
var _curr_dialog : Dialog = null

func _ready() -> void:
    if Singletons.dialogue_system != self:
        print("multiple dialog system")
        queue_free()

    timer.wait_time = type_speed
    label.text = ""

    var skip_dialog_action = InputMap.action_get_events("skip_dialog")[0]
    var skip_dialog_key = OS.get_keycode_string(skip_dialog_action.physical_keycode)
    skip_label.text = "Skip ({0})".format([skip_dialog_key])
    skip_label.hide()

    dequeued_dialog.connect(func(): print("dequeu dialogue"))

func _process(_delta: float) -> void:
    if _curr_dialog and _curr_dialog.skiped_by_user:
        if Input.is_action_just_pressed("skip_dialog"):
            _skip_dialog()

func enqueue_dialog(dialog: Dialog) -> void:
    _queue.append(dialog)
    if not _curr_dialog:
        process_dialog()

func process_dialog() -> void:
    if not _queue:
        return

    _curr_dialog = _queue.pop_front()
    if _curr_dialog.skiped_by_user:
        skip_label.show()
    else:
        skip_label.hide()

    timer.start()

func _skip_dialog() -> void:
    if not _queue and skip_label.is_visible_in_tree():
        skip_label.hide()

    label.text = ""
    timer.stop()

    dequeued_dialog.emit()
    if _curr_dialog.continue_deque:
        process_dialog()
    else:
        _curr_dialog = null

func _on_timer_timeout() -> void:
    label.text += _curr_dialog.next()
    if _curr_dialog.empty():
        timer.stop()
        timeout_dialog.emit()
        return

    label.text += " "
