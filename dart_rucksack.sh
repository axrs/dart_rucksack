#!/usr/bin/env bash
set -euo pipefail
if [ ! -d '.dart_tool' ] || [ ! -f 'pubspec.lock' ];then
  dart pub get >/dev/null
fi
dart run chassis_forge:build --directory tool --main tool/entry_command.dart --executable-target kernel >/dev/null
# shellcheck disable=SC2068
dart run tool/entry_command.dill $@
