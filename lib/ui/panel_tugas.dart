import 'package:flutter/material.dart';
import '../model/tugas.dart';

class PanelTugas extends StatelessWidget {
  const PanelTugas({
    super.key,
    required this.judul,
    required this.daftar,
    required this.totalTugas,
    required this.jumlahSelesai,
    required this.hanyaBelumSelesai,
    required this.galat,
    required this.onTambah,
    required this.onUbahStatus,
    required this.onUbahFilter,
  });

  final String judul;
  final List<Tugas> daftar;
  final int totalTugas;
  final int jumlahSelesai;
  final bool hanyaBelumSelesai;
  final String? galat;
  final bool Function(String input) onTambah;
  final void Function(int id) onUbahStatus;
  final void Function(bool selected) onUbahFilter;

  static const _teal = Color(0xFF006D6B);
  static const _chipAktifBg = Color(0xFFD5ECEB);
  static const _garisTipis = Color(0xFFE5E7EB);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    void kirim() {
      final berhasil = onTambah(controller.text);
      if (berhasil) {
        controller.clear();
      }
    }

    String pesanKosong() {
      if (totalTugas == 0) {
        return 'Belum ada tugas.';
      }
      if (hanyaBelumSelesai && daftar.isEmpty) {
        return 'Tidak ada tugas yang belum selesai.';
      }
      return 'Belum ada tugas.';
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          judul,
          style: const TextStyle(
            color: Color(0xFF111827),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                key: const ValueKey('judul-tugas'),
                controller: controller,
                decoration: InputDecoration(
                  labelText: 'Judul tugas',
                  labelStyle: const TextStyle(color: _teal, fontSize: 13),
                  floatingLabelStyle: const TextStyle(
                    color: _teal,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  hintText: 'Contoh: Rancang UI Flutter',
                  hintStyle: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 15,
                  ),
                  errorText: galat,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 14,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: _teal, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: _teal, width: 1.8),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: Colors.red, width: 1.4),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: Colors.red, width: 1.8),
                  ),
                ),
                onSubmitted: (_) => kirim(),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: _teal,
                    foregroundColor: Colors.white,
                    shape: const StadiumBorder(),
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: kirim,
                  child: const Text('Tambah tugas'),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                '$jumlahSelesai dari $totalTugas selesai',
                style: const TextStyle(
                  color: Color(0xFF111827),
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              FilterChip(
                key: const ValueKey('filter-belum-selesai'),
                label: const Text('Belum selesai'),
                selected: hanyaBelumSelesai,
                onSelected: onUbahFilter,
                showCheckmark: true,
                checkmarkColor: const Color(0xFF111827),
                selectedColor: _chipAktifBg,
                backgroundColor: Colors.white,
                labelStyle: TextStyle(
                  color: hanyaBelumSelesai
                      ? const Color(0xFF111827)
                      : const Color(0xFF4B5563),
                  fontSize: 13,
                  fontWeight:
                  hanyaBelumSelesai ? FontWeight.w500 : FontWeight.w400,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    color: hanyaBelumSelesai
                        ? _chipAktifBg
                        : const Color(0xFFD1D5DB),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Divider(height: 1, thickness: 1, color: _garisTipis),
              const SizedBox(height: 6),
              Expanded(
                child: daftar.isEmpty
                    ? Center(
                  child: Text(
                    pesanKosong(),
                    style: const TextStyle(
                      color: Color(0xFF4B5563),
                      fontSize: 14,
                    ),
                  ),
                )
                    : ListView.builder(
                  itemCount: daftar.length,
                  itemBuilder: (context, index) {
                    final tugas = daftar[index];
                    return CheckboxListTile(
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 4),
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: _teal,
                      checkColor: Colors.white,
                      checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      side: const BorderSide(
                        color: Color(0xFF4B5563),
                        width: 1.5,
                      ),
                      title: Text(
                        tugas.judul,
                        style: const TextStyle(
                          color: Color(0xFF111827),
                          fontSize: 15,
                        ),
                      ),
                      value: tugas.selesai,
                      onChanged: (_) => onUbahStatus(tugas.id),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}