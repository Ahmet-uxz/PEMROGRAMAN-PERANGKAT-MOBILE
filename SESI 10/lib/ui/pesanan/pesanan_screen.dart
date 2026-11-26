import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ui/core/window_size.dart';
import '../menu/menu_view_model.dart';
import '../menu/widgets/menu_list.dart';

class PesananScreen extends StatelessWidget {
  const PesananScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MenuViewModel>();
    final size = windowSizeOf(context);

    final landscapeCompact =
        size == WindowSize.compact &&
            MediaQuery.sizeOf(context).width >
                MediaQuery.sizeOf(context).height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RINGKASAN',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Pesanan kamu',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 4),
              Text(
                '${vm.totalItems} item dipilih',
                style: const TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ),

        Expanded(
          child: vm.orderedItems.isEmpty
              ? Center(
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '🛍️',
                    style: TextStyle(fontSize: 54),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Belum ada pesanan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Yuk, pilih menu favoritmu di halaman Menu.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
          )
              : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: vm.orderedItems.length,
            itemBuilder: (context, index) {
              final item = vm.orderedItems[index];
              final qty = vm.quantity(item);

              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      FoodArt(
                        item: item,
                        size: 58,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.nama,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Rp ${formatRupiah(item.harga)} / item',
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'Subtotal: Rp ${formatRupiah(item.harga * qty)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => vm.remove(item),
                        icon: const Icon(
                          Icons.remove_circle_outline,
                        ),
                      ),
                      Text(
                        '$qty',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () => vm.add(item),
                        icon: const Icon(
                          Icons.add_circle,
                          color: Color(0xFF087E6B),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        if (vm.totalItems > 0)
          Padding(
            padding: EdgeInsets.fromLTRB(
              16,
              8,
              16,
              landscapeCompact ? 8 : 16,
            ),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF087E6B),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'TOTAL PEMBAYARAN',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 10,
                            letterSpacing: 1.1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Rp ${formatRupiah(vm.totalPrice)}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.receipt_long,
                    color: Colors.white,
                    size: 28,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}