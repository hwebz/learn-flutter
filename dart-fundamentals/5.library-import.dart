// To specify library level
// A really great test library
// @TestOn('browser')
// library;

import 'dart:html';
import 'package:dart_fundamentals/4.metadata.dart';
import 'package:dart_fundamentals/4.metadata.dart' as metadata;

// Import only foo
import 'package:lib1/lib1.dart' show foo;
// Import all names except foo
import 'package:lib1/lib1.dart' hide foo;

// Lazily loading a library
import 'package:greeting/hello.dart' deferred as hello;

Future<void> greet() async {
  await hello.loadLibrary();
  hello.printGreeting();
}
