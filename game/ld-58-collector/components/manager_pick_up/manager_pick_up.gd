class_name ComponentManagerPickUp
extends Node


@export var storages: Array[ComponentStorage]


# Return available Storage
func request(resource: DataResource, request_handler: Callable = same_resource_and_not_empty) -> ComponentStorage:
	if storages.size() == 0:
		push_error("Pick up requested but no storages defined in Manager!")
		return null

	return request_handler.call(storages, resource)


func request_sub_resource(storage: ComponentStorage, resource: DataResource, request_handler: Callable = handle_sub_resource) -> ComponentStorage:
	return request_handler.call(storage, resource)


func same_resource_and_not_empty(request_storages: Array[ComponentStorage], request_resource: DataResource) -> ComponentStorage:
	for request_storage in request_storages:
		if request_storage.resource == request_resource and request_storage.current > 0:
			return request_storage
	return null


func handle_sub_resource(requested_storage: ComponentStorage, requested_sub_resource: DataResource) -> ComponentStorage:
	if requested_sub_resource and requested_storage is not ContainerStorage:
		push_error("Sub resource requested but requested storage is not a ContainerStorage.")
		return null

	if requested_storage.resource.sub_resource == requested_sub_resource:
		return requested_storage.get_first()

	return null


# Return picked up amount
func pick_up(storage: ComponentStorage, amount := 1) -> int:
	if storage.current - amount > 0:
		storage.current -= amount
		return amount
	else:
		var left_over := storage.current
		storage.current = 0
		return left_over
