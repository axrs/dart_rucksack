import 'dart:io';

import 'package:dart_chassis_forge/chassis_forge.dart' as chassis;
import 'package:dart_rucksack/rucksack.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_arg/smart_arg.dart';

// ignore: unused_import
import 'test_command.reflectable.dart';

@SmartArg.reflectable
@Parser(description: 'Runs the various Tests against the Codebase')
class TestCommand extends SmartArgCommand {
  @HelpArgument()
  late bool help = false;

  @override
  Future<void> execute(SmartArg parentArguments) async {
    if (isTrue(help)) {
      print(usage());
      exit(1);
    }
    var shell = GetIt.instance<chassis.IShell>();
    await chassis.test(shell);
  }
}
