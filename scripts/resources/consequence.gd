class_name Consequence

extends Resource

enum ConsequenceType {
    NONE,
    HEALTH,
    SECURITY,
    ECONOMY,
}

static func consequence_str(type: ConsequenceType) -> String:
    var parsed : String
    match type:
        ConsequenceType.HEALTH:
            parsed = "HEALTH"
        ConsequenceType.SECURITY:
            parsed = "SECURITY"
        ConsequenceType.ECONOMY:
            parsed = "ECONOMY"
        ConsequenceType.NONE, _:
            push_warning("invalid consequence type conversion")
            parsed = "Invalid"
    return parsed

@export var stat_change : Dictionary = {
    ConsequenceType.HEALTH   : 0,
    ConsequenceType.SECURITY : 0,
    ConsequenceType.ECONOMY  : 0,
    }:
    get: return stat_change

@export var citizen_news : String
@export_range(1, 100, 10) var strenght : int:
    get: return strenght
@export var district_consequence : ConsequenceType:
    get: return district_consequence
@export var affected_district : Globals.District:
    get: return affected_district
