enum JenisTransaksi { pemasukan, pengeluaran }

class Transaksi {
  final String id;
  final String keterangan;
  final int nominal;
  final JenisTransaksi jenis;
  final DateTime tanggal;

  const Transaksi({
    required this.id,
    required this.keterangan,
    required this.nominal,
    required this.jenis,
    required this.tanggal,
  });
}