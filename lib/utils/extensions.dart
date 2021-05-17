/// Extends `Iterable` classes functionalities by new methodes.
extension IterableExtension<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }

  bool containsIndex(int index) {
    return this != null &&
        index >= 0 &&
        this.length > index &&
        this.elementAt(index) != null;
  }
}

extension GeneralExtension<T> on T {
  bool isNullOrEmpty() => this == null
      ? true
      : false || (this is String)
          ? this == ""
          : false || (this is Map)
              ? (this as Map).length == 0
              : false || (this is List)
                  ? (this as List).length == 0 || this == null
                  : false;
}
