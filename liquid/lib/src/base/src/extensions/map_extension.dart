extension MapExtension<K, V> on Map<K, V> {
  ///returns the value of the item with the specified key.
  ///
  ///if not found will return `d` by default
  V get(K key, [V d]) {
    if (this?.containsKey(key) ?? false) return this[key];
    return d;
  }
}
