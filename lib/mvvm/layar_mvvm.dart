import 'package:flutter/material.dart';
import '../data/repositori_tugas.dart';
import '../ui/panel_tugas.dart';
import 'tugas_view_model.dart';

class LayarMvvm extends StatefulWidget {
  const LayarMvvm({super.key});

  @override
  State<LayarMvvm> createState() => LayarMvvmState();
}

class LayarMvvmState extends State<LayarMvvm> {
  final viewModel = TugasViewModel(RepositoriTugas());

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: viewModel,
    builder: (context, child) => PanelTugas(
      judul: 'Daftar Tugas MVVM',
      daftar: viewModel.daftar,
      totalTugas: viewModel.totalTugas,
      jumlahSelesai: viewModel.jumlahSelesai,
      hanyaBelumSelesai: viewModel.hanyaBelumSelesai,
      galat: viewModel.galat,
      onTambah: viewModel.tambah,
      onUbahStatus: viewModel.ubahStatus,
      onUbahFilter: viewModel.aturFilter,
    ),
  );
}