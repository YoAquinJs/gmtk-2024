class_name GameManager

extends Node

# Decitions

@export var num_decitions : int
@export var _decition_deck : DecitionDeck

var _game_decitions: Array[Decition]
var _last_consequences: Array[Consequence]

# Statistics

var health : int:
    get: return health
var security : int:
    get: return security
var economy : int:
    get: return economy

func _ready() -> void:
    if Singletons.game_manager:
        print("multiple game managers")
        queue_free()
    Singletons.game_manager = self

    _game_decitions = _decition_deck.get_game_decitions(num_decitions)

func get_decition() -> Decition:
    return _game_decitions.back()

func register_consequence(accepted: bool) -> void:
    var decition = _game_decitions.pop_back()
    _last_consequences.append(decition.accepted if accepted else decition.declined)
