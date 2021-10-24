import 'package:chassis_forge/chassis_forge.dart';
import 'package:chassis_forge/chassis_forge_dart.dart';
import 'package:smart_arg/smart_arg.dart';

const String testDescription = 'Runs the various Tests against the Codebase';

@SmartArg.reflectable
@Parser(description: testDescription)
class TestCommand extends ChassisCommand with HelpOption {
  @override
  @HelpArgument()
  late bool help = false;

  @override
  Future<void> run(
    final IShell shell,
    final SmartArg parentArguments,
  ) async {
    await shell.verbose().colored().dartTest();
  }
}
