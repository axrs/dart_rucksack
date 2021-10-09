If(!(test-path ".dart_tool") -Or -not(Test-Path -Path "pubspec.lock" -PathType Leaf))
{
    & 'dart.exe' "pub" "get"
}
& 'dart.exe' "run" "dart_rucksack.dart"
& 'dart.exe' "run" "bin/main.dart" @args
