If(!(test-path '.dart_tool') -Or -not(Test-Path -Path 'pubspec.lock' -PathType Leaf))
{
    & dart.exe pub get | out-null
}
& dart.exe run chassis_forge:build --directory forge | out-null
& dart.exe run forge/main.dart @args
