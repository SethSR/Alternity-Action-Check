import sys.io.File;

class Main {
	static public function main() {
		// var cc = new CharacterCollection(Parser.parse('"Zelda Fitzgerald" 15+ 2 -1 "PersonB" 12+ 2 1 "PersonC" 14+ 3 0 "PersonD" 10+ 2 -1'));
		// var input = Sys.stdin();
		var input = Sys.args();
		if (input.length > 0) {
			var file_str = [
				for (file in input)
					try
						File.getContent(file)
					catch (ex: Dynamic) {
						Sys.println('Could not find a file named "$file".');
						'';
					}
			];
			var collection = Parser.parse(file_str.join('\n'));
			var cc         = CharacterCollection.rollRound(collection);

			Sys.println('');
			Sys.println(cc);
		} else {
			Sys.println('No files found');
		}
	}
}