import 'package:flutter/foundation.dart';

import '../../data/repositories/menu_repository.dart';
import '../../domain/models/menu_item.dart';

class MenuViewModel extends ChangeNotifier {
  final List<MenuItem> menu = MenuRepository.items;

  final Map<String, int> _cart = {};

  String selectedCategory = 'Semua';
  String? selectedId;

  List<String> get categories => [
    'Semua',
    ...menu.map((e) => e.kategori).toSet(),
  ];

  List<MenuItem> get filteredMenu {
    if (selectedCategory == 'Semua') {
      return menu;
    }

    return menu
        .where((e) => e.kategori == selectedCategory)
        .toList();
  }

  List<MenuItem> get orderedItems {
    return menu
        .where((e) => (_cart[e.id] ?? 0) > 0)
        .toList();
  }

  int quantity(MenuItem item) {
    return _cart[item.id] ?? 0;
  }

  int get totalItems {
    return _cart.values.fold(0, (a, b) => a + b);
  }

  int get totalPrice {
    return menu.fold(
      0,
          (sum, item) => sum + item.harga * quantity(item),
    );
  }

  MenuItem? get selectedItem {
    for (final item in menu) {
      if (item.id == selectedId) return item;
    }
    return null;
  }

  void selectCategory(String value) {
    selectedCategory = value;

    if (!filteredMenu.any((e) => e.id == selectedId)) {
      selectedId = null;
    }

    notifyListeners();
  }

  void selectItem(MenuItem item) {
    selectedId = item.id;
    notifyListeners();
  }

  void add(MenuItem item) {
    _cart[item.id] = quantity(item) + 1;
    selectedId = item.id;
    notifyListeners();
  }

  void remove(MenuItem item) {
    final next = quantity(item) - 1;

    if (next <= 0) {
      _cart.remove(item.id);
    } else {
      _cart[item.id] = next;
    }

    notifyListeners();
  }
}