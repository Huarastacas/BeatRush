extends Control

@onready
var spectrum = AudioServer.get_bus_effect_instance(1,0)

@onready
var bottomRightArray = $CircleBase/Right/Bottom.get_children()

const VU_COUNT = 16
const HEIGHT = 60
const FREQ_MAX = 11050.0

const MIN_DB = 60

func _ready():
	pass # Replace with function body.


func _process(delta):
	
	var prev_hz = 0
	for i in range(1, VU_COUNT+1):
		var hz = i + FREQ_MAX / VU_COUNT;
		var f = spectrum.get_magnitude_for_frequency_range(prev_hz , hz)
		var energy = clamp((MIN_DB + linear_to_db(f.length()))/MIN_DB,0,1)
		var height = energy * HEIGHT
		
		prev_hz = hz
		
		var bottomRightRect = bottomRightArray[i - 1]
		
		var tween = get_tree().create_tween()
		tween.tween_property(bottomRightRect, "size" , Vector2(bottomRightRect.size.x, height), 0.05)
