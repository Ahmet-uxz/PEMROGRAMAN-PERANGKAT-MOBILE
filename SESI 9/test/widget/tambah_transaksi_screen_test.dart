import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nusa_kas/ui/kas/kas_view_model.dart';
import 'package:nusa_kas/ui/kas/tambah_transaksi_screen.dart';

Widget bungkus(KasViewModel vm) =>
    MaterialApp(home: TambahTransaksiScreen(viewModel: vm));

Future<void> isiForm(WidgetTester tester, String keterangan, String nominal) async {
  await tester.enterText(find.byKey(const Key('field_keterangan')), keterangan);
  await tester.enterText(find.byKey(const Key('field_nominal')), nominal);
}

void main() {
  testWidgets('form kosong menampilkan pesan validasi', (tester) async {
    await tester.pumpWidget(bungkus(KasViewModel()));

    await tester.tap(find.byKey(const Key('tombol_simpan')));
    await tester.pump();

    expect(find.text('Keterangan wajib diisi'), findsOneWidget);
    expect(find.text('Nominal wajib diisi'), findsOneWidget);
  });

  testWidgets('nominal nol ditolak', (tester) async {
    final vm = KasViewModel();
    await tester.pumpWidget(bungkus(vm));

    await isiForm(tester, 'Iuran', '0');
    await tester.tap(find.byKey(const Key('tombol_simpan')));
    await tester.pump();

    expect(find.text('Nominal harus lebih dari 0'), findsOneWidget);
    expect(vm.daftar, isEmpty);
  });

  testWidgets('pengeluaran melebihi saldo ditolak', (tester) async {
    final vm = KasViewModel();
    await tester.pumpWidget(bungkus(vm));

    await tester.tap(find.descendant(
      of: find.byKey(const Key('field_jenis')),
      matching: find.text('Pengeluaran'),
    ));
    await tester.pump();

    await isiForm(tester, 'Beli spanduk', '5000');
    await tester.tap(find.byKey(const Key('tombol_simpan')));
    await tester.pump();

    expect(find.text('Pengeluaran melebihi saldo'), findsOneWidget);
    expect(vm.daftar, isEmpty);
  });

  testWidgets('pemasukan valid tersimpan', (tester) async {
    final vm = KasViewModel();
    await tester.pumpWidget(bungkus(vm));

    await isiForm(tester, 'Iuran anggota', '100000');
    await tester.tap(find.byKey(const Key('tombol_simpan')));
    await tester.pump();

    expect(vm.daftar.length, 1);
    expect(vm.saldo, 100000);
  });
}