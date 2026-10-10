
class_name Helpers

static func clear_interval(timer: Timer):
	timer.get_parent().remove_child(timer)
	timer.queue_free()

static func set_timeout(callback: Callable, length: float, parent: Node2D):
	set_interval(callback, length, parent, true)

static func set_interval(callback: Callable, length: float, parent: Node2D, one_shot: bool = false) -> Timer:
	var timer = Timer.new()
	timer.one_shot = one_shot
	timer.timeout.connect(
		func ():
			callback.call()
			if one_shot:
				parent.remove_child(timer)
				timer.queue_free()
	)
	parent.add_child(timer)
	timer.start(length)
	return timer
