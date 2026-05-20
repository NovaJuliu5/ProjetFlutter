class Environnement {
  static late final String apiUrl;

  static Future<void> init() async {
    // Pour émulateur Android : 'http://10.0.2.2:3000/api'
    // Pour appareil physique : 'http://192.168.1.x:3000/api'
    apiUrl = 'http://10.0.2.2:3000/api'; // à adapter
  }
}