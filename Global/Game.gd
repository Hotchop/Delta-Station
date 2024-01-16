extends Node

const DATE_START = 0
var date
var difficultyList: Dictionary = {
	"Easy": 1,
	"Normal": 0.7,
	"Hard": 0.5,
	"Voided": 0
}
var difficulty

func _ready():
	date = DATE_START
	difficulty = difficultyList["Normal"]

func next_day():
	date += 1
