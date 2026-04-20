tool
extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

export(float, 450, 1000, 0.1) var length_mm = 100 setget set_length

func set_length(value):
	var plane = get_node_or_null("Balka") as Spatial
	length_mm = value
	if plane:
		plane.scale.z = length_mm/100
		$Chains/gooseChains.translation.z = length_mm*8-4800
		$Chains/RcsGrabber.translation.z = length_mm*8-4800
		$Chains/gooseChains.translation.y = value-500
		$Chains/RcsGrabber.translation.y = value-500
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
