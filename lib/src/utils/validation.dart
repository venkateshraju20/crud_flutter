class FieldValidator {
  // Log in
  static String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Enter email address";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid email address";
    } else {
      return null;
    }
  }

  static String validatePassword(String value) {
    if (value.length == 0) {
      return 'Enter password';
    }
    return null;
  }

  // Verify log in
  static String validateQuestions(String value) {
    if (value == "Select question") {
      return "Select question";
    }
    return null;
  }

  static String validateAnswers(String value) {
    if (value.length == 0) {
      return "Enter answer";
    }
    return null;
  }

  // Sign up
  static String validateSignupPassword(String value) {
    if (value.length == 0) {
      return 'Enter password';
    } else if (value.length < 8) {
      return 'Password should have at least 8 characters';
    }
    return null;
  }

  static String validateProfileName(String value) {
    String pattern = r'(^[a-zA-Z][a-zA-Z0-9 ]*$)';
    RegExp regExp = RegExp(pattern);
    if (value.length == 0) {
      return "Enter profile name";
    } else if (value.length < 3) {
      return "Profile name should have at least 3 characters";
    } else if (!regExp.hasMatch(value)) {
      return "No whitespace allowed at beginning. \nNo special characters are allowed.";
    }
    return null;
  }

  static String validateMobile(String value) {
    String patttern = r'(^[1-9][0-9]*$)';
    RegExp regExp = RegExp(patttern);
    if (value.length == 0) {
      return "Enter mobile number";
    } else if (value.length != 10) {
      return "Mobile number must be 10 digits";
    } else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits. \nDo not use country codes (+91 or 0).";
    }
    return null;
  }

  static String validateCityResidence(String value) {
    if (value == "City of residence") {
      return "Select your city";
    }
    return null;
  }

  static String validateFirstName(String value) {
    String patttern = r'(^[a-zA-Z][a-zA-Z ]*$)';
    RegExp regExp = RegExp(patttern);
    if (value.length == 0) {
      return "Enter first name";
    } else if (!regExp.hasMatch(value)) {
      return "First name must be alphabets. \nNo whitespace allowed at beginning.";
    } else if (value.length < 3) {
      return "First name should have at least 3 alphabets";
    }
    return null;
  }

  static String validateLastName(String value) {
    String patttern = r'(^[a-zA-Z][a-zA-Z ]*$)';
    RegExp regExp = RegExp(patttern);
    if (value.length == 0) {
      return "Enter last name";
    } else if (!regExp.hasMatch(value)) {
      return "Last name must be alphabets. \nNo whitespace allowed at beginning.";
    } else if (value.length < 3) {
      return "Last name should have at least 3 alphabets";
    }
    return null;
  }

  static String validateAddress(String value) {
    String pattern = "^[a-zA-Z][a-zA-Z0-9\s]*";
    RegExp regExp = RegExp(pattern);
    if (value.length == 0) {
      return "Enter address";
    } else if (value.length < 5) {
      return "Address should have at least 5 alphabets";
    } else if (!regExp.hasMatch(value)) {
      return "Address should not start with special characters.";
    }
    return null;
  }

  static String validateProfession(String value) {
    if (value.length == 0) {
      return "Enter profession";
    }
    return null;
  }

  static String validateAadhaarCard(String value) {
    String patttern = r'(^[2-9][0-9]*$)';
    RegExp regExp = RegExp(patttern);
    if (value.length == 0) {
      return "Enter aadhaar number";
    } else if (value.length != 12) {
      return "Aadhaar number must be 12 digits";
    } else if (!regExp.hasMatch(value)) {
      return "Aadhaar number must be digits. \nIt should not starts with 0 or 1.";
    }
    return null;
  }

  // Verify sign up
  static String validateCode(String value) {
    if (value.length == 0) {
      return "Enter verification code";
    } else if (value.length != 8) {
      return "Verification code must be exactly 8 digit";
    }
    return null;
  }

  // Find advocates
  static String validateCity(String value) {
    if (value == "Select city") {
      return "Select city";
    }
    return null;
  }

  static String validateMessage(String value) {
    String pattern = "^[a-zA-Z][a-zA-Z0-9\s]*";
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Enter description";
    } else if (!regExp.hasMatch(value)) {
      return "No whitespace allowed at beginning.";
    }
    return null;
  }

  // Public questions
  static String validateSummary(String value) {
    if (value.length == 0) {
      return "Enter summary";
    } else if (value.length < 10) {
      return "Summary should have at least 10 characters";
    }
    return null;
  }

  // Edit profile
  static String validateEditCityResidence(String value) {
    String pattern = "^[a-zA-Z][a-zA-Z0-9\s]*";
    RegExp regExp = RegExp(pattern);
    if (value.length == 0) {
      return "Enter city of residence";
    } else if (value.length < 5) {
      return "City of residence should have at least 5 alphabets";
    } else if (!regExp.hasMatch(value)) {
      return "No whitespace allowed at beginning.";
    }
    return null;
  }
}
