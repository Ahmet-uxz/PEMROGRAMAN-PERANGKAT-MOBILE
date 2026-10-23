
import 'package:flutter/material.dart';

import '../models/tour_package.dart';

class BookingScreen extends StatefulWidget {
  final TourPackage tourPackage;

  const BookingScreen({
    super.key,
    required this.tourPackage,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _participantController = TextEditingController(text: '1');

  DateTime? _departureDate;
  bool _allowPop = false;

  @override
  void dispose() {
    _nameController.dispose();
    _participantController.dispose();
    super.dispose();
  }

  String get formattedDate {
    if (_departureDate == null) return '';

    final date = _departureDate!;
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');

    return '$day/$month/${date.year}';
  }

  Future<void> _selectDate() async {
    final now = DateTime.now();

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _departureDate ??
          now.add(const Duration(days: 1)),
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(now.year + 3),
      helpText: 'Pilih Tanggal Keberangkatan',
    );

    if (selectedDate != null) {
      setState(() {
        _departureDate = selectedDate;
      });
    }
  }

  Future<void> _confirmBack() async {
    final shouldLeave = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Batalkan Pemesanan?'),
          content: const Text(
            'Apakah kamu yakin ingin kembali? '
                'Data pemesanan yang belum dikirim akan hilang.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Tidak'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text('Ya, Kembali'),
            ),
          ],
        );
      },
    );

    if (shouldLeave == true && mounted) {
      setState(() {
        _allowPop = true;
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Navigator.pop(context);
        }
      });
    }
  }

  void _submitBooking() {
    if (!_formKey.currentState!.validate()) return;

    if (_departureDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan pilih tanggal keberangkatan.'),
        ),
      );
      return;
    }

    final name = _nameController.text.trim();
    final participants = int.parse(
      _participantController.text.trim(),
    );

    final result =
        'Pemesanan ${widget.tourPackage.title} berhasil! '
        'Nama: $name, Peserta: $participants, '
        'Tanggal: $formattedDate.';

    Navigator.pop<String>(context, result);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope<String>(
      canPop: _allowPop,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && !_allowPop) {
          _confirmBack();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Form Pemesanan'),
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.tourPackage.title,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Lengkapi data berikut untuk memesan paket wisata.',
                ),
                const SizedBox(height: 25),

                const Text(
                  'Nama Pemesan',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: 'Masukkan nama lengkap',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nama tidak boleh kosong.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                const Text(
                  'Jumlah Peserta',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _participantController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Masukkan jumlah peserta',
                    prefixIcon: Icon(Icons.group),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    final count = int.tryParse(value ?? '');

                    if (count == null || count < 1) {
                      return 'Jumlah peserta minimal 1 orang.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                const Text(
                  'Tanggal Keberangkatan',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: _selectDate,
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.calendar_month),
                      border: OutlineInputBorder(),
                    ),
                    child: Text(
                      _departureDate == null
                          ? 'Pilih tanggal keberangkatan'
                          : formattedDate,
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitBooking,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(16),
                    ),
                    child: const Text(
                      'Konfirmasi Pemesanan',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
