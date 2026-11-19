import 'package:flutter_test/flutter_test.dart';
import 'package:nusa_kas/domain/kas_calculator.dart';
import 'package:nusa_kas/domain/models/transaksi.dart';

Transaksi buat(JenisTransaksi jenis, int nominal) => Transaksi(
  id: '$jenis-$nominal',
  keterangan: 'Tes',
  nominal: nominal,
  jenis: jenis,
  tanggal: DateTime(2026, 1, 1),
);

void main() {
  const kalkulator = KasCalculator();

  group('daftar kosong', () {
    test('hitungSaldo = 0', () {
      expect(kalkulator.hitungSaldo([]), 0);
    });
    test('totalPemasukan = 0', () {
      expect(kalkulator.totalPemasukan([]), 0);
    });
    test('totalPengeluaran = 0', () {
      expect(kalkulator.totalPengeluaran([]), 0);
    });
  });

  group('perhitungan', () {
    final daftar = [
      buat(JenisTransaksi.pemasukan, 500000),
      buat(JenisTransaksi.pemasukan, 250000),
      buat(JenisTransaksi.pengeluaran, 200000),
    ];

    test('totalPemasukan hanya menjumlah pemasukan', () {
      expect(kalkulator.totalPemasukan(daftar), 750000);
    });
    test('totalPengeluaran hanya menjumlah pengeluaran', () {
      expect(kalkulator.totalPengeluaran(daftar), 200000);
    });
    test('hitungSaldo = pemasukan - pengeluaran', () {
      expect(kalkulator.hitungSaldo(daftar), 550000);
    });
  });

  group('validasi', () {
    final daftar = [buat(JenisTransaksi.pemasukan, 100000)];

    test('menolak nominal nol', () {
      expect(
        kalkulator.validasiTransaksi(
            daftar: daftar, nominal: 0, jenis: JenisTransaksi.pemasukan),
        isNotNull,
      );
    });
    test('menolak nominal negatif', () {
      expect(
        kalkulator.validasiTransaksi(
            daftar: daftar, nominal: -5000, jenis: JenisTransaksi.pemasukan),
        isNotNull,
      );
    });
    test('batas: pengeluaran tepat sama dengan saldo diterima', () {
      expect(
        kalkulator.validasiTransaksi(
            daftar: daftar, nominal: 100000, jenis: JenisTransaksi.pengeluaran),
        isNull,
      );
    });
    test('batas: pengeluaran lebih 1 rupiah dari saldo ditolak', () {
      expect(
        kalkulator.validasiTransaksi(
            daftar: daftar, nominal: 100001, jenis: JenisTransaksi.pengeluaran),
        'Pengeluaran melebihi saldo',
      );
    });
    test('pengeluaran saat daftar kosong ditolak', () {
      expect(
        kalkulator.validasiTransaksi(
            daftar: [], nominal: 1, jenis: JenisTransaksi.pengeluaran),
        isNotNull,
      );
    });
    test('pemasukan valid diterima', () {
      expect(
        kalkulator.validasiTransaksi(
            daftar: [], nominal: 1000, jenis: JenisTransaksi.pemasukan),
        isNull,
      );
    });
  });
}