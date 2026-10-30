import 'package:flutter/material.dart';

import '../data/sample_events.dart';
import '../models/event_item.dart';
import '../models/registration_ticket.dart';
import '../widgets/event_card.dart';
import '../widgets/filter_bottom_sheet.dart';
import '../widgets/venue_map_viewer.dart';

import 'event_registration_screen.dart';
import 'registered_tickets_screen.dart';

class HomeEventsScreen extends StatefulWidget {
  const HomeEventsScreen({super.key});

  @override
  State<HomeEventsScreen> createState() =>
      _HomeEventsScreenState();
}

class _HomeEventsScreenState extends State<HomeEventsScreen> {
  int _index = 0;
  String _category = 'Semua';

  final List<RegistrationTicket> _tickets = [];

  Future<void> _openRegistration(EventItem event) async {
    final ticket = await Navigator.push<RegistrationTicket>(
      context,
      MaterialPageRoute(
        builder: (_) => EventRegistrationScreen(event: event),
      ),
    );

    if (ticket != null && mounted) {
      setState(() {
        _tickets.add(ticket);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Pendaftaran berhasil! Tiket sudah ditambahkan.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _seminarPage(),
      _galleryPage(),
      RegisteredTicketsScreen(
        tickets: _tickets,
        onChanged: () => setState(() {}),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(11),
              ),
              child: const Icon(
                Icons.event_available,
                color: Colors.white,
                size: 21,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'NusaEvent Hub',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: IndexedStack(
          index: _index,
          children: pages,
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) {
          setState(() {
            _index = value;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.event_note_outlined),
            selectedIcon: Icon(Icons.event_note),
            label: 'Seminar',
          ),
          NavigationDestination(
            icon: Icon(Icons.photo_library_outlined),
            selectedIcon: Icon(Icons.photo_library),
            label: 'Galeri & Venue',
          ),
          NavigationDestination(
            icon: Icon(Icons.confirmation_num_outlined),
            selectedIcon: Icon(Icons.confirmation_num),
            label: 'Tiket',
          ),
        ],
      ),
    );
  }

  Widget _seminarPage() {
    final events = sampleEvents.where((event) {
      return _category == 'Semua' ||
          event.category == _category;
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF3157D5),
                  Color(0xFF7189E8),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Temukan Pengalaman Baru',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Ikuti seminar dan workshop teknologi pilihanmu.',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Seminar & Workshop',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              OutlinedButton.icon(
                onPressed: () async {
                  final result =
                  await showModalBottomSheet<String>(
                    context: context,
                    showDragHandle: false,
                    builder: (_) => FilterBottomSheet(
                      selected: _category,
                    ),
                  );

                  if (result != null) {
                    setState(() {
                      _category = result;
                    });
                  }
                },
                icon: const Icon(Icons.tune, size: 18),
                label: Text(
                  _category == 'Semua'
                      ? 'Filter'
                      : _category,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        Expanded(
          child: events.isEmpty
              ? const Center(
            child: Text(
              'Belum ada seminar untuk kategori ini.',
            ),
          )
              : ListView.builder(
            padding: const EdgeInsets.fromLTRB(
              16,
              4,
              16,
              16,
            ),
            itemCount: events.length,
            itemBuilder: (context, index) {
              return EventCard(
                event: events[index],
                onTap: () =>
                    _showEventDetail(events[index]),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showEventDetail(EventItem event) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              8,
              20,
              24,
            ),
            child: Wrap(
              runSpacing: 12,
              children: [
                Text(
                  event.title,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(event.description),
                _detail(
                  Icons.person,
                  'Pemateri: ${event.speaker}',
                ),
                _detail(
                  Icons.calendar_month,
                  '${event.date} • ${event.time}',
                ),
                _detail(
                  Icons.location_on,
                  event.location,
                ),
                _detail(
                  Icons.people,
                  'Kuota: ${event.capacity} peserta',
                ),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pop(sheetContext);
                      _openRegistration(event);
                    },
                    child: const Text('Daftar Sekarang'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _detail(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 19),
        const SizedBox(width: 9),
        Expanded(child: Text(text)),
      ],
    );
  }

  Widget _galleryPage() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Galeri Seminar',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sampleEvents.length,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: .82,
          ),
          itemBuilder: (context, index) {
            final event = sampleEvents[index];

            final color = Color(
              int.parse(
                'FF${event.colorHex}',
                radix: 16,
              ),
            );

            return Card(
              elevation: 0,
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () => _showEventDetail(event),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        color,
                        color.withOpacity(.72),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.event,
                        color: Colors.white,
                        size: 32,
                      ),
                      const Spacer(),
                      Text(
                        event.category.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        event.title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        event.date,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 24),

        const VenueMapViewer(),
      ],
    );
  }
}