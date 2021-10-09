#!/usr/bin/env bash
set -euo pipefail
if [ ! -d ".dart_tool" ] || [ ! -f "pubspec.lock" ];then
  dart pub get >/dev/null
fi
dart run dart_rucksack.dart
# shellcheck disable=SC2068
dart run bin/main.dart $@
