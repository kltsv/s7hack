extension ListX<T> on List<T> {
  T? getSafe(int index) {
    return this.length - 1 >= index ? this[index] : null;
  }
}
