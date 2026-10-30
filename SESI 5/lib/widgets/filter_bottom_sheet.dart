import 'package:flutter/material.dart';

class FilterBottomSheet extends StatelessWidget {
  final String selected;

  const FilterBottomSheet({
    super.key,
    required this.selected,
  });

  static const categories = [
    'Semua',
    'AI',
    'Mobile',
    'IoT',
    'Cybersecurity',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 38,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Filter kategori',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...categories.map(
                  (category) => ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(category),
                trailing: selected == category
                    ? const Icon(
                  Icons.check_circle,
                  color: Colors.indigo,
                )
                    : null,
                onTap: () => Navigator.pop(context, category),
              ),
            ),
          ],
        ),
      ),
    );
  }
}