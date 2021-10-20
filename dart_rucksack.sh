#!/usr/bin/env bash
set -euo pipefail
if [ ! -d '.dart_tool' ] || [ ! -f 'pubspec.lock' ];then
  dart pub get >/dev/null
fi
dart run dart_chassis_forge:build tool >/dev/null
# shellcheck disable=SC2068
dart run tool/entry_command.dart $@
