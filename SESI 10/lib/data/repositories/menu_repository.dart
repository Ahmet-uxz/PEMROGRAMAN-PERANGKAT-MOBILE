import '../../domain/models/menu_item.dart';

class MenuRepository {
  static const List<MenuItem> items = [
    MenuItem(
      id: '1',
      nama: 'Nasi Ayam Sambal Matah',
      kategori: 'Makanan',
      harga: 22000,
      deskripsi: 'Ayam crispy dengan sambal matah segar dan nasi hangat.',
      emoji: '🍗',
    ),
    MenuItem(
      id: '2',
      nama: 'Rice Bowl Teriyaki',
      kategori: 'Makanan',
      harga: 20000,
      deskripsi: 'Ayam teriyaki, sayuran, dan taburan wijen.',
      emoji: '🍱',
    ),
    MenuItem(
      id: '3',
      nama: 'Mie Goreng Spesial',
      kategori: 'Makanan',
      harga: 18000,
      deskripsi: 'Mie goreng dengan telur, sayur, dan kerupuk.',
      emoji: '🍜',
    ),
    MenuItem(
      id: '4',
      nama: 'Roti Bakar Cokelat',
      kategori: 'Camilan',
      harga: 12000,
      deskripsi: 'Roti panggang renyah dengan cokelat lumer.',
      emoji: '🍞',
    ),
    MenuItem(
      id: '5',
      nama: 'Kentang Goreng',
      kategori: 'Camilan',
      harga: 14000,
      deskripsi: 'Kentang goreng gurih dengan saus pilihan.',
      emoji: '🍟',
    ),
    MenuItem(
      id: '6',
      nama: 'Es Kopi Susu',
      kategori: 'Minuman',
      harga: 15000,
      deskripsi: 'Kopi, susu creamy, dan gula aren.',
      emoji: '🧋',
    ),
    MenuItem(
      id: '7',
      nama: 'Matcha Latte',
      kategori: 'Minuman',
      harga: 17000,
      deskripsi: 'Matcha dengan susu yang lembut.',
      emoji: '🍵',
    ),
    MenuItem(
      id: '8',
      nama: 'Lemon Tea',
      kategori: 'Minuman',
      harga: 9000,
      deskripsi: 'Teh segar dengan perasan lemon.',
      emoji: '🍋',
    ),
  ];
}