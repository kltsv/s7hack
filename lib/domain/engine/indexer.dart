class ItemIndexer {

  int _itemsIdsCounter = 0;

  int getAndIncrement() {
    int temp = _itemsIdsCounter;
    _itemsIdsCounter++;
    return temp;
  }
}
