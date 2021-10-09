import 'dart:io';

import 'package:dart_rucksack/src/shell.dart';
import 'package:get_it/get_it.dart';
import 'package:process_run/shell.dart';
import 'package:smart_arg/smart_arg.dart';

// ignore: unused_import
import 'test.reflectable.dart';

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
    print('Building Reflectables');
    await shell.run('dart run build_runner build');
    print('Running Unit Tests...');
    var extraFlags = shell.supportsColorOutput() ? '--color' : '';
    await shell.run('dart test $extraFlags'.trim());
  }
}
