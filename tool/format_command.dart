import 'package:dart_chassis_forge/chassis_forge.dart' as chassis;
import 'package:smart_arg/smart_arg.dart';

// ignore: unused_import
import 'format_command.reflectable.dart';

const String formatDescription =
    'Formats the various sources and files within the codebase';

@SmartArg.reflectable
@Parser(
  description: 'Formats the various sources and files within the codebase',
)
class FormatCommand extends chassis.ChassisCommand {
  @HelpArgument()
  late bool help = false;

  @override
  Future<void> run(
    final chassis.IShell shell,
    final SmartArg parentArguments,
  ) async {
    await chassis.format(shell);
  }
}
