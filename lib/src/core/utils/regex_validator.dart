class RegexValidator {
  RegexValidator._();

  static final email = RegExp(r"^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$");
  static final password = RegExp(r"^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+$");
}
