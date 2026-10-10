extends Node2D

const text_speed = 0.01

signal line_started
signal done

@export var text: PackedStringArray
@export var title: String

var sprite: AnimatedSprite2D
var label: RichTextLabel
var label_animation_player: AnimationPlayer
var arrow: Sprite2D
var title_sprite: Sprite2D
var title_label: RichTextLabel

var current_line: String
var index: int = 0
var line_finished: bool = false
var typewriter_interval: Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite = $Sprite
	arrow = $Arrow
	label = $Label
	label_animation_player = $Label/AnimationPlayer
	title_sprite = $TitleSprite
	title_label = $TitleSprite/Label

func display() -> void:
	sprite.show()
	sprite.play("show")
	
	set_title(title, false)
	
	sprite.animation_finished.connect(
		func ():
			if title != "":
				title_sprite.show()
			typewriter(text[0])
	, ConnectFlags.CONNECT_ONE_SHOT)

func set_title(given: String = "", popup: bool = true) -> void:
	title = given
	if title != "":
		title_label.text = title
		label_animation_player.play("title")
		title_sprite.show()
	else:
		label_animation_player.play("no_title")
		title_sprite.hide()

func clear_title() -> void:
	set_title()

func typewriter(text: String) -> void:
	emit_line_started(index)
	label.show()
	current_line = text.replace("\\n", """
""")
	typewriter_interval = Helpers.set_interval(
		func ():
			var string_part = current_line.substr(0, 1)
			if string_part.contains("["):
				while not string_part.ends_with("]"):
					string_part += current_line.substr(string_part.length(), 1)
			current_line = current_line.substr(string_part.length())
			label.text += string_part
			if current_line.length() == 0:
				line_finished = true
				arrow.show()
				Helpers.clear_interval(typewriter_interval)
	, text_speed, self)
	
func progress():
	if line_finished:
		line_finished = false
		arrow.hide()
		label.text = ""
		index += 1
		if index < text.size():
			typewriter(text[index])
		else:
			sprite.play("hide")
			title_sprite.hide()
			sprite.animation_finished.connect(
				func ():
					sprite.hide()
					label.hide()
					hide()
					done.emit()
			, ConnectFlags.CONNECT_ONE_SHOT)
	
func emit_line_started(number: int) -> void:
	emit_signal("line_started", number)

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			progress()
