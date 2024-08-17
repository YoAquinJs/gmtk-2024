extends Node

enum SceneId {
    START_MENU,
    HAND,
    CITY,
    RADIO_TRANSITION,
}

const preloaded_scenes: Dictionary = {
    SceneId.START_MENU       : preload("res://scenes/main.tscn"),
    SceneId.HAND             : preload("res://scenes/hand.tscn"),
    SceneId.CITY             : preload("res://scenes/city.tscn"),
    SceneId.RADIO_TRANSITION : preload("res://scenes/radio.tscn"),
}
