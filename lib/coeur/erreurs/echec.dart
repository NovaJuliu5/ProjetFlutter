import 'package:equatable/equatable.dart';

abstract class Echec extends Equatable {
  final String message;
  const Echec(this.message);
  @override
  List<Object> get props => [message];
}

class EchecServeur extends Echec {
  const EchecServeur(String message) : super(message);
}

class EchecReseau extends Echec {
  const EchecReseau() : super('Erreur de connexion internet');
}

class EchecAuthentification extends Echec {
  const EchecAuthentification(String message) : super(message);
}

class EchecLocalisation extends Echec {
  const EchecLocalisation(String message) : super(message);
}