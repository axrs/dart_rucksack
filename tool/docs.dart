import 'package:chassis_forge/chassis_forge.dart';
import 'package:chassis_forge/chassis_forge_dart.dart';
import 'package:chassis_forge/smart_arg.dart';

const String docsDescription = 'Builds the API documentation';

@SmartArg.reflectable
@Parser(description: docsDescription)
class DocsCommand extends ChassisCommand with HelpOption {
  @override
  @HelpArgument()
  late bool help = false;

  @override
  Future<void> run(
    final IShell shell,
    final SmartArg parentArguments,
  ) async {
    await shell.dartDoc();
  }
}
