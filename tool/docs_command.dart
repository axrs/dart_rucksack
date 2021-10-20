import 'package:dart_chassis_forge/chassis_forge.dart' as chassis;
import 'package:dart_chassis_forge/chassis_forge_dart.dart' as chassis_dart;
import 'package:smart_arg/smart_arg.dart';

const String docsDescription = 'Builds the API documentation';

@SmartArg.reflectable
@Parser(description: docsDescription)
class DocsCommand extends chassis.ChassisCommand {
  @HelpArgument()
  late bool help = false;

  @override
  Future<void> run(
    final chassis.IShell shell,
    final SmartArg parentArguments,
  ) async {
    await chassis_dart.doc(shell);
  }
}
