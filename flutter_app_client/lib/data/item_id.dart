class ItemId {
  final int value;

  const ItemId(this.value);

  @override
  bool operator ==(Object other) {
    if (other is ItemId) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;
}