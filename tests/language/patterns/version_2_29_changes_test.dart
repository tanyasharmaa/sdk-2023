// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// SharedOptions=--enable-experiment=patterns

// This test captures the changes introduced in 2.29 of the patterns proposal.
import 'dart:collection';

import "package:expect/expect.dart";

main() {
  var map = {'a': 1, 'b': 2};

  // Map patterns are allowed to have identical keys.
  Expect.isTrue(switch (map) { {'a': _, 'a': _} => true, _ => false });

  // Map patterns are allowed to have primitive equal record keys.
  Expect.isTrue(switch ({('c', 'd'): 3}) {
    {('c', 'd'): _, ('c', 'd'): _} => true,
    _ => false
  });

  // Map patterns don't access length.
  Expect.isTrue(
      switch (NoLengthMap(map)) { {'a': _, 'a': _} => true, _ => false });

  // Map patterns match even if there are extra keys.
  Expect.equals(
      'a',
      switch (map) {
        {'a': _} => 'a',
        {'b': _} => 'b',
        {'a': _, 'b': _} => 'a b',
        _ => '???'
      });
}

class NoLengthMap extends MapBase<String, int> {
  final Map<String, int> _inner;

  NoLengthMap(this._inner);

  @override
  int get length => throw UnsupportedError('No length!');

  @override
  int? operator [](Object? key) => _inner[key];

  @override
  void operator []=(String key, int value) => _inner[key] = value;

  @override
  void clear() => _inner.clear();

  @override
  Iterable<String> get keys => _inner.keys;

  @override
  int? remove(Object? key) => _inner.remove(key);
}
