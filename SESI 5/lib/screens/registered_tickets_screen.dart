import 'package:flutter/material.dart';

import '../models/registration_ticket.dart';

class RegisteredTicketsScreen extends StatelessWidget {
  final List<RegistrationTicket> tickets;
  final VoidCallback onChanged;

  const RegisteredTicketsScreen({
    super.key,
    required this.tickets,
    required this.onChanged,
  });

  Future<bool> _confirm(
      BuildContext context,
      RegistrationTicket ticket,
      ) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Batalkan tiket?'),
          content: Text(
            'Apakah kamu yakin ingin membatalkan tiket untuk "${ticket.event.title}"?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Kembali'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Batalkan'),
            ),
          ],
        );
      },
    );

    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    if (tickets.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.confirmation_num_outlined,
                size: 64,
                color: Colors.grey.shade400,
              ),
              const SizedBox(height: 12),
              Text(
                'Belum Ada Tiket',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Text(
                'Tiket seminar yang berhasil kamu daftarkan akan muncul di sini.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tickets.length,
      itemBuilder: (context, index) {
        final ticket = tickets[index];

        return Dismissible(
          key: ValueKey(ticket.id),
          direction: DismissDirection.endToStart,

          confirmDismiss: (_) {
            return _confirm(context, ticket);
          },

          onDismissed: (_) {
            tickets.removeWhere(
                  (t) => t.id == ticket.id,
            );

            onChanged();
          },

          background: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.only(right: 20),
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              color: Colors.red.shade600,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.delete_outline,
              color: Colors.white,
            ),
          ),

          child: Card(
            elevation: 0,
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.confirmation_num,
                        color: Colors.indigo,
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'TIKET AKTIF',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      Text(
                        '#${ticket.id.substring(ticket.id.length - 6)}',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  const Divider(height: 22),

                  Text(
                    ticket.event.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  _line(
                    Icons.person_outline,
                    ticket.name,
                  ),

                  _line(
                    Icons.badge_outlined,
                    ticket.nim,
                  ),

                  _line(
                    Icons.calendar_month_outlined,
                    '${ticket.attendanceDate.day}/${ticket.attendanceDate.month}/${ticket.attendanceDate.year}',
                  ),

                  _line(
                    Icons.category_outlined,
                    '${ticket.participantType} • Kit ${ticket.kitPackage}',
                  ),

                  if (ticket.donation)
                    _line(
                      Icons.volunteer_activism_outlined,
                      'Termasuk donasi',
                    ),

                  const SizedBox(height: 8),

                  Text(
                    'Geser ke kiri untuk membatalkan tiket.',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _line(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        children: [
          Icon(
            icon,
            size: 17,
            color: Colors.grey.shade600,
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}