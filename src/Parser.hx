/*
character -> name score actions
name -> [String]
score -> [Int] '+'
actions -> [Int]
*/

class Parser {
	static var text = "";
	static var index = 0;

	static public function parse(s: String): Array<Character> {
		text = s;
		var finished = false;
		var array = [];
		while (!finished) {
			var character = parse_character();
			if (character != null)
				array.push(character);
			else
				finished = true;
		}
		return array;
	}

	static function parse_character(): Character {
		var name = parse_name();
		if (name == null)
			return null;
		var score = parse_score();
		if (score == null)
			return null;
		var actions = parse_actions();
		if (actions == null)
			return null;
		var modifier = parse_modifier();
		if (modifier == null)
			return new Character(name, score, actions, 0);
		else
			return new Character(name, score, actions, modifier);
	}

	static function match(regex: EReg, grp: Int = 0): String {
		if (regex.matchSub(text,index)) {
			index += regex.matchedPos().len+1;
			return regex.matched(grp);
		} else
			return null;
	}

	static function parse_name(): String {
		return match(~/"([^"]*)"/, 1);
	}

	static function parse_score(): Null<Int> {
		var score = match(~/([0-9]+)\+/, 1);
		if (score != null)
			return Std.parseInt(score);
		else
			return null;
	}

	static function parse_actions(): Null<Int> {
		var actions = match(~/[0-9]+/);
		if (actions != null)
			return Std.parseInt(actions);
		else
			return null;
	}

	static function parse_modifier(): Null<Int> {
		var modifier = match(~/[-+]?[0-9]+/);
		if (modifier != null)
			return Std.parseInt(modifier);
		else
			return null;
	}
}