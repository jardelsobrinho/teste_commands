sealed class Result<T> {
  const Result();

  const factory Result.ok(T value) = Ok._;
  const factory Result.error(String message) = Error._;
  const factory Result.empty() = Empty._;
}

final class Ok<T> extends Result<T> {
  final T value;
  const Ok._(this.value);

  @override
  String toString() => 'Result<$T>.ok($value)';
}

final class Empty<T> extends Result<T> {
  const Empty._();

  @override
  String toString() => 'Result<$T>.empty()';
}

final class Error<T> extends Result<T> {
  final String message;
  const Error._(this.message);
}
