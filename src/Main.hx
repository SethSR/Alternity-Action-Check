import sys.io.File;

class Main {
	static public function main() {
		// var cc = new CharacterCollection(Parser.parse('"Zelda Fitzgerald" 15+ 2 -1 "PersonB" 12+ 2 1 "PersonC" 14+ 3 0 "PersonD" 10+ 2 -1'));
		// var input = Sys.stdin();
		var input = Sys.args();
		if (input.length > 0) {
			var file       = File.getContent(input[0]);
			var collection = Parser.parse(file);
			var cc         = CharacterCollection.rollRound(collection);

			Sys.println('');
			Sys.println(cc);
		} else {
			Sys.println('No file entered');
		}
	}
}