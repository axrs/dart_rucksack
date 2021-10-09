import 'dart:io';

import 'package:dart_rucksack/rucksack.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_arg/smart_arg.dart';

import 'format.dart';
import 'lint.dart';

// ignore: unused_import
import 'main.reflectable.dart';
import 'test.dart';

@SmartArg.reflectable
@Parser(
  description: 'dart_rucksack Project Helper Tools',
)
class Args extends SmartArg {
  @BooleanArgument(short: 'v', help: 'Enable Command Verbose Mode')
  late bool verbose = false;

  @BooleanArgument(help: 'Enabled Colored Output')
  late bool color = false;

  @Command(help: 'Lints the codebase')
  late LintCommand lint;

  @Command(help: 'Formats the codebase, modifying files.')
  late FormatCommand format;

  @Command(help: 'Runs the codebase tests')
  late TestCommand test;

  @HelpArgument()
  late bool help = false;

  late bool commandRun = false;

  @override
  void beforeCommandExecute(SmartArgCommand command) {
    super.beforeCommandExecute(command);
    GetIt.instance
        .registerLazySingleton<IShell>(() => ProcessRunShell(verbose: verbose));
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
