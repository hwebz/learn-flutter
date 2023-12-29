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
}
