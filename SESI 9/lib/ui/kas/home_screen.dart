import 'package:flutter/material.dart';

import '../../domain/models/transaksi.dart';
import 'kas_view_model.dart';
import 'tambah_transaksi_screen.dart';

const _hijau = Color(0xFF16A34A);
const _merah = Color(0xFFDC2626);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.viewModel});

  final KasViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final daftar = viewModel.daftar;
        return Scaffold(
          backgroundColor: const Color(0xFFF3F6F6),
          body: Column(
            children: [
              _Header(viewModel: viewModel),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
                child: Row(
                  children: [
                    const Text(
                      'Riwayat Transaksi',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    const Spacer(),
                    Text('${daftar.length} transaksi',
                        style: TextStyle(color: Colors.grey.shade600)),
                  ],
                ),
              ),
              Expanded(
                child: daftar.isEmpty
                    ? const _KosongView()
                    : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                  itemCount: daftar.length,
                  itemBuilder: (context, index) => _TransaksiItem(
                    transaksi: daftar[index],
                    viewModel: viewModel,
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            key: const Key('fab_tambah'),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => TambahTransaksiScreen(viewModel: viewModel),
              ),
            ),
            icon: const Icon(Icons.add),
            label: const Text('Tambah'),
          ),
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.viewModel});

  final KasViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0F766E), Color(0xFF14B8A6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 28),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.account_balance_wallet_rounded,
                      color: Colors.white),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('NusaKas',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w800)),
                    Text('Kas Himpunan',
                        style: TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 28),
            const Text('Saldo Kas',
                style: TextStyle(color: Colors.white70, fontSize: 14)),
            const SizedBox(height: 4),
            Text(
              formatRupiah(viewModel.saldo),
              key: const Key('teks_saldo'),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _RingkasanCard(
                    label: 'Pemasukan',
                    nilai: formatRupiah(viewModel.totalPemasukan),
                    icon: Icons.arrow_downward_rounded,
                    teksKey: const Key('teks_pemasukan'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _RingkasanCard(
                    label: 'Pengeluaran',
                    nilai: formatRupiah(viewModel.totalPengeluaran),
                    icon: Icons.arrow_upward_rounded,
                    teksKey: const Key('teks_pengeluaran'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RingkasanCard extends StatelessWidget {
  const _RingkasanCard({
    required this.label,
    required this.nilai,
    required this.icon,
    required this.teksKey,
  });

  final String label;
  final String nilai;
  final IconData icon;
  final Key teksKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.white.withValues(alpha: 0.25),
            child: Icon(icon, size: 18, color: Colors.white),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style:
                    const TextStyle(color: Colors.white70, fontSize: 12)),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    nilai,
                    key: teksKey,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TransaksiItem extends StatelessWidget {
  const _TransaksiItem({required this.transaksi, required this.viewModel});

  final Transaksi transaksi;
  final KasViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final masuk = transaksi.jenis == JenisTransaksi.pemasukan;
    final warna = masuk ? _hijau : _merah;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Dismissible(
        key: Key(transaksi.id),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 24),
          decoration: BoxDecoration(
            color: _merah,
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Icon(Icons.delete_outline_rounded,
              color: Colors.white, size: 28),
        ),
        confirmDismiss: (_) async {
          final error = viewModel.validasiHapus(transaksi);
          if (error != null) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(error)));
            return false;
          }
          return true;
        },
        onDismissed: (_) {
          viewModel.hapus(transaksi.id);
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text('"${transaksi.keterangan}" dihapus')),
            );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ListTile(
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            leading: CircleAvatar(
              backgroundColor: warna.withValues(alpha: 0.12),
              child: Icon(
                masuk ? Icons.south_west_rounded : Icons.north_east_rounded,
                color: warna,
              ),
            ),
            title: Text(transaksi.keterangan,
                style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text(formatTanggal(transaksi.tanggal)),
            trailing: Text(
              '${masuk ? '+' : '-'} ${formatRupiah(transaksi.nominal)}',
              style: TextStyle(
                  color: warna, fontWeight: FontWeight.w700, fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }
}

class _KosongView extends StatelessWidget {
  const _KosongView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.receipt_long_rounded,
              size: 72, color: Colors.grey.shade400),
          const SizedBox(height: 12),
          Text('Belum ada transaksi',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600)),
          const SizedBox(height: 4),
          Text('Tekan tombol Tambah untuk mencatat kas',
              style: TextStyle(color: Colors.grey.shade500)),
        ],
      ),
    );
  }
}