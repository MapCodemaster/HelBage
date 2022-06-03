class Validation {
  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return "Email Address cannot be empty";
    }
    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
      return 'Please enter a valid Email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "The password cannot be empty";
    }
    if (value.length < 6 || value.length > 20) {
      return 'At least 6 characters and not more than 20 characters';
    }
  }

  String? validateForEmpty(String? value) {
    if (value!.isEmpty) {
      return "This field cannot be empty";
    }
  }
  String? validateDateTime(dynamic? value)
  {
    print(value);
    if(value==null)
    {
      return "This field cannot be empty";
    }
  }

  String? validatePostcode(String? value) {
    if (value!.isEmpty) {
      return "The postcode cannot be empty";
    }
    if (!RegExp("^[0-9]").hasMatch(value)) {
      return 'Please enter a valid Postcode';
    }
    return null;
  }

  String? validatePhoneNo(String? value) {
    if (value!.isEmpty) {
      return "The phone no cannot be empty";
    }
    if (!RegExp("^01([0-9]){1}-([0-9]){7,8}").hasMatch(value)) {
      return 'Please enter a valid phone no';
    }
    return null;
  }
  String? validateNumOnly(String? value) {
    if (value!.isEmpty) {
      return "The phone no cannot be empty";
    }
    if (!RegExp("^[0-9]+").hasMatch(value)) {
      return 'number only';
    }
    return null;
  }

  String? validateHomeNo(String? value) {
    if (value!.isEmpty) {
      return "The phone no cannot be empty";
    }
    if (!RegExp('(^0+[0-9]){1,2}-([0-9]){6,8}').hasMatch(value)) {
      return 'Please enter a valid home no';
    }
    return null;
  }
}
