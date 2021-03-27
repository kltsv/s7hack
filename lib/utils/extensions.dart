extension ListX<T> on List<T> {
  T? getSafe(int index) {
    if (index < 0) {
      return null;
    }
    return this.length - 1 >= index ? this[index] : null;
  }
}
