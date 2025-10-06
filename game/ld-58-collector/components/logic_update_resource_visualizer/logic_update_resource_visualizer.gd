class_name ComponentUpdateResourceVisualizer
extends ComponentLogicBlock


@export var resource_visualizer: ComponentResourceVisualizer
@export var resource: DataResource


func update(_only_return := false) -> Variant:
	resource_visualizer.update(resource)
	return null
