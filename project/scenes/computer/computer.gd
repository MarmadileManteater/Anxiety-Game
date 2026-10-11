extends DefaultSceen

var arcade_sounds = []
var lock_stick: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	arcade_sounds = [$ArcadeSound1, $ArcadeSound2, $ArcadeSound3]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_clicked() -> void:
	super()


func _on_stick_2_pressed() -> void:
	if lock_stick:
		return
	lock_stick = true
	$Stick.play()
	$StickSound.play()
	$StickSound.finished.connect(
		func():
			var sound = arcade_sounds[randi_range(0, 2)]
			sound.finished.connect(
				func ():
					lock_stick = false
			, ConnectFlags.CONNECT_ONE_SHOT)
			sound.play()
	, ConnectFlags.CONNECT_ONE_SHOT)

func _on_buttons_2_pressed() -> void:
	if lock_stick:
		return
	lock_stick = true
	$Buttons.play()
	$ButtonsSound.play()
	$ButtonsSound.finished.connect(
		func():
			var sound = arcade_sounds[randi_range(0, 2)]
			sound.finished.connect(
				func ():
					lock_stick = false
			, ConnectFlags.CONNECT_ONE_SHOT)
			sound.play()
	, ConnectFlags.CONNECT_ONE_SHOT)
