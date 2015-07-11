class CharacterCollection {
	static public function rollRound(collection: Array<Character>): String {
		var max = [for (c in collection) c.print().length];
		max.sort(function(a,b) return b-a);

		return [for (c in phaseSort(newPhase(collection))) '${padName(c,max[0]+1)}> ${padPhase(c)}(${c.getActions()})'].join('\n');
	}

	static function padName(character: Character, n: Int): String { return StringTools.rpad(character.print(), '-', n); }

	static function padPhase(character: Character): String { return StringTools.rpad('' + character.getPhase(), ' ', 9); }

	static function newPhase(collection: Array<Character>): Array<Character> {
		var result = collection.copy();
		result.map(function(c) c.getPhase(true));
		return result;
	}

	static function phaseSort(collection: Array<Character>): Array<Character> {
		var result = collection.copy();
		result.sort(function(a,b) switch [b.getPhase(), a.getPhase()] {
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
		return result;
	}
}