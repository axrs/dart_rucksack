import 'booleans.dart';
import 'objects.dart';

/// True if the provided [ittr] [Iterable] is not null and is [Iterable.isNotEmpty]
///
/// `since 0.0.1`
bool isNotEmpty(final Iterable? ittr) => isNotNull(ittr) && ittr!.isNotEmpty;

/// True if the provided [ittr] [Iterable] is null or [Iterable.isEmpty]
///
/// `since 0.0.1`
bool isEmpty(final Iterable? ittr) => isFalse(isNotEmpty(ittr));
