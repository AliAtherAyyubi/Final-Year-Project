import 'package:e_voting/Services/regExp.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Validation {
  // Cnic Mask  formatter//
  var maskFormatter = MaskTextInputFormatter(
      mask: '#####-#######-#',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  ///
  // validation for name
  String? isValidName(String? value) {
    if (value!.isEmpty) {
      return 'Can\'t be empty';
    } else if (value.length < 3) {
      return 'Name should be at least of 5 characters';
    }
    // else if (!extString(value).isValidName) {
    //   return 'Enter a valid name!';
    // }
    return null;
  }

  String? isValidCnic(String? value) {
    if (value!.isEmpty) {
      return 'Can\'t be empty';
    }
    // else if (value.length < 15) {
    //   return 'Enter a valid CNIC number';
    // } else if (!extString(value).isValidCnic) {
    //   return 'Enter a valid CNIC Number!';
    // }

    return null;
  }

  String? isValidEmail(String? value) {
    if (value!.isEmpty) {
      return 'Can\'t be empty';
    } else if (!value.contains('gmail.com')) {
      return 'Enter a valid email!';
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
