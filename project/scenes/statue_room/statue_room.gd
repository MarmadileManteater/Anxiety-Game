extends DefaultSceen


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	change_volume.emit(-20)
	if not state.statue_seen:
		disable_cursor_change.emit()
		Helpers.set_timeout(
			func ():
				$Dialog.display()
		, 1, self)
		$Dialog.line_started.connect(
			func (index: int):
				if index == 1:
					$Dialog.set_title("joyfriend")
				if index == 2:
					$Dialog.clear_title()
				if index == 3:
					$Dialog.set_title("joyfriend")
		)
		$Dialog.done.connect(
			func ():
				Helpers.set_timeout(
					func ():
						enable_cursor_change.emit()
						state.statue_seen = true
						save()
				, 0.1, self)
		, ConnectFlags.CONNECT_ONE_SHOT)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_clicked() -> void:
	$Dialog.progress()
