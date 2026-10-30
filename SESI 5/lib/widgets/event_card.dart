import 'package:flutter/material.dart';
import '../models/event_item.dart';

class EventCard extends StatelessWidget {
  final EventItem event;
  final VoidCallback onTap;

  const EventCard({
    super.key,
    required this.event,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = Color(
      int.parse('FF${event.colorHex}', radix: 16),
    );

    return Card(
      elevation: 0,
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: color.withOpacity(.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      event.category,
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Rp${event.price}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                event.title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                event.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey.shade700),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 14,
                runSpacing: 8,
                children: [
                  _info(Icons.calendar_month_outlined, event.date),
                  _info(Icons.schedule, event.time),
                  _info(Icons.location_on_outlined, event.location),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 17,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      event.speaker,
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ),
                  const Text(
                    'Lihat detail →',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _info(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade600),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }
}