import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/menu_item.dart';
import '../menu_view_model.dart';

class MenuList extends StatelessWidget {
  final List<MenuItem> items;

  const MenuList({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final vm = context.watch<MenuViewModel>();

        final selected = vm.selectedId == item.id;

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            borderRadius: BorderRadius.circular(22),
            onTap: () => vm.selectItem(item),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  FoodArt(item: item, size: 76),
                  const SizedBox(width: 13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.kategori.toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            letterSpacing: 1.1,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.nama,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Rp ${formatRupiah(item.harga)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (selected)
                    const Icon(
                      Icons.check_circle,
                      color: Color(0xFF087E6B),
                    )
                  else
                    IconButton(
                      onPressed: () => vm.add(item),
                      icon: const Icon(
                        Icons.add_circle,
                        color: Color(0xFF087E6B),
                        size: 30,
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
}

class FoodArt extends StatelessWidget {
  final MenuItem item;
  final double size;

  const FoodArt({
    super.key,
    required this.item,
    this.size = 110,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFEAF4EF),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        item.emoji,
        style: TextStyle(fontSize: size * 0.43),
      ),
    );
  }
}

String formatRupiah(int value) {
  return value.toString().replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
        (match) => '.',
  );
}