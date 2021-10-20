import 'package:dart_chassis_forge/chassis_forge.dart' as chassis;
import 'package:dart_chassis_forge/chassis_forge_dart.dart' as chassis_dart;
import 'package:smart_arg/smart_arg.dart';

const String depsDescription = 'Installs the projects dependencies';

@SmartArg.reflectable
@Parser(description: depsDescription)
class DepsCommand extends chassis.ChassisCommand {
  @HelpArgument()
  late bool help = false;

  @override
  Future<void> run(
    final chassis.IShell shell,
    final SmartArg parentArguments,
  ) async {
    await chassis_dart.installDependencies(shell);
  }
}
