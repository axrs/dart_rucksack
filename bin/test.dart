import 'dart:io';

import 'package:dart_rucksack/src/shell.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_arg/smart_arg.dart';

// ignore: unused_import
import 'test.reflectable.dart';
import 'utils.dart';

@SmartArg.reflectable
@Parser(description: 'Runs the various Tests against the Codebase')
class TestCommand extends SmartArgCommand {
  @HelpArgument()
  late bool help = false;

  @override
  Future<void> execute(SmartArg parentArguments) async {
    if (help == true) {
      print(usage());
      exit(1);
    }
    var shell = GetIt.instance<IShell>();
    test(shell);
  }
}
