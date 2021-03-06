import 'booleans.dart';
import 'objects.dart';

/// True if the provided [ittr] [Iterable] or [Map] is not null and is [Iterable.isNotEmpty]
///
/// `since 0.0.1`
bool isNotEmpty(final dynamic ittr) {
  if (isNull(ittr)) {
    return false;
  } else if (ittr is Map) {
    return ittr.isNotEmpty;
  } else if (ittr is Iterable) {
    return ittr.isNotEmpty;
  } else {
    return false;
  }
}

/// True if the provided [ittr] [Iterable] or [Map] is null or [Iterable.isEmpty]
///
/// `since 0.0.1`
bool isEmpty(final dynamic ittr) => isFalse(isNotEmpty(ittr));
