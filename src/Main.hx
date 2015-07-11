import sys.io.File;

class Main {
	static public function main() {
		Sys.command("cls");
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
			Sys.println('');
		} else {
			Sys.println('No files found');
		}
	}
}