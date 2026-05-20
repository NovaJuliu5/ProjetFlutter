class Validateurs {
  static bool estEmailValide(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
  static bool estMotDePasseValide(String password) => password.length >= 6;
  static bool estTelephoneValide(String phone) => phone.length >= 10;
}