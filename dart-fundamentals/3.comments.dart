void main() {
  // TODO: Print some messages
  print("Hello, World!");

  /**
   * Print the name the passed in, if null print 'John Doe'
   * @param name The name to print
   * @return The name to print with fallback value
   * @example
   *  printName('John Doe'); // John Doe
   */
  String printName(String? name) => name ?? 'John Doe';

  ///
  /// Print the name and age of a person
  ///
  /// @param name The name of the person
  /// @param age The age of the person
  /// @return The name and age of the person
  /// @example
  ///   printNameAge('John Doe', 18); // John Doe, 18
  ///
  String printNameAge(String? name, int? age) =>
      '${name ?? 'John Doe'}, ${age ?? 18}';
}
