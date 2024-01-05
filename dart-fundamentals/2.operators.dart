class Person {
  String name;
  int age;

  Person(this.name, this.age);

  @override
  String toString() {
    return "Name: $name, Age: $age";
  }
}

void main() {
  // Arithmetic operators
  print("2 + 3 = ${2 + 3}");
  print("5 - 2 = ${5 - 2}");
  print("5 * 2 = ${5 * 2}");
  print("5 / 2 = ${5 / 2}");
  print("5 ~/ 2 = ${5 ~/ 2}");
  print("5 % 2 = ${5 % 2}");

  int a;
  int b;

  a = 0;
  b = ++a; // Increment a before b gets its value
  print("a = $a, b = $b");

  a = 0;
  b = a++; // Increment a after b gets its value
  print("a = $a, b = $b");

  a = 0;
  b = --a; // Decrement a before b gets its value
  print("a = $a, b = $b");

  a = 0;
  b = a--; // Decrement a after b gets its value
  print("a = $a, b = $b");

  // Equality & Relational operators
  print("2 == 2 = ${2 == 2}");
  print("2 != 3 = ${2 != 3}");
  print("3 > 2 = ${3 > 2}");
  print("3 < 2 = ${3 < 2}");
  print("5 >= 2 = ${5 >= 2}");
  print("5 <= 2 = ${5 <= 2}");

  // Type tests operators
  Object person = Person('John Doe', 30);
  print("person.toString() = ${(person as Person).toString()}");

  if (person is Person) {
    print("person is Person = ${person is Person}");
  }

  if (person is! Object) {
    print("person is! Object = ${person is! Object}");
  }

  // Assignment operators
  double x = 2;
  x *= 3;
  var y;
  y ??= x; // If y = null, assign x to y, else do nothing
  var z = 5;
  print("x = $x, y = $y");
  print("6 *= 2 =  ${x *= 2}");
  print("12 /= 2 = ${x /= 2}");
  print("6 -= 2 = ${x -= 2}");
  print("4 += 2 = ${x += 2}");
  print("6 ~/= 4 = ${y ~/= 4}"); // Take int part of the division
  print("1 >>>= 1 = ${y >>>= 1}");
  print("5 ^= 2 = ${z ^= 2}");
  print("7 &= 2 = ${z &= 2}");
  print("2 |= 1 = ${z |= 0}");
  print("2 >>= 1 = ${z >>= 1}");
  print("1 <<= 1 = ${z <<= 1}");

  // Logical operators
  bool done = false;
  int col = 3;
  if (!done && (col == 1 || col == 3)) {
    print("!done && (col == 1 || col == 3)");
  }

  // Bitwise and shift operators
  final a1 = 0x22;
  final bitmask = 0x0f;

  print("0x22 & 0x0f = 0x02? ${a1 & bitmask == 0x02}");
  print("0x22 & ~0x0f = 0x20? ${a1 & ~bitmask == 0x20}");
  print("0x22 | 0x0f = 0x2f? ${a1 | bitmask == 0x2f}");
  print("0x22 ^ 0x0f = 0x2d? ${a1 ^ bitmask == 0x2d}");

  print("0x22 << 4 = 0x220? ${a1 << 4 == 0x220}");
  print("0x22 >> 4 = 0x02? ${a1 >> 4 == 0x02}");
  print("-0x22 >> 4 = -0x03? ${-a1 >> 4 == -0x03}");

  print("0x22 >>> 4 = 0x02? ${a1 >>> 4 == 0x02}");
  print("-0x22 >>> 4 > 0? ${-a1 >>> 4 > 0}");

  // Conditional expressions
  var isPublic = true;
  var visibility = isPublic ? 'public' : 'private';

  String playerName(String? name) => name ?? 'Guest';

  // Slighly longer version uses ?: operator.
  String playerName2(String? name) => name != null ? name : 'Guest';

  // Very long version uses if-else statement.
  String playerName3(String? name) {
    if (name != null) {
      return name;
    } else {
      return 'Guest';
    }
  }

  // Cascade notation (..)
  var person2 = Person('John Doe', 30)
    ..name = 'Jane Doe'
    ..age = 25;

  print("person2 = $person2");

  // Other operators
  // () for funtion calls
  // [] for accessing elements
  // ?[] left can be null
  // . for accessing members
  // ?. left can be null
  // ! make sure left is non-null (throw exception if null) e.g: foo!.bar
}
