extends Node2D

signal line_done

@export var text: PackedStringArray

var sprite: AnimatedSprite2D
var label: RichTextLabel

var current_line: String
var index: int = 0
var line_finished: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite = $Sprite
	label = $Label
	
	Helpers.set_timeout(
		func ():
			display()
			sprite.animation_finished.connect(
				func ():
					typewriter(text[0])
			, ConnectFlags.CONNECT_ONE_SHOT)
	, 1, self)

func display() -> void:
	sprite.show()
	sprite.play("show")

func typewriter(text: String) -> void:
	label.show()
	current_line = text
	var timer = Helpers.set_interval(
		func ():
			var string_part = current_line.substr(0, 1)
			current_line = current_line.substr(string_part.length())
			label.text += string_part
			if current_line.length() == 0:
				emit_line_done(index)
				line_finished = true
	, 0.01, self)

	Helpers.set_timeout(
		func():
			remove_child(timer)
			timer.queue_free()
	, 1, self)
	
func progress():
	if line_finished:
		line_finished = false
		label.text = ""
		index += 1
		if index < text.size():
			typewriter(text[index])
		else:
			sprite.play("hide")
			sprite.animation_finished.connect(
				func ():
					sprite.hide()
					label.hide()
					hide()
			, ConnectFlags.CONNECT_ONE_SHOT)
	
func emit_line_done(number: int) -> void:
	emit_signal("line_done", number)
