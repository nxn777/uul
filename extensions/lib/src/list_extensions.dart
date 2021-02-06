extension MapIndexed<T> on List<T> {
  List<R> mapIndexed<R>(R Function(T value, int index) callback) {
    List<R> result = [];
    for (int i = 0; i < this.length; i++) {
      R item = callback(this[i], i);
      result.add(item);
    }
    return result;
  }
}
