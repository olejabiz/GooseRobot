tool
extends Spatial

export(float, -1, 10, 0.1) var angle_degrees = 10 setget set_angle
func set_angle(value):
	var joint1 = get_node_or_null("Joint1") as RcsJoint
	var joint2 = get_node_or_null("Joint2") as RcsJoint
	var joint3 = get_node_or_null("Joint2/gooseAmort") as Spatial
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
