class CommonValidation{
  static String? fieldValidation(String? value){
    if (value == null || value.isEmpty) {
      return "Please enter value";
    }
    return null;
  }
}