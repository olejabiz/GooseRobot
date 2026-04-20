tool
extends Spatial

export (int, 1, 5) var amount_of_slots = 1 setget set_amount_of_slots, get_amount_of_slots
func _ready():
	set_amount_of_slots(get_amount_of_slots())
	
func set_amount_of_slots(value):
	
	var Part = preload("res://scenes/gooseChain.tscn")
	var parts_node = get_node_or_null("gooseChains") as Spatial
	var current_amount = parts_node.get_child_count()
	
	amount_of_slots = value
	
	if parts_node:
		$RcsGrabber.translation.y = 3600 - 3080*amount_of_slots
#		\\$gooseChains.translation.y = 3438/amount_of_slots - 70\\
#		$gooseHook.translation.y = 3438 - 3438*amount_of_slots 
 
		if current_amount < value:
			while current_amount < value:
				var new_part = Spatial.new()
				new_part = Part.instance()
				new_part.translation.y = 0 - 3080*current_amount
				parts_node.add_child(new_part)
				new_part.set_owner(parts_node.owner)
				current_amount += 1
		else:			
			current_amount = parts_node.get_child_count()
			for i in range (0, current_amount-value):
				parts_node.get_child(parts_node.get_child_count()-1).free()
func get_amount_of_slots():
	return amount_of_slots
