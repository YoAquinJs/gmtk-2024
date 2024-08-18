class_name DecitionDeck

extends Resource

@export var deck : Array[Decition]

func get_game_decitions(num_decitions: int) -> Array[Decition]:
    if num_decitions > len(deck):
        push_error("not enough decitions")

    var deck_copy = deck.duplicate()
    deck_copy.shuffle()
    return deck_copy.slice(0, num_decitions)
