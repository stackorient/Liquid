// Copyright (c) 2020, the Liquid project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

extension MapExtension<K, V> on Map<K, V> {
  ///returns the value of the item with the specified key.
  ///
  ///if not found will return `d` by default
  V get(K key, [V d]) {
    if (this?.containsKey(key) ?? false) return this[key];
    return d;
  }
}
