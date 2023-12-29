late String description;

String readThermometer() {
  print('readThermometer is triggering...');
  return '36deg';
}

void main() {
  var name = 'Bob';
  Object name2 = 'Bob';
  String name3 = 'Bob';

  // Null Safety
  String? nameNullable; // Nullable type. Can be `null` or string.
  String
      nameNonNullable; // Non-nullable type. Cannot be `null` but can be string.

  // Default value
  int? lineCount;
  print("lineCount == null = ${lineCount == null}");

  int lineCount2;
  bool weLikeToCount = true;
  if (weLikeToCount) {
    lineCount2 = 2;
  } else {
    lineCount2 = 0;
  }

  print('lineCount2 = $lineCount2');

  // Late variables
  description = 'Feijoada!';
  print('description = $description');

  // This is the program's only call to readThermometer().
  late String temperature = readThermometer(); // Lazily initialized

  // final and const
  // Same: both final and const are immutable
  // Different: 
  // -, const value must be initialized when declared and it should be a constant value (String, int, double, boolean, ...)
  // -, final value can be initialized later but HAVE TO be initialized before used, the value can be returned value from a function call
  final name4 = 'Bob';
  final String nickname = 'Bobby';
  const bar = 1000000;
  const double atm = 1.01325 * bar;
  var foo = const [];
  final bar2 = const [];
  const baz = []; // Equivalent to `const []`
  foo = [1, 2, 3]; // Was const []
  // baz = [42] // Error: Const variables can't be assigned a value.
  const Object i = 3; // Where i is a const Object with an int value...
  const list = [i as int]; // Use a typecase
  const map = {if (i is int) i: 'int'}; // Use is and collection if.
  const set = {if (list is List<int>) ...list}
}
