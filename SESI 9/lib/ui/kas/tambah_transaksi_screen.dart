import 'package:flutter/material.dart';

import '../../domain/models/transaksi.dart';
import 'kas_view_model.dart';

class TambahTransaksiScreen extends StatefulWidget {
  const TambahTransaksiScreen({super.key, required this.viewModel});

  final KasViewModel viewModel;

  @override
  State<TambahTransaksiScreen> createState() => _TambahTransaksiScreenState();
}

class _TambahTransaksiScreenState extends State<TambahTransaksiScreen> {
  final _formKey = GlobalKey<FormState>();
  final _keteranganController = TextEditingController();
  final _nominalController = TextEditingController();
  JenisTransaksi _jenis = JenisTransaksi.pemasukan;

  @override
  void dispose() {
    _keteranganController.dispose();
    _nominalController.dispose();
    super.dispose();
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) return;

    final error = widget.viewModel.tambah(
      keterangan: _keteranganController.text,
      nominal: int.parse(_nominalController.text.trim()),
      jenis: _jenis,
    );

    if (error != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error)));
      return;
    }
    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    final masuk = _jenis == JenisTransaksi.pemasukan;
    final warna =
    masuk ? const Color(0xFF16A34A) : const Color(0xFFDC2626);

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6F6),
      appBar: AppBar(
        title: const Text('Tambah Transaksi'),
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Jenis Transaksi',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: SegmentedButton<JenisTransaksi>(
                      key: const Key('field_jenis'),
                      showSelectedIcon: false,
                      segments: const [
                        ButtonSegment(
                          value: JenisTransaksi.pemasukan,
                          label: Text('Pemasukan'),
                          icon: Icon(Icons.south_west_rounded),
                        ),
                        ButtonSegment(
                          value: JenisTransaksi.pengeluaran,
                          label: Text('Pengeluaran'),
                          icon: Icon(Icons.north_east_rounded),
                        ),
                      ],
                      selected: {_jenis},
                      onSelectionChanged: (pilihan) =>
                          setState(() => _jenis = pilihan.first),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    key: const Key('field_keterangan'),
                    controller: _keteranganController,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      labelText: 'Keterangan',
                      hintText: 'Contoh: Iuran anggota',
                      prefixIcon: Icon(Icons.edit_note_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Keterangan wajib diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    key: const Key('field_nominal'),
                    controller: _nominalController,
                    keyboardType:
                    const TextInputType.numberWithOptions(signed: true),
                    decoration: const InputDecoration(
                      labelText: 'Nominal',
                      hintText: 'Contoh: 50000',
                      prefixText: 'Rp ',
                      prefixIcon: Icon(Icons.payments_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                      ),
                    ),
                    validator: (value) {
                      final teks = value?.trim() ?? '';
                      if (teks.isEmpty) return 'Nominal wajib diisi';
                      final nominal = int.tryParse(teks);
                      if (nominal == null) return 'Nominal harus berupa angka';
                      return widget.viewModel.validasi(nominal, _jenis);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 54,
              child: FilledButton.icon(
                key: const Key('tombol_simpan'),
                style: FilledButton.styleFrom(
                  backgroundColor: warna,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: _simpan,
                icon: const Icon(Icons.check_rounded),
                label: const Text('Simpan',
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}