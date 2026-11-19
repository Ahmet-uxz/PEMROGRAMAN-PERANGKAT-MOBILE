import 'package:flutter/foundation.dart';

import '../../data/repositories/transaksi_repository.dart';
import '../../domain/kas_calculator.dart';
import '../../domain/models/transaksi.dart';

class KasViewModel extends ChangeNotifier {
  KasViewModel({
    TransaksiRepository? repository,
    KasCalculator? calculator,
  })  : _repository = repository ?? TransaksiRepository(),
        _calculator = calculator ?? const KasCalculator();

  final TransaksiRepository _repository;
  final KasCalculator _calculator;

  List<Transaksi> get daftar => _repository.ambilSemua();
  int get saldo => _calculator.hitungSaldo(daftar);
  int get totalPemasukan => _calculator.totalPemasukan(daftar);
  int get totalPengeluaran => _calculator.totalPengeluaran(daftar);

  String? validasi(int nominal, JenisTransaksi jenis) => _calculator
      .validasiTransaksi(daftar: daftar, nominal: nominal, jenis: jenis);

  /// Return null jika berhasil, atau pesan error jika ditolak.
  String? tambah({
    required String keterangan,
    required int nominal,
    required JenisTransaksi jenis,
  }) {
    final error = validasi(nominal, jenis);
    if (error != null) return error;

    _repository.tambah(Transaksi(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      keterangan: keterangan.trim(),
      nominal: nominal,
      jenis: jenis,
      tanggal: DateTime.now(),
    ));
    notifyListeners();
    return null;
  }

  /// Menghapus pemasukan tidak boleh membuat saldo menjadi negatif.
  String? validasiHapus(Transaksi transaksi) {
    if (transaksi.jenis == JenisTransaksi.pemasukan &&
        saldo - transaksi.nominal < 0) {
      return 'Tidak bisa dihapus: saldo akan menjadi negatif';
    }
    return null;
  }

  void hapus(String id) {
    _repository.hapus(id);
    notifyListeners();
  }
}

String formatRupiah(int nilai) {
  final angka = nilai.abs().toString();
  final buffer = StringBuffer();
  for (var i = 0; i < angka.length; i++) {
    if (i > 0 && (angka.length - i) % 3 == 0) buffer.write('.');
    buffer.write(angka[i]);
  }
  return '${nilai < 0 ? '-' : ''}Rp $buffer';
}

String formatTanggal(DateTime tanggal) {
  const bulan = [
    'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
    'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des',
  ];
  return '${tanggal.day} ${bulan[tanggal.month - 1]} ${tanggal.year}';
}