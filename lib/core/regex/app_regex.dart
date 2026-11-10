class AppRegex {
  static final RegExp _email = RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)+$');

  static bool isEmailValid(String value) => _email.hasMatch(value.trim());

  static bool isPasswordValid(String value) => value.length >= 6;
}
