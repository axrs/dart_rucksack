import 'dart:io';

import 'package:dart_rucksack/src/shell.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_arg/smart_arg.dart';

// ignore: unused_import
import 'lint.reflectable.dart';

@SmartArg.reflectable
@Parser(description: 'Lints the various sources and files within the codebase')
class LintCommand extends SmartArgCommand {
  @HelpArgument()
  late bool help = false;

  @override
  Future<void> execute(SmartArg parentArguments) async {
    if (help == true) {
      print(usage());
      exit(1);
    }
    var shell = GetIt.instance<IShell>();
    print('Running Lint');
    await shell.run('dart analyze');
  }
}
