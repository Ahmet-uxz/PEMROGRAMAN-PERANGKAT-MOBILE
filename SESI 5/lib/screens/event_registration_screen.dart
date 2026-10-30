import 'package:flutter/material.dart';

import '../models/event_item.dart';
import '../models/registration_ticket.dart';

class EventRegistrationScreen extends StatefulWidget {
  final EventItem event;

  const EventRegistrationScreen({
    super.key,
    required this.event,
  });

  @override
  State<EventRegistrationScreen> createState() =>
      _EventRegistrationScreenState();
}

class _EventRegistrationScreenState
    extends State<EventRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _name = TextEditingController();
  final _nim = TextEditingController();
  final _email = TextEditingController();
  final _whatsapp = TextEditingController();

  String _participant = 'Mahasiswa';
  String _kit = 'Standard';

  DateTime? _date;

  bool _donation = false;
  bool _agree = false;
  bool _loading = false;

  @override
  void dispose() {
    _name.dispose();
    _nim.dispose();
    _email.dispose();
    _whatsapp.dispose();
    super.dispose();
  }

  Future<void> _chooseDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: DateTime(2026, 11, 12),
      firstDate: DateTime(2026, 10, 30),
      lastDate: DateTime(2027, 12, 31),
      helpText: 'Pilih tanggal kehadiran',
    );

    if (selected != null) {
      setState(() {
        _date = selected;
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_date == null || !_agree) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Pilih tanggal dan setujui tata tertib terlebih dahulu.',
          ),
        ),
      );
      return;
    }

    setState(() {
      _loading = true;
    });

    await Future.delayed(
      const Duration(seconds: 2),
    );

    if (!mounted) return;

    final ticket = RegistrationTicket(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      event: widget.event,
      name: _name.text.trim(),
      nim: _nim.text.trim(),
      email: _email.text.trim(),
      whatsapp: _whatsapp.text.trim(),
      participantType: _participant,
      attendanceDate: _date!,
      kitPackage: _kit,
      donation: _donation,
      registeredAt: DateTime.now(),
    );

    setState(() {
      _loading = false;
    });

    Navigator.pop(context, ticket);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulir Pendaftaran'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.event.title,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${widget.event.date} • ${widget.event.time}',
                    ),
                    Text(
                      'Biaya tiket: Rp${widget.event.price}',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 18),

            Text(
              'Data Peserta',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            _field(
              _name,
              'Nama lengkap',
              Icons.person_outline,
                  (v) => v == null || v.trim().length < 3
                  ? 'Nama minimal 3 karakter'
                  : null,
            ),

            const SizedBox(height: 12),

            _field(
              _nim,
              'NIM',
              Icons.badge_outlined,
                  (v) =>
              v == null ||
                  !RegExp(r'^[0-9]{5,}$')
                      .hasMatch(v)
                  ? 'NIM minimal 5 angka'
                  : null,
              keyboard: TextInputType.number,
            ),

            const SizedBox(height: 12),

            _field(
              _email,
              'Email',
              Icons.email_outlined,
                  (v) =>
              v == null ||
                  !RegExp(
                    r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                  ).hasMatch(v)
                  ? 'Format email tidak valid'
                  : null,
              keyboard: TextInputType.emailAddress,
            ),

            const SizedBox(height: 12),

            _field(
              _whatsapp,
              'Nomor WhatsApp',
              Icons.phone_android,
                  (v) =>
              v == null ||
                  !RegExp(r'^[0-9+]{10,15}$')
                      .hasMatch(v)
                  ? 'Masukkan nomor 10–15 digit'
                  : null,
              keyboard: TextInputType.phone,
            ),

            const SizedBox(height: 18),

            _label('Tipe Peserta'),

            DropdownButtonFormField<String>(
              value: _participant,
              decoration: const InputDecoration(),
              items: [
                'Mahasiswa',
                'Umum',
                'Pelajar',
              ].map((v) {
                return DropdownMenuItem(
                  value: v,
                  child: Text(v),
                );
              }).toList(),
              onChanged: (v) {
                setState(() {
                  _participant = v!;
                });
              },
            ),

            const SizedBox(height: 14),

            _label('Tanggal Kehadiran'),

            OutlinedButton.icon(
              onPressed: _chooseDate,
              icon: const Icon(Icons.calendar_month),
              label: Text(
                _date == null
                    ? 'Pilih tanggal'
                    : '${_date!.day}/${_date!.month}/${_date!.year}',
              ),
            ),

            const SizedBox(height: 14),

            _label('Paket Seminar Kit'),

            DropdownButtonFormField<String>(
              value: _kit,
              decoration: const InputDecoration(),
              items: [
                'Standard',
                'Premium',
                'Tanpa Kit',
              ].map((v) {
                return DropdownMenuItem(
                  value: v,
                  child: Text(v),
                );
              }).toList(),
              onChanged: (v) {
                setState(() {
                  _kit = v!;
                });
              },
            ),

            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(
                'Tambahkan donasi sukarela',
              ),
              subtitle: const Text(
                'Donasi untuk kegiatan sosial',
              ),
              value: _donation,
              onChanged: (v) {
                setState(() {
                  _donation = v;
                });
              },
            ),

            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              controlAffinity:
              ListTileControlAffinity.leading,
              value: _agree,
              onChanged: (v) {
                setState(() {
                  _agree = v ?? false;
                });
              },
              title: const Text(
                'Saya menyetujui tata tertib dan ketentuan acara',
              ),
            ),

            const SizedBox(height: 10),

            FilledButton(
              onPressed: _loading ? null : _submit,
              child: _loading
                  ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
                  : const Text('Daftar Sekarang'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(
      TextEditingController controller,
      String label,
      IconData icon,
      String? Function(String?) validator, {
        TextInputType keyboard = TextInputType.text,
      }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}