extends Node

func update_score(current_score):
	self.text = "Score: " + str(current_score)
	
func update_score_per_second(score_per_second):
	self.text = "Score per second: " + str(score_per_second)
