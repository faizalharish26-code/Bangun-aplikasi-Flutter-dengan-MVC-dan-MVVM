import 'package:flutter/foundation.dart';
import '../data/repositori_tugas.dart';
import '../model/tugas.dart';

class TugasViewModel extends ChangeNotifier {
  TugasViewModel(this.repo);

  final RepositoriTugas repo;
  String? _galat;
  bool _hanyaBelumSelesai = false;

  List<Tugas> get _semuaTugas => repo.daftar;

  List<Tugas> get daftar {
    if (_hanyaBelumSelesai) {
      return _semuaTugas.where((tugas) => !tugas.selesai).toList();
    }
    return _semuaTugas;
  }

  int get totalTugas => _semuaTugas.length;
  int get jumlahSelesai => _semuaTugas.where((tugas) => tugas.selesai).length;
  bool get hanyaBelumSelesai => _hanyaBelumSelesai;
  String? get galat => _galat;

  bool tambah(String input) {
    _galat = validasiJudul(input);
    final berhasil = _galat == null;
    if (berhasil) {
      repo.tambah(input.trim());
    }
    notifyListeners();
    return berhasil;
  }

  void ubahStatus(int id) {
    repo.ubahStatus(id);
    notifyListeners();
  }

  void aturFilter(bool nilai) {
    _hanyaBelumSelesai = nilai;
    notifyListeners();
  }
}