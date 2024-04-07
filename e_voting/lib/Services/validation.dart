import 'package:e_voting/Services/regExp.dart';

class Validation {
  String? isValidName(String? value) {
    if (value!.isEmpty) {
      return 'Can\'t be empty';
    } else if (!extString(value).isValidName) {
      return 'Enter a valid name!';
    }
    return null;
  }

  String? isValidCnic(String? value) {
    if (value!.isEmpty) {
      return 'Can\'t be empty';
    } else if (!extString(value).isValidNumber) {
      return 'Enter a valid CNIC Number!';
    }
    // else if (!extString(value).isValidEmail) {
    //   return 'Enter a valid password!';
    // }
    return null;
  }

  String? isValidEmail(String? value) {
    if (value!.isEmpty) {
      return 'Can\'t be empty';
    } else if (!extString(value).isValidEmail) {
      return 'Enter a valid email!';
    }
    return null;
  }

  String? isValidPassword(String? value) {
    if (value!.isEmpty) {
      return 'Can\'t be empty';
    } else if (value.length < 6) {
      return 'Password should be at least of 6 characters';
    }
    // else if (!extString(value).isValidEmail) {
    //   return 'Enter a valid password!';
    // }
    return null;
  }
}
