import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nusa_kas/main.dart';
import 'package:nusa_kas/ui/kas/kas_view_model.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('tambah dua transaksi lalu periksa saldo', (tester) async {
    await tester.pumpWidget(NusaKasApp(viewModel: KasViewModel()));
    await tester.pumpAndSettle();

    String teks(String key) =>
        tester.widget<Text>(find.byKey(Key(key))).data!;

    expect(teks('teks_saldo'), 'Rp 0');

    // Transaksi 1: pemasukan Rp 500.000
    await tester.tap(find.byKey(const Key('fab_tambah')));
    await tester.pumpAndSettle();
    await tester.enterText(
        find.byKey(const Key('field_keterangan')), 'Iuran anggota');
    await tester.enterText(find.byKey(const Key('field_nominal')), '500000');
    await tester.tap(find.byKey(const Key('tombol_simpan')));
    await tester.pumpAndSettle();

    // Transaksi 2: pengeluaran Rp 150.000
    await tester.tap(find.byKey(const Key('fab_tambah')));
    await tester.pumpAndSettle();
    await tester.tap(find.descendant(
      of: find.byKey(const Key('field_jenis')),
      matching: find.text('Pengeluaran'),
    ));
    await tester.pumpAndSettle();
    await tester.enterText(
        find.byKey(const Key('field_keterangan')), 'Beli konsumsi');
    await tester.enterText(find.byKey(const Key('field_nominal')), '150000');
    await tester.tap(find.byKey(const Key('tombol_simpan')));
    await tester.pumpAndSettle();

    expect(teks('teks_pemasukan'), 'Rp 500.000');
    expect(teks('teks_pengeluaran'), 'Rp 150.000');
    expect(teks('teks_saldo'), 'Rp 350.000');
    expect(find.text('Iuran anggota'), findsOneWidget);
    expect(find.text('Beli konsumsi'), findsOneWidget);
  });
}