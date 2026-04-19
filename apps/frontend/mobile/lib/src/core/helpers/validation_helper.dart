class ValidationHelper {
  static final RegExp _emailRegex = RegExp(
    r"^(?!.*\.\.)[A-Za-z0-9](?:[A-Za-z0-9._%+-]{0,63}[A-Za-z0-9])?@(?:[A-Za-z0-9-]+\.)+[A-Za-z]{2,}$",
  );

  static final RegExp _mobileRegex = RegExp(r'(^[1-9a-zA-Z])');

  static String? validateEmailAddress(String? email) {
    final hasMatched = _emailRegex.hasMatch(email ?? '');
    if (!hasMatched) {
      return 'Please enter a valid Email ID';
    } else {
      return null;
    }
  }

  static String? validateYear(String? input) {
    if (input == null || input.isEmpty) {
      return 'Please enter year';
    } else if (input.length != 4) {
      return 'Please enter valid year';
    } else {
      var year = int.tryParse(input);
      if (year == null) {
        return 'Please enter valid year';
      } else if (year < 1970 || year > DateTime.now().year + 1) {
        return 'Please enter valid year';
      } else {
        return null;
      }
    }
  }

  static String? validateEmpty(String? input, {String? returnText}) {
    if (input == null || input.trim().isEmpty) {
      return returnText ?? 'Please enter detail(s)';
    } else {
      return null;
    }
  }

  static String? validateMobile(String? input, {String? returnText}) {
    if (input == null || input.trim().isEmpty) {
      return returnText ?? 'Please Enter Mobile Number';
    } else if (input.trim().length < 10) {
      return 'At least 10 digits required';
    } else if (!_mobileRegex.hasMatch(input)) {
      return 'Invalid Mobile Number';
    } else {
      return null;
    }
  }

  static String? validatePassword(
    String? value, {
    String? returnText,
    String? confirmPassword,
  }) {
    var regex = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
    );

    if (value?.isEmpty ?? true) {
      return returnText ?? 'Please enter password';
    }

    if (!regex.hasMatch(value ?? '')) {
      return 'Enter valid password';
    }

    if (confirmPassword != null && value != confirmPassword) {
      return "Password does not match";
    }

    return null;
  }
}