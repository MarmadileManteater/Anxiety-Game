extends DefaultSceen


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not state.joyfriend_has_gone_pee:
		disable_cursor_change.emit()
		Helpers.set_timeout(
			func ():
				$Dialog.display()
		, 1, self)
		$Dialog.line_started.connect(
			func (index: int):
				if index == 0:
					$Dialog.set_title("joyfriend")
				if index == 1:
					$Dialog.clear_title()
				if index == 3:
					$Bandmate/AnimationPlayer.play("fade_in")
					$Dialog.set_title("another human")
				if index == 4:
					$Dialog.clear_title()
				if index == 7:
					$Dialog.set_title("another human")
				if index == 9:
					$Dialog.clear_title()
				if index == 10:
					$Dialog.set_title("another human")
				if index == 11:
					$Dialog.clear_title()
				if index == 12:
					$Dialog.set_title("another human")
				if index == 14:
					$Dialog.clear_title()
				if index == 18:
					$Dialog.set_title("another human")
				if index == 19:
					$Dialog.clear_title()
				if index == 20:
					$Dialog.set_title("another human")
				if index == 22:
					$Dialog.clear_title()
				if index == 23:
					$Dialog.set_title("another human")
				if index == 24:
					$Dialog.clear_title()
				if index == 26:
					$Dialog.set_title("another human")
				if index == 27:
					$Dialog.clear_title()
				if index == 29:
					$Dialog.set_title("another human")
				if index == 30:
					$Bandmate/AnimationPlayer.play_backwards("fade_in")
					$Dialog.set_title("joyfriend")
				if index == 31:
					$Dialog.clear_title()
		)
		$Dialog.done.connect(
			func ():
				Helpers.set_timeout(
					func ():
						enable_cursor_change.emit()
						state.joyfriend_has_gone_pee = true
						save()
				, 0.1, self)
		, ConnectFlags.CONNECT_ONE_SHOT)
		
func _on_clicked() -> void:
	$Dialog.progress()
