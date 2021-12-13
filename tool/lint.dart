import 'package:chassis_forge/chassis_forge.dart';
import 'package:chassis_forge/chassis_forge_dart.dart';
import 'package:chassis_forge/smart_arg.dart';

const String lintDescription =
    'Lints the various sources and files within the codebase';

@SmartArg.reflectable
@Parser(description: lintDescription)
class LintCommand extends ChassisCommand with HelpOption {
  @override
  @HelpArgument()
  late bool help = false;

  @override
  Future<void> run(
    final IShell shell,
    final SmartArg parentArguments,
  ) async {
    await shell.verbose().dartAnalyze();
  }
}
