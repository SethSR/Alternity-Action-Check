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
		if (score < 0)
			return null;
		var actions = parse_number();
		if (actions < 0)
			return null;
		var modifier = parse_modifier();
		if (modifier < 0)
			return new Character(name, score, actions, 0);
		else
			return new Character(name, score, actions, modifier);
	}

	static function match(regex: EReg): String {
		// Remove extra spaces
		var space = ~/\s/;
		while (space.matchSub(text,index,1))
			index += space.matchedPos().len;

		// Match regex
		if (regex.matchSub(text.substring(index),0) && regex.matchedLeft() == '') {
			index += regex.matchedPos().len;
			return regex.matched(0);
		} else
			return null;
	}

	static function parse_name(): String {
		var quote1 = match(~/'/);
		var name   = match(~/[^']*/);
		var quote2 = match(~/'/);
		return (quote1 != null && name != null && quote2 != null) ? name : null;
	}

	static function parse_score(): Int {
		var number = parse_number();
		var plus   = match(~/\+/);
		return (number > -1 && plus != null) ? number : -1;
	}

	static function parse_modifier(): Int {
		var mod = match(~/\-|\+/);
		if (mod != null) switch mod {
			case '-': return parse_number() * -1;
			case '+': return parse_number();
			case  _ : return parse_number();
		} else
			return parse_number();
	}

	static function parse_number(): Int {
		var num = match(~/[0-9]+/);
		return num != null ? Std.parseInt(num) : -1;
	}
}