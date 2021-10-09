import 'dart:io';

import 'package:smart_arg/smart_arg.dart';

import 'format.dart';
import 'lint.dart';
// ignore: unused_import
import 'main.reflectable.dart';

@SmartArg.reflectable
@Parser(
  description: 'Example using commands',
  extendedHelp: [
    ExtendedHelp('This is some text below the command listing',
        header: 'EXTENDED HELP')
  ],
)
class Args extends SmartArg {
  @BooleanArgument(short: 'v', help: 'Verbose mode')
  late bool verbose = false;

  @Command()
  late LintCommand lint;

  @Command()
  late FormatCommand format;

  @HelpArgument()
  late bool help = false;
}

void main(List<String> arguments) {
  initializeReflectable();

  var args = Args()..parse(arguments);

  if (args.help == true) {
    print(args.usage());
    exit(1);
  }
}
