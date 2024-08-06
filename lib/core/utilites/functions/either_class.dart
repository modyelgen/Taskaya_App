class Either<L, R> {
  final L? _left;
  final R? _right;

  Either._(this._left, this._right);

  bool get isLeft => _left != null;
  bool get isRight => _right != null;

  L? get getLeft => _left;
  R? get getRight => _right;

  static Either<L, R> left<L, R>(L value) => Either<L, R>._(value, null);
  static Either<L, R> right<L, R>(R value) => Either<L, R>._(null, value);
}
