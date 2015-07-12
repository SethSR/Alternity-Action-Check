class CharacterCollection {
	static public function rollRound(collection: Array<Character>): String {
		var name_len  = sort(collection.map(function(c) return '${c.getName()}'.length),
		                     function(a,b) return b-a)[0];
		var score_len = sort(collection.map(function(c) return '${c.printScore()}'.length),
		                     function(a,b) return b-a)[0];

		return [for (c in phaseSort(newPhase(collection))) {
			var name    = padName(c, name_len);
			var scores  = padScores(c, score_len);
			var phase   = padPhase(c);
			var actions = c.getActions();
			'$name ($scores) $phase($actions)';
		}].join('\n');
	}

	static function padName(character: Character, n: Int): String { return StringTools.rpad('' + character.getName(), ' ', n); }

	static function padScores(character: Character, n: Int): String { return StringTools.rpad('' + character.printScore(), ' ', n); }

	static function padPhase(character: Character): String { return StringTools.rpad('' + character.getPhase(), ' ', 9); }

	static function newPhase(collection: Array<Character>): Array<Character> {
		var result = collection.copy();
		result.map(function(c) c.getPhase(true));
		return result;
	}

	static function phaseSort(collection: Array<Character>): Array<Character> {
		var result = collection.copy();
		return sort(result,
		            function(a,b) switch [b.getPhase(), a.getPhase()] {
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
	}

	static function sort<T>(array: Array<T>, f: T -> T -> Int): Array<T> {
		array.sort(f);
		return array;
	}
}