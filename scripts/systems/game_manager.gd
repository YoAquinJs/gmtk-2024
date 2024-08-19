class_name GameManager

extends Node

enum Stage {
    INTRODUCTION,
    HAND,
    CITIZEN,
    END,
}

# Decitions

@export var num_decitions : int
@export var _decition_deck : DecitionDeck

var _game_decitions: Array[Decition]
var _last_consequences: Array[Consequence]

var stage : Stage

# Statistics

var health : int:
    get: return health
var security : int:
    get: return security
var economy : int:
    get: return economy

func _ready() -> void:
    if Singletons.game_manager != self:
        print("multiple game managers")
        queue_free()

    stage = Stage.INTRODUCTION
    _game_decitions = _decition_deck.get_game_decitions(num_decitions)

func get_decition() -> Decition:
    return _game_decitions.back()

func register_consequence(accepted: bool) -> void:
    var decition = _game_decitions.pop_back()
    _last_consequences.append(decition.accepted if accepted else decition.declined)

func end_radio_transition() -> void:
    Singletons.scene_manager.switch()

func get_citizen_report() -> Array[String]:
    var report = []
    for consc in _last_consequences:
        report.append(consc.citizen_news)
    return report

func get_hand_report() -> Array[String]:
    var change : int
    var stat_report : String
    var report = []
    var stat_change := {}

    for consc in _last_consequences:
        for stat in consc.stat_change.keys():
            change = consc.stat_change[stat]
            stat_change[stat] = stat_change.get(stat, 0) + change

    for stat in stat_change.keys():
        change = stat_change[stat]
        stat_report = "${0} {1} by {2} points".format([
            Consequence.consequence_str(stat),
            "increase" if change > 0 else "decrease",
            abs(change),
        ])
        report.append(stat_report)

    return report
