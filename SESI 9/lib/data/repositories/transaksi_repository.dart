import '../../domain/models/transaksi.dart';

class TransaksiRepository {
  final List<Transaksi> _data = [];

  List<Transaksi> ambilSemua() => List.unmodifiable(_data);

  void tambah(Transaksi transaksi) => _data.insert(0, transaksi);

  void hapus(String id) => _data.removeWhere((t) => t.id == id);
}