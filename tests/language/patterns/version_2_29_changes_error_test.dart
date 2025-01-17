// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// SharedOptions=--enable-experiment=patterns

// This test captures the changes introduced in 2.29 of the patterns proposal.

import "package:expect/expect.dart";

main() {
  var map = {'a': 1, 'b': 2};

  // It's an error to have "..." in a map pattern.
  switch (map) {
    case {...}:
    //    ^^^
    // [analyzer] unspecified
    // [cfe] unspecified
    case {'a': _, ...}:
    //            ^^^
    // [analyzer] unspecified
    // [cfe] unspecified
  }

  // It's an error to have an empty map pattern.
  switch (map) {
    case {}:
    //   ^^
    // [analyzer] unspecified
    // [cfe] unspecified
  }

  // Later cases may be unreachable because map patterns ignore extra keys.
  switch (map) {
    case {'a': _}:
      print('a');
    case {'b': _}:
      print('b');
    case {'a': _, 'b': _}:
      // ^
      // [analyzer] unspecified
      // [cfe] This case is covered by the previous cases.
      print('a b');
  }
}
