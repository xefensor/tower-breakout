class_name NodeUtils
extends Node


static func get_child_by_class(parent: Node, class_type: Variant):
	for child in parent.get_children():
		if is_instance_of(child, class_type):
			return child
	return null
