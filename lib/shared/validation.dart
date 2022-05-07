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
}
