extends Node2D

func _on_body_entered(body):
	if body.is_in_group("boat"):
		var checkpoint_index = self.get_index()
		var checkpoint_count = self.get_parent().get_child_count()
		self.get_tree().call_group("checkpoint_progress_listener", "on_boat_checkpoint_entered", body, checkpoint_index, checkpoint_count)
