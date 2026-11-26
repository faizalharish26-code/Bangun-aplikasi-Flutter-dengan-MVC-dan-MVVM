import '../data/repositori_tugas.dart';
import '../model/tugas.dart';

class PengendaliTugas {
  PengendaliTugas(this.repo);

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
    if (_galat != null) return false;
    repo.tambah(input.trim());
    return true;
  }

  void ubahStatus(int id) {
    repo.ubahStatus(id);
  }

  void aturFilter(bool nilai) {
    _hanyaBelumSelesai = nilai;
  }
}