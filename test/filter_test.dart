import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prak_arsitektur_tugas/main.dart';

void main() {
  for (final mode in ['MVC', 'MVVM']) {
    testWidgets('$mode menyaring tugas belum selesai dan memperbarui ringkasan',
            (tester) async {
          const tugasPertama = 'Rancang UI Flutter';
          const tugasKedua = 'Catat hasil pengujian';

          await tester.pumpWidget(const AplikasiTugas());
          await tester.tap(find.text('Buka $mode'));
          await tester.pumpAndSettle();

          final input = find.byKey(const ValueKey('judul-tugas'));
          final tombolTambah = find.text('Tambah tugas');
          final chipFilter = find.byKey(const ValueKey('filter-belum-selesai'));

          // 1. Tambahkan dua tugas, lalu centang tugas pertama.
          await tester.enterText(input, tugasPertama);
          await tester.tap(tombolTambah);
          await tester.pumpAndSettle();

          await tester.enterText(input, tugasKedua);
          await tester.tap(tombolTambah);
          await tester.pumpAndSettle();

          await tester.tap(find.byType(CheckboxListTile).first);
          await tester.pumpAndSettle();

          expect(find.text(tugasPertama), findsOneWidget);
          expect(find.text(tugasKedua), findsOneWidget);
          expect(find.text('1 dari 2 selesai'), findsOneWidget);

          // 2. Aktifkan filter.
          await tester.tap(chipFilter);
          await tester.pumpAndSettle();

          expect(find.text(tugasPertama), findsNothing);
          expect(find.text(tugasKedua), findsOneWidget);
          expect(find.text('1 dari 2 selesai'), findsOneWidget);

          // 3. Matikan filter.
          await tester.tap(chipFilter);
          await tester.pumpAndSettle();

          expect(find.text(tugasPertama), findsOneWidget);
          expect(find.text(tugasKedua), findsOneWidget);

          final tilePertama = tester.widget<CheckboxListTile>(
            find.widgetWithText(CheckboxListTile, tugasPertama),
          );
          expect(tilePertama.value, isTrue);

          // 4. Aktifkan filter lagi, lalu centang tugas kedua.
          await tester.tap(chipFilter);
          await tester.pumpAndSettle();

          await tester.tap(find.byType(CheckboxListTile).first);
          await tester.pumpAndSettle();

          expect(find.text('Tidak ada tugas yang belum selesai.'), findsOneWidget);
          expect(find.text('2 dari 2 selesai'), findsOneWidget);
        });
  }
}