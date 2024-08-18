class_name Consequence

extends Resource

enum ConsequenceType {
    HEALTH,
    SECURITY,
    ECONOMY,
}

@export var stat_change : Dictionary = {
    ConsequenceType.HEALTH   : 0,
    ConsequenceType.SECURITY : 0,
    ConsequenceType.ECONOMY  : 0,
    }:
    get: return stat_change

@export var affected_district : Globals.District:
    get: return affected_district
@export var district_consequence : ConsequenceType:
    get: return district_consequence
