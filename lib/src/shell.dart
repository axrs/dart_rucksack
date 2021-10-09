import 'dart:io';

import 'package:dart_rucksack/src/objects.dart';
import 'package:dart_rucksack/src/strings.dart';
import 'package:process_run/shell.dart' as pr;
// ignore: implementation_imports
import 'package:process_run/src/shell_utils.dart' show scriptToCommands;

/// A marker interface representing a basic Shell to run and evaluate commands
///
/// {@since 0.0.1}
abstract class IShell {
  /// True if the shell implementation supports color output
  ///
  /// {@since 0.0.1}
  bool supportsColorOutput();

  /// Runs a command within a IShell environment. Returning the commands
  /// result.
  /// May throw [CommandException]s.
  ///
  /// {@since 0.0.1}
  Future<ProcessResult> run(String command);

  /// Returns the full path location (and name) for a supplied command.
  /// Null if the command was not found.
  ///
  /// {@since 0.0.1}
  String? which(String command);

  /// Returns true if the external command exists
  ///
  /// {@since 0.0.1}
  bool hasCommand(String command);
}

/// A marker interface implemented by all Command Execution exceptions
///
/// An [CommandException] is intended to convey information to the user about a
/// failure, in running external process commands which can be caught at the
/// developers discretion. They should contain useful data fields.
///
/// {@since 0.0.1}
class CommandException implements Exception {}

/// Exception thrown when multiple commands to be run have been detected
///
/// {@since 0.0.1}
class MultipleScriptCommandException implements CommandException {
  final String cause;
  final String script;

  MultipleScriptCommandException(this.cause, this.script);

  @override
  String toString() {
    return 'MultipleScriptCommandException: $cause\n$script';
  }
}

/// Exception thrown when no commands to run have been detected
///
/// {@since 0.0.1}
class BlankCommandException implements CommandException {
  BlankCommandException();

  @override
  String toString() {
    return 'BlankCommandException: Empty, or blank command script provided';
  }
}

void _requireCommand(String command) {
  if (isBlank(command)) {
    throw BlankCommandException();
  }
}

void _requireSingleCommand(String command) {
  _requireCommand(command);
  var commandCount = scriptToCommands(command).length;
  if (commandCount != 1) {
    throw MultipleScriptCommandException(
      'Found $commandCount commands to run in script.',
      command,
    );
  }
}

/// A Basic implementation of [IShell] using [package:process_run]
///
/// {@since 0.0.1}
class ProcessRunShell implements IShell {
  final bool verbose;
  final bool color;

  ProcessRunShell({
    this.verbose = false,
    this.color = false,
  });

  @override
  Future<ProcessResult> run(String script) async {
    _requireSingleCommand(script);
    var result = await pr.run(
      script,
      verbose: verbose,
    );
    return result.first;
  }

  @override
  String? which(String cmd) {
    _requireSingleCommand(cmd);
    return pr.whichSync(cmd);
  }

  @override
  bool hasCommand(String command) {
    return isNotNull(which(command));
  }

  @override
  bool supportsColorOutput() {
    return color;
  }
}
