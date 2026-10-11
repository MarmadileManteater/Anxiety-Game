extends Node2D

@export var start_screen: String = "the_pit"

var time: Helpers.Stage = Helpers.Stage.Early
var state: GameState = GameState.new()

var current_screen: DefaultSceen
var current_screen_name: String
var screen_history: Array
var enable_cursor: bool = true
var game_finished: bool = false

func _ready() -> void:
    Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
    load_screen(start_screen)

func _on_mouse_motion(position: Vector2) -> void:
    if not $Cursor.visible:
        $Cursor.show()
    $Cursor.position = (position / 1.5) + Vector2(30, 30)

func _on_mouse_direction_mouseover(direction: Helpers.Direction) -> void:
    if enable_cursor:
        $Cursor.flip_h = direction == Helpers.Direction.Right
        $Cursor.play(Helpers.direction_to_string(direction))

func _on_mouse_direction_mouseoff() -> void:
    $Cursor.flip_h = false
    $Cursor.play("default")
    
func load_screen(screen_name: String, save_history: bool = true):
    if save_history or screen_history.size() == 0:
        _on_mouse_direction_mouseoff()
    if current_screen != null:
        if save_history:
            screen_history.push_back(current_screen_name)
        remove_child(current_screen)
        current_screen.queue_free()
    current_screen_name = screen_name
    var scene: PackedScene = load("res://scenes/" + screen_name + "/" + screen_name + ".tscn")
    var instance: DefaultSceen = scene.instantiate()
    instance.time = time
    instance.state = state
    instance.background_animation_player = $Background/AnimationPlayer
    instance.mousemotion.connect(_on_mouse_motion)
    instance.mouseover.connect(_on_mouse_direction_mouseover)
    instance.mouseoff.connect(_on_mouse_direction_mouseoff)
    instance.zone_clicked.connect(_on_zone_clicked)
    instance.disable_cursor_change.connect(
        func ():
            enable_cursor = false
            _on_mouse_direction_mouseoff()
    )
    instance.enable_cursor_change.connect(
        func ():
            enable_cursor = true
    )
    instance.save_state.connect(
        func (given: GameState):
            state = given
    )
    instance.sound_check.connect(
        func ():
            if not $SoundCheck.playing:
                $SoundCheck.play()
                $SoundCheck.finished.connect(
                    func ():
                        play_music()
                , ConnectFlags.CONNECT_ONE_SHOT)
    )
    instance.play_music.connect(play_music, ConnectFlags.CONNECT_ONE_SHOT)
    instance.change_volume.connect(
        func(volume: float):
            $Resentment.volume_db = volume
            $SoundCheck.volume_db = volume - 30
    )
    add_child(instance)
    current_screen = instance

func _on_button_pressed() -> void:
    if game_finished:
        get_tree().reload_current_scene()
    current_screen._on_clicked()

func _on_button_exited() -> void:
    $Cursor.hide()
    
func _on_zone_clicked(screen_name: String) -> void:
    if enable_cursor:
        load_screen(screen_name)
    else:
        current_screen._on_clicked()

func _on_back_clicked(_screen_name: String) -> void:
    if enable_cursor:
        if screen_history.size() > 0:
            load_screen(screen_history.pop_back(), false)

func _on_back_mouseoff() -> void:
    _on_mouse_direction_mouseoff()

func _on_back_mouseover(direction: Helpers.Direction) -> void:
    if screen_history.size() > 0:
        _on_mouse_direction_mouseover(direction)

func play_music():
    if not $Resentment.playing:
        $Resentment.play()
        time = Helpers.Stage.Middle
        $Background/AnimationPlayer.play("modulate")
        $Resentment.finished.connect(
            func():
                enable_cursor = false
                $Dialog.done.connect(
                    func():
                        $Curtain/AnimationPlayer.play("fade_in")
                        $Curtain/AnimationPlayer.animation_finished.connect(
                            func(_name):
                                $FIN.show()
                                game_finished = true
                        , ConnectFlags.CONNECT_ONE_SHOT)
                )
                $Dialog.line_started.connect(
                    func(index: int):
                        if index == 0:
                            $Dialog.set_title("joyfriend")
                        if index == 1:
                            $Dialog.clear_title()
                )
                if state.has_danced:
                    $Dialog.text[1] = "I agree."
                
                $Dialog.display()
        )
