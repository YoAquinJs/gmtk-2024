extends Node

enum SceneId {
    COMIC,
    START_MENU,
    HAND,
    CITY,
    RADIO_TRANSITION,
}

const preloaded_scenes: Dictionary = {
    SceneId.COMIC            : preload("res://scenes/comic.tscn"),
    SceneId.START_MENU       : preload("res://scenes/main.tscn"),
    SceneId.HAND             : preload("res://scenes/hand.tscn"),
    SceneId.CITY             : preload("res://scenes/city.tscn"),
    SceneId.RADIO_TRANSITION : preload("res://scenes/radio.tscn"),
}
