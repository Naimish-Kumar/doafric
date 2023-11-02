class AppValidator {
  static String? emailValidator(String? value) {
    if (value!.isEmpty) {
      return "Please enter email address  ";
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value.trim())) {
      return "Please submit a valid e-mail address";
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return "Please enter your password";
    } else if (value.length < 7) {
      return "password must be at least 7 characters long";
    }
    return null;
  }

  static String? confirm_passwordValidator(String? value) {
    if (value!.isEmpty) {
      return "Please enter confirm password ";
    } else if (value.length < 5) {
      return "Password must be the same";
    }
    return null;
  }

  static String? nameValidator(String? value) {
    if (value!.isEmpty) {
      return "Please enter your first name ";
    } else if (value.length < 3) {
      return "Please enter at least 3 characters long";
    }
    return null;
  }

  static String? lastnameValidator(String? value) {
    if (value!.isEmpty) {
      return "Please enter your last name";
    } else if (value.length < 3) {
      return "Please enter at least 3 characters long";
    }
    return null;
  }

  static String? mobileValidator(String? value) {
    if (value!.isEmpty) {
      return "Please enter phone number ";
    } else if (value.length < 10) {
      return "Enter a valid phone number";
    }
    return null;
  }

  static String? currentpasswordValidator(String? value) {
    if (value!.isEmpty) {
      return "Please enter your current password";
    } else if (value.length < 5) {
      return "Password must be the same";
    }
    return null;
  }

  static String? verifycodeValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your verification code';
    }
    if (value.trim().length < 4) {
      return 'Varification code must be atleast 4 characters';
    }
    return null;
  }

  static String? emptyValidator(String? value) {
    if (value!.isEmpty) {
      return "Please enter some text ";
    }
    return null;
  }
}
