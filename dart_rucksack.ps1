If(!(test-path '.dart_tool') -Or -not(Test-Path -Path 'pubspec.lock' -PathType Leaf))
{
    & 'dart.exe' 'pub' 'get'
}
& 'dart.exe' 'run' 'dart_chassis_forge:build'
& 'dart.exe' 'run' 'tool/entry_command.dart' @args
