class Main {
	static public function main() {
		var cc = new CharacterCollection(Parser.parse('"Zelda Fitzgerald" 15+ 2 -1 "PersonB" 12+ 2 1 "PersonC" 14+ 3 0 "PersonD" 10+ 2 -1'));

		Sys.println(cc.rollRound());
	}
}

class CharacterCollection {
	public function new(c: Array<Character>) {
		collection = c;
	}

	public function rollRound(): String {
		var max = [for (c in collection) c.print().length];
		max.sort(function(a,b) return b-a);

		collection.map(function(c) c.getPhase(true));

		collection.sort(function(a,b) switch [b.getPhase(), a.getPhase()] {
			case [ Amazing,  Amazing]: return  0;
			case [ Amazing,        _]: return  1;
			case [       _,  Amazing]: return -1;
			case [    Good,     Good]: return  0;
			case [    Good,        _]: return  1;
			case [       _,     Good]: return -1;
			case [Ordinary, Ordinary]: return  0;
			case [Ordinary,        _]: return  1;
			case [       _, Ordinary]: return -1;
			case [Marginal, Marginal]: return  0;
		});

		return [for (c in collection)
			StringTools.rpad(c.print(), '-', max[0]+1)
				+ '> '
				+ StringTools.rpad(''+ c.getPhase(), ' ', 9)
				+ '(' + c.getActions() + ')'].join('\n');
	}

	var collection: Array<Character>;
}