class ValidationUtils {
  ValidationUtils._();

  static bool isSuccessResponse(int statusCode) =>
      statusCode > 199 && statusCode < 300;

  static bool isEmail(String email) {
    String passwordValidationRule =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(passwordValidationRule);
    return regExp.hasMatch(email);
  }

  static bool isValidString(String value) {
    return (value.trim().isNotEmpty);
  }

  static bool isValid(String value, String regex) {
    if (value.isNotEmpty) {
      //print("regex $regex");
      RegExp regExp = RegExp(regex);
      return regExp.hasMatch(value);
    } else {
      return false;
    }
  }
}
