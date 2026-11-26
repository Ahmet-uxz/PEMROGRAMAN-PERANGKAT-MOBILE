import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/menu_item.dart';
import '../menu_view_model.dart';
import 'menu_list.dart';

class MenuGrid extends StatelessWidget {
  final List<MenuItem> items;

  const MenuGrid({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(12),
          sliver: SliverGrid(
            gridDelegate:
            const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 230,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              mainAxisExtent: 205,
            ),
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final item = items[index];
                final vm = context.watch<MenuViewModel>();

                return Card(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(22),
                    onTap: () => vm.selectItem(item),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Center(
                              child: FoodArt(
                                item: item,
                                size: 94,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            item.nama,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Rp ${formatRupiah(item.harga)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              IconButton(
                                visualDensity: VisualDensity.compact,
                                onPressed: () => vm.add(item),
                                icon: const Icon(
                                  Icons.add_circle,
                                  color: Color(0xFF087E6B),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              childCount: items.length,
            ),
          ),
        ),
      ],
    );
  }
}