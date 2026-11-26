import 'package:flutter/material.dart';
import '../data/repositori_tugas.dart';
import '../ui/panel_tugas.dart';
import 'pengendali_tugas.dart';

class LayarMvc extends StatefulWidget {
  const LayarMvc({super.key});

  @override
  State<LayarMvc> createState() => LayarMvcState();
}

class LayarMvcState extends State<LayarMvc> {
  final pengendali = PengendaliTugas(RepositoriTugas());

  bool tambah(String input) {
    final berhasil = pengendali.tambah(input);
    setState(() {});
    return berhasil;
  }

  void ubahStatus(int id) {
    setState(() => pengendali.ubahStatus(id));
  }

  void ubahFilter(bool terpilih) {
    setState(() => pengendali.aturFilter(terpilih));
  }

  @override
  Widget build(BuildContext context) => PanelTugas(
    judul: 'Daftar Tugas MVC',
    daftar: pengendali.daftar,
    totalTugas: pengendali.totalTugas,
    jumlahSelesai: pengendali.jumlahSelesai,
    hanyaBelumSelesai: pengendali.hanyaBelumSelesai,
    galat: pengendali.galat,
    onTambah: tambah,
    onUbahStatus: ubahStatus,
    onUbahFilter: ubahFilter,
  );
}