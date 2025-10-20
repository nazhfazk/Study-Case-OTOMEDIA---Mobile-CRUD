import 'package:otomedia_crud/models/kontak.dart';

abstract class StateKontak {}

class KontakInitial extends StateKontak {}

class KontakLoading extends StateKontak {}

class KontakSuccess extends StateKontak {
  final List<Kontak> kontakList;

  KontakSuccess(this.kontakList);
}

class KontakError extends StateKontak {
  final String message;

  KontakError(this.message);
}