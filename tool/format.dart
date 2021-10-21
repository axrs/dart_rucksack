import 'package:chassis_forge/chassis_forge.dart';
import 'package:chassis_forge/chassis_forge_dart.dart';
import 'package:chassis_forge/chassis_forge_markdown.dart';
import 'package:smart_arg/smart_arg.dart';

const String formatDescription =
    'Formats the various sources and files within the codebase';

@SmartArg.reflectable
@Parser(
  description: 'Formats the various sources and files within the codebase',
)
class FormatCommand extends ChassisCommand {
  @override
  @HelpArgument()
  late bool help = false;

  @override
  Future<void> run(
    final IShell shell,
    final SmartArg parentArguments,
  ) async {
    await shell
        .dartFormat() //
        .markdownFormat();
  }
}
