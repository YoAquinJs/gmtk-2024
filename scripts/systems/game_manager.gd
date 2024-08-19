class_name GameManager

extends Node

enum Stage {
    START_MENU,
    INTRODUCTION,
    HAND,
    CITIZEN,
    END,
}

# Decitions

@export var turns : int
@export var decitions_per_turn : int
@export var _decition_deck : DecitionDeck

var _game_decitions: Array[Decition]
var _stat_change: Dictionary
var _citizen_news: Array[String]

var stage : Stage:
    get: return stage
var turn : int:
    get: return turn

# Statistics

var health: int = 0:
    get: return health
var security: int = 0:
    get: return security
var economy: int = 0:
    get: return economy

func _ready() -> void:
    if Singletons.game_manager != self:
        print("multiple game managers")
        queue_free()

    _game_decitions = _decition_deck.get_game_decitions(turns*decitions_per_turn)

    stage = Stage.START_MENU
    _stat_change = {
        Consequence.ConsequenceType.HEALTH : 50,
        Consequence.ConsequenceType.SECURITY : 50,
        Consequence.ConsequenceType.ECONOMY : 50,
    }

func start_introduction() -> void:
    if stage != Stage.START_MENU:
        push_warning("invalid start intro call")
        return

    stage = Stage.INTRODUCTION
    Singletons.scene_manager.switch([Globals.SceneId.COMIC, Globals.SceneId.HAND])

func end_introduction() -> void:
    if stage != Stage.INTRODUCTION:
        push_warning("invalid start intro call")
        return

    Singletons.scene_manager.switch([Globals.SceneId.RADIO_TRANSITION])


func get_decitions() -> Array[Decition]:
    return _game_decitions.slice(-decitions_per_turn)

func register_consequence(consequences: Array[Consequence]) -> void:
    if len(consequences) != decitions_per_turn:
        push_error("expected % consequences" % [decitions_per_turn])

    for consc in consequences:
        _citizen_news.append(consc.citizen_news)
        for stat in consc.stat_change.keys():
            _stat_change[stat] += consc.stat_change[stat]


func end_radio_transition() -> void:
    Singletons.scene_manager.switch()
    match Singletons.game_manager.stage:
        GameManager.Stage.INTRODUCTION, GameManager.Stage.CITIZEN:
            stage = Stage.HAND
            turn += 1
        GameManager.Stage.HAND:
            stage = Stage.CITIZEN

func get_intructions_report() -> Array[String]:
    return [
        "your task is to stabilize the city",
        "balance the health, security and economy statistics",
        "if one get's too low the city will colapse",
    ]

func get_citizen_report() -> Array[String]:
    return _citizen_news

func get_hand_report() -> Array[String]:
    var change : int
    var stat_report : String
    var report = []

    for stat in _stat_change.keys():
        change = _stat_change[stat]
        stat_report = "${0}-Statistic {1} by {2} points".format([
            Consequence.consequence_str(stat),
            "up" if change > 0 else "down",
            abs(change),
        ])
        report.append(stat_report)

    return report
