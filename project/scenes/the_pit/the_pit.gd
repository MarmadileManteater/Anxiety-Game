extends DefaultSceen

var clicked_on_dancers: bool = false
var yes_entered: bool = false
var yes_2_entered: bool = false
var final_yes: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	change_volume.emit(0)
	$Drawing.play(Helpers.stage_to_string(time))
	if time != Helpers.Stage.Early:
		play_music.emit()
		$Dancers.show()
		$Door.show()
		background_animation_player.play("modulate")
		$Dancers.set_modulate_timestamp(background_animation_player.current_animation_position)
		Helpers.set_interval(
			func ():
				$Dancers.set_modulate_timestamp(background_animation_player.current_animation_position)
		, 1, self)
		
func click_on_dancers() -> void:
	if state.has_danced:
		$Dancers.reveal_third()
		return
	if not clicked_on_dancers:
		_on_zone_mouseoff()
		clicked_on_dancers = true
		$Dialog.display()
		$Dialog.line_started.connect(
			func (index: int):
				if index == 2:
					$Dialog.set_title("joyfriend")
				if index == 3:
					$Dialog.clear_title()
					$Dialog.lock()
					$ChoiceWindow.show()
		)
	else:
		$Dialog.progress()
		
func _on_clicked() -> void:
	$Dialog.progress()

func _yes_entered() -> void:
	if $ChoiceWindow.visible:
		if not yes_entered:
			$ChoiceWindow/AnimationPlayer.play('flip')
			$ChoiceWindow/AnimationPlayer.animation_finished.connect(
				func (_name):
					yes_entered = true
			, ConnectFlags.CONNECT_ONE_SHOT)


func _on_yes_2_mouse_entered() -> void:
	if yes_entered and not yes_2_entered:
		$ChoiceWindow/AnimationPlayer.play('slide1')
		$ChoiceWindow/AnimationPlayer.animation_finished.connect(
			func (_name):
				yes_2_entered = true
		, ConnectFlags.CONNECT_ONE_SHOT)
	if yes_2_entered and not final_yes:
		$ChoiceWindow/AnimationPlayer.play('bounce1')
		$ChoiceWindow/Yes/Yes.show()


func _on_no_pressed() -> void:
	$Dialog.unlock()
	$Dialog.progress()
	$ChoiceWindow.hide()
	Helpers.set_timeout(
		func():
			yes_entered = false
			yes_2_entered = false
			final_yes = false
			clicked_on_dancers = false
			$ChoiceWindow/Yes/Yes.hide()
			$Dialog.index = 0
			$Dialog.line_finished = false
			$ChoiceWindow/AnimationPlayer.play("RESET")
			enable_cursor_change.emit()
	, 2, self)

func _on_yes_pressed() -> void:
	$Dialog.text[4] = "let's do this"
	$Dialog.done.connect(
		func ():
			state.has_danced = true
			save()
			$Dancers.reveal_third()
	, ConnectFlags.CONNECT_ONE_SHOT)
	$Dialog.unlock()
	$Dialog.progress()
	$ChoiceWindow.hide()
	Helpers.set_timeout(
		func():
			yes_entered = false
			yes_2_entered = false
			final_yes = false
			clicked_on_dancers = false
			$ChoiceWindow/Yes/Yes.hide()
			$Dialog.index = 0
			$Dialog.line_finished = false
			$ChoiceWindow/AnimationPlayer.play("RESET")
			enable_cursor_change.emit()
	, 2, self)

func _on_dancing_mouseover(direction) -> void:
	if not clicked_on_dancers:
		_on_zone_mouseover(direction)
