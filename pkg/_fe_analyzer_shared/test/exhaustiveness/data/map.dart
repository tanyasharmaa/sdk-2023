// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

untypedMap(Map map) {
  var a = /*type=Map<dynamic, dynamic>*/ switch (map) {
    {} /*space={}*/ => 0,
    {1: _} /*space={1: ()}*/ => 1,
    {1: _, 2: _} /*space={1: (), 2: ()}*/ => 2,
    Map() /*space={...}*/ => 3,
  };
  var b = /*type=Map<dynamic, dynamic>*/ switch (map) {
    Map() /*space={...}*/ => 0,
  };
}

sealed class A {}

class B extends A {}

class C extends A {}

typedMap(Map<int, A> map) {
  var a = /*
   error=non-exhaustive:Map<int, A>(),
   type=Map<int, A>
  */
      switch (map) {
    {} /*space={}*/ => 0,
    {0: B b} /*space={0: B}*/ => 1,
    {0: C c} /*space={0: C}*/ => 2,
    {0: _, 1: _} /*space={0: A, 1: A}*/ => 3,
    {0: B b} /*space={0: B, ...}*/ => 4,
    {0: C c} /*space={0: C, ...}*/ => 5,
  };

  var b = /*type=Map<int, A>*/ switch (map) {
    {...} /*space={...}*/ => 0,
  };
  var c = /*
   error=non-exhaustive:Map<int, A>(),
   type=Map<int, A>
  */
      switch (map) {
    Map<int, B>() /*space=<int, B>{...}*/ => 0,
  };
  var d = /*type=Map<int, B>*/ switch (map) {
    Map() /*space={...}*/ => 0,
    {1: _} /*
     error=unreachable,
     space={1: B}
    */
      =>
      1,
    {2: _} /*
     error=unreachable,
     space={2: B, ...}
    */
      =>
      2,
  };
}

exhaustiveRestOnly(Map o) {
  return /*type=Map<dynamic, dynamic>*/ switch (o) {
    Map() /*space={...}*/ => 0,
  };
}

unreachableAfterRestOnly(Map o) {
  return /*type=Map<dynamic, dynamic>*/ switch (o) {
    Map() /*space={...}*/ => 0,
    {0: _} /*
     error=unreachable,
     space={0: ()}
    */
      =>
      1,
  };
}

unreachableAfterRestOnlyTyped(Map o) {
  return /*type=Map<dynamic, dynamic>*/ switch (o) {
    Map() /*space={...}*/ => 0,
    <int, String>{
      0: _
    } /*
     error=unreachable,
     space=<int, String>{0: String}
    */
      =>
      1,
  };
}

unreachableAfterRestOnlyEmpty(Map o) {
  return /*type=Map<dynamic, dynamic>*/ switch (o) {
    Map() /*space={...}*/ => 0,
    {} /*
     error=unreachable,
     space={}
    */
      =>
      1,
  };
}

unreachableAfterRestSameKeys(Map o) {
  return /*type=Map<dynamic, dynamic>*/ switch (o) {
    {0: _} /*space={0: (), ...}*/ => 0,
    {0: _} /*
     error=unreachable,
     space={0: ()}
    */
      =>
      1,
    Map() /*space={...}*/ => 2,
  };
}

nonExhaustiveAfterRestSameKeys(Map o) {
  return /*
   error=non-exhaustive:Map<dynamic, dynamic>(),
   type=Map<dynamic, dynamic>
  */
      switch (o) {
    {0: _} /*space={0: (), ...}*/ => 0,
    {0: _} /*
     error=unreachable,
     space={0: ()}
    */
      =>
      1,
  };
}

unreachableAfterRestMoreKeys(Map o) {
  return /*type=Map<dynamic, dynamic>*/ switch (o) {
    {0: _} /*space={0: (), ...}*/ => 0,
    {
      0: _,
      1: _
    } /*
       error=unreachable,
       space={0: (), 1: ()}
      */
      =>
      1,
    Map() /*space={...}*/ => 2,
  };
}

nonExhaustiveAfterRestMoreKeys(Map o) {
  return /*
   error=non-exhaustive:Map<dynamic, dynamic>(),
   type=Map<dynamic, dynamic>
  */
      switch (o) {
    {0: _} /*space={0: (), ...}*/ => 0,
    {0: _, 1: _} /*
     error=unreachable,
     space={0: (), 1: ()}
    */
      =>
      1,
  };
}

unreachableAfterSameKeys(Map o) {
  return /*type=Map<dynamic, dynamic>*/ switch (o) {
    {0: _} /*space={0: ()}*/ => 0,
    {0: 1} /*
     error=unreachable,
     space={0: 1}
    */
      =>
      1,
    Map() /*space={...}*/ => 2,
  };
}

