class CharacterCollection {
	static public function rollRound(collection: Array<Character>): String {
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
}