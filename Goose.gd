tool 
extends Spatial

export (int, 1, 5) var amount_of_slots = 1 setget set_amount_of_slots, get_amount_of_slots
export(float, -1, 10, 0.1) var angle_degrees = 10 setget set_angle
export(float, 450, 1000, 0.1) var length_mm = 100 setget set_length
export(String, "1_5т", "1_5-3т", "3-5т", "None") var availability_of_the_connection = "None" setget set_connection_visible
# Размер всего крана
func set_connection_visible(value):
	availability_of_the_connection = value
	var t1 = get_node_or_null("gooseMainBody_1") as Spatial
	if t1:
		if availability_of_the_connection == "None":
			t1.visible = false
		if availability_of_the_connection == "1_5т":
			t1.visible = true
			$gooseMainBody_1.scale.x=0.25
			$gooseMainBody_1.scale.y=0.25
			$gooseMainBody_1.scale.z=0.25
		if availability_of_the_connection == "1_5-3т":
			t1.visible = true
			$gooseMainBody_1.scale.x=0.4
			$gooseMainBody_1.scale.y=0.4
			$gooseMainBody_1.scale.z=0.4
		if availability_of_the_connection == "3-5т":
			t1.visible = true
			$gooseMainBody_1.scale.x=0.6
			$gooseMainBody_1.scale.y=0.6
			$gooseMainBody_1.scale.z=0.6
# Длина выдвижной балки
func set_length(value):
	var plane = get_node_or_null("gooseMainBody_1/Joint1/gooseBalka_1/gooseBalka/Balka") as Spatial
	length_mm = value
	if plane:
		plane.scale.z = length_mm/100
		$gooseMainBody_1/Joint1/gooseBalka_1/gooseBalka/Chains/gooseChains.translation.z = length_mm*8-4800
		$gooseMainBody_1/Joint1/gooseBalka_1/gooseBalka/Chains/RcsGrabber.translation.z = length_mm*8-4800
		$gooseMainBody_1/Joint1/gooseBalka_1/gooseBalka/Chains/gooseChains.translation.y = value-500
# Угол поворота балки и гидравлики
func set_angle(value):
	var joint1 = get_node_or_null("gooseMainBody_1/Joint1") as RcsJoint
	var joint2 = get_node_or_null("gooseMainBody_1/Joint2") as RcsJoint
	var joint3 = get_node_or_null("gooseMainBody_1/Joint2/gooseAmort") as Spatial
	angle_degrees = value
	if joint1:
		joint1.rotation.x = angle_degrees/10
	if value>0:
		if value < 6:
			joint2.rotation.x = 0-angle_degrees/155
			joint3.translation.y = 0-6350-angle_degrees*380
		if value >= 6 && value < 7.3 :
			joint2.rotation.x = 0-angle_degrees/100
			joint3.translation.y = 0-6350-angle_degrees*380
		if value < 9.7 && value >=7.3 :
			joint2.rotation.x = 0-angle_degrees/80
			joint3.translation.y = 0-6350-angle_degrees*380
		if value >=9.7:
			joint2.rotation.x = 0-angle_degrees/57
			joint3.translation.y = 0-6350-angle_degrees*380
	else:
		joint2.rotation.x = angle_degrees/75
		joint3.translation.y = 0-6350+angle_degrees/100

# Количество ячеек цепи с крюком (длина цепи)
func _ready():
	set_amount_of_slots(get_amount_of_slots())
	
func set_amount_of_slots(value):
	
	var Part = preload("res://scenes/gooseChain.tscn")
	var parts_node = get_node_or_null("gooseMainBody_1/Joint1/gooseBalka_1/gooseBalka/Chains/gooseChains") as Spatial
	var current_amount = parts_node.get_child_count()
	
	amount_of_slots = value
	
	if parts_node:
		$gooseMainBody_1/Joint1/gooseBalka_1/gooseBalka/Chains/RcsGrabber.translation.y = 3080 - 3080*amount_of_slots
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
