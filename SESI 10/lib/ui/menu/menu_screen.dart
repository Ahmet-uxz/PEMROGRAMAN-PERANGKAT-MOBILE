import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/window_size.dart';
import 'menu_view_model.dart';
import 'widgets/menu_list.dart';
import 'widgets/menu_grid.dart';
import 'widgets/menu_detail.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = windowSizeOf(context);
    final vm = context.watch<MenuViewModel>();

    final wide = size != WindowSize.compact;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'NUSAKANTIN',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Lapar? Pilih yang kamu suka.',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ),
                  const CircleAvatar(
                    backgroundColor: Color(0xFFE2F3EE),
                    child: Icon(
                      Icons.local_cafe,
                      color: Color(0xFF087E6B),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: vm.categories.map((category) {
                  return ChoiceChip(
                    label: Text(category),
                    selected: vm.selectedCategory == category,
                    onSelected: (_) {
                      vm.selectCategory(category);
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        Expanded(
          child: wide
              ? Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 3,
                child: MenuGrid(
                  items: vm.filteredMenu,
                ),
              ),
              SizedBox(
                width: size == WindowSize.expanded ? 310 : 270,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    0,
                    12,
                    16,
                    16,
                  ),
                  child: MenuDetail(
                    item: vm.selectedItem,
                  ),
                ),
              ),
            ],
          )
              : MenuList(
            items: vm.filteredMenu,
          ),
        ),
      ],
    );
  }
}