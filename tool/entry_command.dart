import 'dart:io';

import 'package:dart_chassis_forge/chassis_forge.dart';
import 'package:dart_rucksack/rucksack.dart';
import 'package:smart_arg/smart_arg.dart';

// ignore: unused_import
import 'entry_command.reflectable.dart';
import 'deps_command.dart';
import 'docs_command.dart';
import 'format_command.dart';
import 'lint_command.dart';
import 'test_command.dart';

@SmartArg.reflectable
@Parser(
  description: 'Dart Rucksack Project Helper Tools',
)
class Args extends SmartArg {
  @BooleanArgument(short: 'v', help: 'Enable Command Verbose Mode')
  late bool verbose = false;

  @BooleanArgument(help: 'Enabled Colored Output')
  late bool color = false;

  @Command(help: depsDescription)
  late DepsCommand deps;

  @Command(help: docsDescription)
  late DocsCommand docs;

  @Command(help: lintDescription)
  late LintCommand lint;

  @Command(help: formatDescription)
  late FormatCommand format;

  @Command(help: testDescription)
  late TestCommand test;

  @HelpArgument()
  late bool help = false;

  late bool commandRun = false;

  @override
  void beforeCommandExecute(SmartArgCommand command) {
    configureLogger(verbose);
    registerDefaultShell(verbose);
    super.beforeCommandExecute(command);
  }

  @override
  void afterCommandExecute(SmartArgCommand command) {
    super.afterCommandExecute(command);
    commandRun = true;
  }
}

void _printUsageAndExit(Args args) {
  print(args.usage());
  exit(1);
}

void main(List<String> arguments) {
  initializeReflectable();
  var args = Args()..parse(arguments);
  if (isTrue(args.help) || isFalse(args.commandRun)) {
    _printUsageAndExit(args);
  }
}
