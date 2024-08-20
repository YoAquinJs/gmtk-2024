extends Node

enum SceneId {
    COMIC,
    START_MENU,
    HAND,
    CITY,
    RADIO_TRANSITION,
}

const resource_scenes: Dictionary = {
    SceneId.COMIC            : "res://scenes/comic.tscn",
    SceneId.START_MENU       : "res://scenes/start_menu.tscn",
    SceneId.HAND             : "res://scenes/hand.tscn",
    SceneId.CITY             : "res://scenes/city.tscn",
    SceneId.RADIO_TRANSITION : "res://scenes/radio.tscn",
}

enum District {
    NULL,
    ALPHA,
    BETHA
}
