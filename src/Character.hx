class Character {
	public function new(n: String, s: Int, a: Int, m: Int) {
		name = n;
		score = s;
		actions = a;
		modifier = m;
	}

	public function printScore(): String {
		return '${score+1}+/$score/${Math.floor(score/2)}/${Math.floor(score/4)}';
	}

	static function rollDie(n: Int): Int {
		return Math.floor(Math.random() * n) + 1;
	}

	public function getName() return name;
	public function getScore() return score;
	public function getActions() return actions;
	public function getModifier() return modifier;

	public function getPhase(new_round: Bool = false): Phase {
		if (new_round) {
			var roll = roll();
			if (roll > score)        phase = Marginal;
			else if (roll > score/2) phase = Ordinary;
			else if (roll > score/4) phase = Good;
			else                     phase = Amazing;
			return phase;
		} else
			return phase;
	}

	function roll(): Int {
		switch modifier {
			case -5: return rollDie(20) - rollDie(20);
			case -4: return rollDie(20) - rollDie(12);
			case -3: return rollDie(20) - rollDie(8);
			case -2: return rollDie(20) - rollDie(6);
			case -1: return rollDie(20) - rollDie(4);
			case  0: return rollDie(20);
			case  1: return rollDie(20) + rollDie(4);
			case  2: return rollDie(20) + rollDie(6);
			case  3: return rollDie(20) + rollDie(8);
			case  4: return rollDie(20) + rollDie(12);
			case  5: return rollDie(20) + rollDie(20);
			case  6: return rollDie(20) + rollDie(20) + rollDie(20);
			case  7: return rollDie(20) + rollDie(20) + rollDie(20) + rollDie(20);
			case  _: return rollDie(20);
		}
	}

	var name = "";
	var score = 0;
	var actions = 0;
	var modifier = 0;
	var phase = Phase.Marginal;
}