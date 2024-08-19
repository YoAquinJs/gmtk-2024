class_name radio extends Scene

var _dialogs : int

func _ready() -> void:
    Singletons.dialog_system.dequeued_dialog.connect(_on_dequeued_dialog)

    match Singletons.game_manager.stage:
        GameManager.Stage.INTRODUCTION:
            report(Singletons.game_manager.get_intructions_report())
        GameManager.Stage.HAND:
            report(Singletons.game_manager.get_hand_report())
        GameManager.Stage.CITIZEN:
            report(Singletons.game_manager.get_citizen_report())

func report(content: Array[String]) -> void:
    _dialogs = len(content)
    for new in content:
        Singletons.dialog_system.enqueue_dialog(DialogSystem.Dialog.new(new, true))

func _on_dequeued_dialog() -> void:
    _dialogs -= 1
    if _dialogs == 0:
        Singletons.game_manager.end_radio_transition()
