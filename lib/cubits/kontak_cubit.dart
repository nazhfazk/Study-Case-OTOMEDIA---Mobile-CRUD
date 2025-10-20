import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otomedia_crud/helpers/db_helper.dart';
import 'package:otomedia_crud/models/kontak.dart';
import 'state_kontak.dart';

class KontakCubit extends Cubit<StateKontak> {
  KontakCubit() : super(KontakInitial());

  final KontakDbHelper _dbHelper = KontakDbHelper();

  // Fetch semua kontak
  Future<void> loadKontak() async {
    try {
      emit(KontakLoading());
      final kontaks = await _dbHelper.fetchAllKontak();
      emit(KontakSuccess(kontaks));
    } catch (e) {
      emit(KontakError('Gagal memuat kontak: ${e.toString()}'));
    }
  }

  // Insert kontak baru
  Future<void> addKontak(String nama, String noHP) async {
    try {
      emit(KontakLoading());
      final kontak = Kontak(nama: nama, noHP: noHP);
      await _dbHelper.insertKontakbaru(kontak);
      await loadKontak(); // refresh list
    } catch (e) {
      emit(KontakError('Gagal menambah kontak: ${e.toString()}'));
    }
  }

  // Edit kontak
  Future<void> editKontak(int id, String nama, String noHP) async {
    try {
      emit(KontakLoading());
      final kontak = Kontak(id: id, nama: nama, noHP: noHP);
      await _dbHelper.updateKontak(kontak);
      await loadKontak(); // refresh list
    } catch (e) {
      emit(KontakError('Gagal mengubah kontak: ${e.toString()}'));
    }
  }

  // Hapus kontak
  Future<void> deleteKontak(int id) async {
    try {
      emit(KontakLoading());
      await _dbHelper.deleteKontak(id);
      await loadKontak(); // refresh list
    } catch (e) {
      emit(KontakError('Gagal menghapus kontak: ${e.toString()}'));
    }
  }
}