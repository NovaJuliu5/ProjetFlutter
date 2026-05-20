class ValidateurUtilisateur {
  static bool emailValide(String email) => RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
  static bool motDePasseValide(String password) => password.length >= 6;
}