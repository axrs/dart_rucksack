import 'dart:io';

import 'package:dart_rucksack/src/shell.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_arg/smart_arg.dart';

// ignore: unused_import
import 'format.reflectable.dart';
import 'utils.dart';

@SmartArg.reflectable
@Parser(
  description: 'Formats the various sources and files within the codebase',
)
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
    format(shell);
  }
}
