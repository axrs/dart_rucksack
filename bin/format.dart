import 'dart:io';

import 'package:dart_rucksack/src/shell.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_arg/smart_arg.dart';

// ignore: unused_import
import 'format.reflectable.dart';

String _remarkConfig = '''
module.exports = {
  frail: true,
  plugins: {
    toc: {
      tight: true
    },
    'remark-gfm': true
  },
  settings: {
    bullet: '*',
    incrementListMarker: false,
    listItemIndent: '1'
  }
} 
''';

Future<void> _formatMarkdown(IShell shell) async {
  print('Formatting Markdown Files');
  print('Installing Remark Tools');
  await shell.run('''
npm install --silent --no-save --no-audit --no-fund \\
  remark-cli \\
  remark-toc \\
  remark-gfm \\
  ccount \\
  mdast-util-find-and-replace
''');
  var remarkRc = File('.remarkrc.js');
  var exists = remarkRc.existsSync();
  if (!exists) {
    print('Creating ${remarkRc.path}');
    remarkRc.createSync();
    remarkRc.writeAsString(_remarkConfig);
  }
  try {
    print('Running Remark');
    await shell.run('npx remark . --output');
  } finally {
    if (!exists) {
      print('Cleaning Up ${remarkRc.path}');
      remarkRc.deleteSync();
    }
  }
}

@SmartArg.reflectable
@Parser(
    description: 'Formats the various sources and files within the codebase')
class FormatCommand extends SmartArgCommand {
  @HelpArgument()
  late bool help = false;

  @override
  Future<void> execute(SmartArg parentArguments) async {
    if (help == true) {
      print(usage());
      exit(1);
    }
    var shell = GetIt.instance<IShell>();
    print('Formatting Dart');
    await shell.run('dart format --fix .');
    await _formatMarkdown(shell);
  }
}
