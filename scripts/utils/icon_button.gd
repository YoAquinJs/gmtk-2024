class_name IconButton extends Control

enum State {
    RELEASED,
    HOVERED,
    CLICKED
}

signal clicked

@export var icon : Texture2D
@export var hover_color : Color
@export var clicked_color : Color

@onready var _icon: TextureRect = $"Icon"
@onready var _icon_tint: Panel = $"Icon/Tint"

var state := State.RELEASED

func _ready() -> void:
    _icon.texture = icon
    _set_tint()

func _on_icon_mouse_entered() -> void:
    state = State.HOVERED
    _set_tint(hover_color)

func _on_icon_mouse_exited() -> void:
    state = State.RELEASED
    _set_tint()

func _input(event):
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
        if event.is_pressed():
            if state == State.HOVERED:
                state = State.CLICKED
                _set_tint(clicked_color)
        else:
            if state == State.CLICKED:
                state = State.HOVERED
                clicked.emit()
                _set_tint(hover_color)

func _set_tint(color: Color = Color(0, 0, 0, 0)) -> void:
    var style := StyleBoxFlat.new()
    style.bg_color = color
    _icon_tint.add_theme_stylebox_override("panel", style)
