import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dart_rucksack/src/shell.dart';

import './bin/utils.dart';

/// Rebuilds the Reflectables (for command line parsing)
/// This should never need to be called from within the CLI
Future<void> _buildReflectables(IShell shell) async {
  print(
      'Building Reflectables. This only happens when files within `bin` have changed');
  await shell.run('dart run build_runner build --delete-conflicting-outputs');
}

bool _isDartFile(final FileSystemEntity file) {
  return file.path.endsWith('.dart');
}

bool _isReflectable(final FileSystemEntity file) {
  return file.path.endsWith('reflectable.dart');
}

String _rootName(final FileSystemEntity file) {
  return file.path.split(RegExp(r"\.")).first;
}

bool _isModifiedAfter(
  final FileSystemEntity left,
  final FileSystemEntity right,
) {
  return left.statSync().modified.isBefore(right.statSync().modified);
}

void _deleteSync(FileSystemEntity e) {
  e.deleteSync();
}

Future<void> main() async {
  Directory dir = Directory('cli');
  var rebuildRequired = false;
  var files = dir.listSync(recursive: false).where(_isDartFile);
  groupBy(files, _rootName).forEach((key, value) {
    if (value.length != 2 || !_isModifiedAfter(value.first, value.last)) {
      rebuildRequired = true;
    }
  });
  var shell = ProcessRunShell();
  if (!File('pubspec.lock').existsSync()) {
    await installDependencies(shell);
  }
  if (rebuildRequired) {
    files.where(_isReflectable).forEach(_deleteSync);
    await _buildReflectables(shell);
  }
}