nonExhaustiveAfterSameKeys(Map o) {
  return /*
   error=non-exhaustive:Map<dynamic, dynamic>(),
   type=Map<dynamic, dynamic>
  */
      switch (o) {
    {0: _} /*space={0: ()}*/ => 0,
    {0: 1} /*
     error=unreachable,
     space={0: 1}
    */
      =>
      1,
  };
}

reachableAfterRestOnlyDifferentTypes(Map o) {
  return /*type=Map<dynamic, dynamic>*/ switch (o) {
    <int, String>{...} /*space=<int, String>{...}*/ => 0,
    <int, bool>{0: _} /*space=<int, bool>{0: bool}*/ => 1,
    Map() /*space={...}*/ => 2,
  };
}

nonExhaustiveAfterRestOnlyDifferentTypes(Map o) {
  return /*
   error=non-exhaustive:Map<dynamic, dynamic>(),
   type=Map<dynamic, dynamic>
  */
      switch (o) {
    Map<int, String>() /*space=<int, String>{...}*/ => 0,
    <int, bool>{0: _} /*space=<int, bool>{0: bool}*/ => 1,
  };
}

reachableAfterRestOnlyEmptyDifferentTypes(Map o) {
  return /*type=Map<dynamic, dynamic>*/ switch (o) {
    <int, String>{...} /*space=<int, String>{...}*/ => 0,
    <int, bool>{} /*space=<int, bool>{}*/ => 1,
    Map() /*space={...}*/ => 2,
  };
}

nonExhaustiveAfterRestOnlyEmptyDifferentTypes(Map o) {
  return /*
   error=non-exhaustive:Map<dynamic, dynamic>(),
   type=Map<dynamic, dynamic>
  */
      switch (o) {
    Map<int, String>() /*space=<int, String>{...}*/ => 0,
    <int, bool>{} /*space=<int, bool>{}*/ => 1,
  };
}

reachableAfterRestDifferentTypes(Map o) {
  return /*type=Map<dynamic, dynamic>*/ switch (o) {
    <int, String>{0: _} /*space=<int, String>{0: String, ...}*/ => 0,
    <int, bool>{0: _} /*space=<int, bool>{0: bool}*/ => 1,
    Map() /*space={...}*/ => 2,
  };
}

nonExhaustiveAfterRestDifferentTypes(Map o) {
  return /*type=Map<dynamic, dynamic>*/ switch (o) {
    <int, String>{0: _} /*space=<int, String>{0: String, ...}*/ => 0,
    <int, bool>{0: _} /*space=<int, bool>{0: bool}*/ => 1,
    Map() /*space={...}*/ => 2,
  };
}

reachableAfterRestDifferentKeys(Map o) {
  return /*type=Map<dynamic, dynamic>*/ switch (o) {
    {0: _} /*space={0: (), ...}*/ => 0,
    {1: _} /*space={1: ()}*/ => 1,
    Map() /*space={...}*/ => 2,
  };
}

nonExhaustiveAfterRestDifferentKeys(Map o) {
  return /*
   error=non-exhaustive:Map<dynamic, dynamic>(),
   type=Map<dynamic, dynamic>
  */
      switch (o) {
    {0: _} /*space={0: (), ...}*/ => 0,
    {1: _} /*space={1: ()}*/ => 1,
  };
}

reachableAfterDifferentKeys(Map o) {
  return /*type=Map<dynamic, dynamic>*/ switch (o) {
    {0: _} /*space={0: ()}*/ => 0,
    {1: _} /*space={1: ()}*/ => 1,
    Map() /*space={...}*/ => 2,
  };
}

nonExhaustiveAfterDifferentKeys(Map o) {
  return /*
   error=non-exhaustive:Map<dynamic, dynamic>(),
   type=Map<dynamic, dynamic>
  */
      switch (o) {
    {0: _} /*space={0: ()}*/ => 0,
    {1: _} /*space={1: ()}*/ => 1,
  };
}

reachableAfterDifferentTypes(Map o) {
  return /*type=Map<dynamic, dynamic>*/ switch (o) {
    <int, String>{0: _} /*space=<int, String>{0: String}*/ => 0,
    <int, bool>{0: _} /*space=<int, bool>{0: bool}*/ => 1,
    Map() /*space={...}*/ => 2,
  };
}

nonExhaustiveAfterDifferentTypes(Map o) {
  return /*
   error=non-exhaustive:Map<dynamic, dynamic>(),
   type=Map<dynamic, dynamic>
  */
      switch (o) {
    <int, String>{0: _} /*space=<int, String>{0: String}*/ => 0,
    <int, bool>{0: _} /*space=<int, bool>{0: bool}*/ => 1,
  };
}
