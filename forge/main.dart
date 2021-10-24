import 'package:chassis_forge/chassis_forge.dart';
import 'package:smart_arg/smart_arg.dart';

import 'deps.dart';
import 'docs.dart';
import 'format.dart';
import 'lint.dart';

// ignore: unused_import
import 'main.reflectable.dart';
import 'test.dart';

@SmartArg.reflectable
@Parser(
  description: 'Dart Rucksack Project Helper Tools',
)
class Forge extends ChassisForge with HelpOption, VerboseOption {
  @override
  @BooleanArgument(short: 'v', help: 'Enable Command Verbose Mode')
  late bool verbose = false;

  @BooleanArgument(help: 'Enabled Colored Output')
  late bool color = false;

  @Command(help: depsDescription)
  late DepsCommand deps;

  @Command(help: docsDescription)
  late DocsCommand docs;

  @Command(help: lintDescription)
  late LintCommand lint;

  @Command(help: formatDescription)
  late FormatCommand format;

  @Command(help: testDescription)
  late TestCommand test;

  @override
  @HelpArgument()
  late bool help = false;
}

void main(List<String> arguments) {
  initializeReflectable();
  Forge().runWith(arguments);
}
