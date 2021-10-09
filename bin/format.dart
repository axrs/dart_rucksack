import 'dart:io';

import 'package:dart_rucksack/rucksack.dart';
import 'package:process_run/shell.dart';
import 'package:smart_arg/smart_arg.dart';

// ignore: unused_import
import 'format.reflectable.dart';
import 'main.dart';

Future<List<ProcessResult>> runScript(
  String script, {
  bool verbose = false,
}) async {
  var result = await run(
    script,
    verbose: verbose,
  );
  return result;
}

Future<void> formatMarkdown(bool isVerbose) async {
  print('Formatting Markdown Files');
  print('Installing Remark Tools');
  await runScript('''
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
    remarkRc.writeAsString('''
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
''');
  }
  try {
    print('Running Remark');
    await runScript('npx remark . --output');
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
    var isVerbose = cast<Args>(parentArguments)?.verbose ?? false;
    print('Running Format');
    await runScript('dart format --fix .', verbose: isVerbose);
    await formatMarkdown(isVerbose);
  }
}
