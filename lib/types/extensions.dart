/// Extension methods for [String] to provide additional utilities.
extension StringExtensions on String {
  /// Returns the string with the first character capitalized and the rest in lowercase.
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}
