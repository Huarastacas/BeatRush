extends Control
 
@onready
var spectrum = AudioServer.get_bus_effect_instance(1,0)
 
@onready
var bottomRightArray = $CircleBase/Right/Bottom.get_children()

 
const VU_COUNT = 16
const HEIGHT = 60
const FREQ_MAX = 11050.0
 
const MIN_DB = 60
 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var prev_hz = 0
	for i in range(1,VU_COUNT+1):   
		var hz = i * FREQ_MAX / VU_COUNT;
		
		var escreva = {"A barra" : i , "Resulta" : hz}
		
		print(escreva)
		
		var f = spectrum.get_magnitude_for_frequency_range(prev_hz,hz)
		var energy = clamp((MIN_DB + linear_to_db(f.length()))/MIN_DB,0,1)
		var height = energy * HEIGHT
		
		prev_hz = hz
		
		var bottomRightRect = bottomRightArray[i - 1]
		
		var tween = get_tree().create_tween()
		tween.tween_property(bottomRightRect, "size", Vector2(bottomRightRect.size.x, height), 0.05)
 





