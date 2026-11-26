import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/menu_item.dart';
import '../menu_view_model.dart';
import 'menu_list.dart';

class MenuDetail extends StatelessWidget {
  final MenuItem? item;

  const MenuDetail({
    super.key,
    this.item,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (item == null) {
          return Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Center(
              child: Text(
                'Pilih menu untuk melihat detailnya',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        final compactPanel = constraints.maxWidth < 300;

        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: FoodArt(
                    item: item!,
                    size: compactPanel ? 100 : 150,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  item!.kategori.toUpperCase(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item!.nama,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  item!.deskripsi,
                  style: const TextStyle(
                    height: 1.5,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  'Rp ${formatRupiah(item!.harga)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      context.read<MenuViewModel>().add(item!);
                    },
                    icon: const Icon(Icons.add_shopping_cart),
                    label: const Text('Tambah pesanan'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}