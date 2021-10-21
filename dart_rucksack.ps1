If(!(test-path '.dart_tool') -Or -not(Test-Path -Path 'pubspec.lock' -PathType Leaf))
{
    & dart.exe pub get | out-null
}
& dart.exe run chassis_forge:build --directory tool | out-null
& dart.exe run tool/entry_command.dart @args
