import 'dart:io';

import 'package:dart_rucksack/rucksack.dart';
import 'package:process_run/shell.dart';
import 'package:smart_arg/smart_arg.dart';

// ignore: unused_import
import 'format.reflectable.dart';
import 'main.dart';

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
    Future<void> runScript(String script) async {
      var run2 = await run(
        script,
        verbose: isVerbose,
      );
      if (!isVerbose) {
        print(run2.outText);
      }
    }

    print('Running Format');
    await runScript('dart format --fix .');
  }
}
