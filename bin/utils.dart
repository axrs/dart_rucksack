import 'dart:io';

import 'package:dart_rucksack/rucksack.dart';

/// Installes the project dependencies
Future<void> installDependencies(IShell shell) async {
  print('Downloading Dependencies');
  await shell.run('dart pub get');
}

/// Lints the codebase
Future<void> lint(IShell shell) async {
  print('Running Lint');
  await shell.run('dart analyze');
}

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

/// Formats the codebase
Future<void> format(IShell shell) async {
  print('Formatting Dart');
  await shell.run('dart format --fix .');
  await _formatMarkdown(shell);
}

/// Tests the code base
Future<void> test(IShell shell) async {
  print('Running Unit Tests...');
  var extraFlags = shell.supportsColorOutput() ? '--color' : '';
  await shell.run('dart test $extraFlags'.trim());
}
