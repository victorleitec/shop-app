class AuthException implements Exception {
  AuthException(this.key);
  static const Map<String, String> errors = {
    "EMAIL_EXISTS": "This email address is already in use.",
    "OPERATION_NOT_ALLOWED": "Operation not allowed.",
    "TOO_MANY_ATTEMPTS_TRY_LATER":
        "We have blocked all requests from this device due to unusual activity. Try again later.",
    "EMAIL_NOT_FOUND":
        "There is no user record corresponding to this identifier.",
    "INVALID_PASSWORD": "The password is invalid.",
    "USER_DISABLED": "The user account has been disabled.",
    "USER_NOT_FOUND":
        "There is no user record corresponding to this identifier.",
    "WEAK_PASSWORD": "The password must be 6 characters long or more.",
    "INVALID_EMAIL": "The email address is badly formatted.",
  };

  final String key;

  @override
  String toString() {
    return errors[key] ?? "An error occurred in the authentication process.";
  }
}
