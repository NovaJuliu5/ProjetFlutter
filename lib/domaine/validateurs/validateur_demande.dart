class ValidateurDemande {
  static bool estValide(String titre, String description) {
    return titre.isNotEmpty && description.isNotEmpty;
  }
}