import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class AppColors {
  static const bg = Color(0xFFF3F7F6);
  static const indigo900 = Color(0xFF312E81);
  static const indigo700 = Color(0xFF4338CA);
  static const indigo600 = Color(0xFF4F46E5);
  static const indigo500 = Color(0xFF6366F1);
  static const indigo50 = Color(0xFFEEF2FF);
  static const indigo100 = Color(0xFFE0E7FF);
  static const amber = Color(0xFFF59E0B);
  static const star = Color(0xFFFBC02D);
  static const slate900 = Color(0xFF0F172A);
}

String formatIDR(int amount) {
  final s = amount.toString();
  final buf = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
    buf.write(s[i]);
  }
  return 'Rp $buf';
}

BoxShadow get flutterShadow => BoxShadow(
  color: const Color(0xFF005F56).withValues(alpha: 0.08),
  blurRadius: 16,
  offset: const Offset(0, 4),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PPM Sesi  2- Ahmat (20240040117)',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.bg,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.indigo700),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 4,
        shadowColor: Colors.black45,
        scrolledUnderElevation: 4,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.indigo900, AppColors.indigo700],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.notes_rounded, color: Colors.white),
          tooltip: 'Menu navigasi',
          onPressed: () {},
        ),
        titleSpacing: 0,
        title: const Text(
          'PPM Sesi 2 - Ahmat (20240040117)',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.4,
            color: Colors.white,
          ),
        ),
        actions: const [NotificationButton(), SizedBox(width: 4)],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          children: const [
            PromoBanner(),
            SizedBox(height: 16),
            StudentProfileCard(),
            SizedBox(height: 16),
            ProductCard(),
          ],
        ),
      ),
    );
  }
}

class NotificationButton extends StatefulWidget {
  const NotificationButton({super.key});

  @override
  State<NotificationButton> createState() => _NotificationButtonState();
}

class _NotificationButtonState extends State<NotificationButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Notifikasi',
      onPressed: () {},
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          const Icon(Icons.notifications_none_rounded,
              color: Color(0xFFE0E7FF), size: 26),
          Positioned(
            top: -1,
            right: -1,
            child: SizedBox(
              width: 10,
              height: 10,
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  AnimatedBuilder(
                    animation: _ctrl,
                    builder: (context, child) => Opacity(
                      opacity: 1 - _ctrl.value,
                      child: Transform.scale(
                        scale: 1 + _ctrl.value * 1.6,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFBBF24),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFBBF24),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [AppColors.indigo700, AppColors.indigo600, AppColors.indigo500],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [flutterShadow],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Kotak miring dekoratif
            Positioned(
              right: -16,
              bottom: -24,
              child: Transform.rotate(
                angle: 0.785398,
                child: Container(
                  width: 128,
                  height: 128,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            // Lingkaran dekoratif
            Positioned(
              right: 40,
              top: 12,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: const Color(0xFF312E81).withValues(alpha: 0.30),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // Label
            Positioned(
              top: 8,
              left: 12,
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'STACK & POSITIONED',
                  style: TextStyle(
                    fontSize: 9,
                    letterSpacing: 0.9,
                    fontFamily: 'monospace',
                    color: Color(0xFFC7D2FE),
                  ),
                ),
              ),
            ),
            // Konten
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 32, 20, 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'PROMO SPESIAL',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            height: 1.15,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Diskon hingga 50% minggu ini!',
                          style: TextStyle(
                            fontSize: 12.5,
                            color: const Color(0xFFE0E7FF)
                                .withValues(alpha: 0.9),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.20),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.access_time_filled,
                                  size: 13, color: Colors.white),
                              SizedBox(width: 4),
                              Text(
                                'Berakhir dlm 2 hari',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Transform.rotate(
                        angle: -0.0175,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.amber,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Text(
                            '-50%',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF020617),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Opacity(
                        opacity: 0.75,
                        child: Icon(Icons.sell_rounded,
                            size: 40, color: Colors.indigo.shade100),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StudentProfileCard extends StatelessWidget {
  const StudentProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Stack(
        children: [
          Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.indigo50,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.indigo100, width: 2),
                    ),
                    child: const Icon(Icons.person,
                        size: 36, color: AppColors.indigo600),
                  ),
                  Positioned(
                    right: -4,
                    bottom: -4,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: AppColors.indigo600,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(Icons.check,
                          size: 12, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ahmat',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF111827),
                        ),
                      ),
                      SizedBox(height: 2),
                      Text.rich(
                        TextSpan(
                          text: 'NIM: ',
                          children: [
                            TextSpan(
                              text: '20240040117',
                              style: TextStyle(
                                fontFamily: 'monospace',
                                color: Color(0xFF1F2937),
                              ),
                            ),
                          ],
                        ),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF4B5563),
                        ),
                      ),
                      Text(
                        'Teknik Informatika / TI-24G',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      SizedBox(height: 4),
                      _StarRating(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Tag StatelessWidget
          Positioned(
            top: -4,
            right: -4,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.indigo600,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                const _WidgetTag(label: 'StatelessWidget', withDot: false),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StarRating extends StatelessWidget {
  const _StarRating();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Text('★★★★★',
            style:
            TextStyle(fontSize: 14, color: AppColors.star, letterSpacing: 2)),
        SizedBox(width: 4),
        Text('(5.0)',
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Color(0xFF6B7280))),
      ],
    );
  }
}

class _WidgetTag extends StatelessWidget {
  final String label;
  final bool withDot;
  const _WidgetTag({required this.label, this.withDot = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.indigo50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.indigo100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (withDot) ...[
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: AppColors.indigo600,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              fontFamily: 'monospace',
              color: AppColors.indigo700,
            ),
          ),
        ],
      ),
    );
  }
}

BoxDecoration _cardDecoration() => BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(16),
  border: Border.all(color: const Color(0xFF1E1B4B).withValues(alpha: 0.05)),
  boxShadow: [flutterShadow],
);

class ColorVariant {
  final String name;
  final Color color;
  final int stock;
  const ColorVariant(this.name, this.color, this.stock);
}

class ProductCard extends StatefulWidget {
  const ProductCard({super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  static const int unitPrice = 350000;
  static const int initialLikes = 128;
  static const variants = [
    ColorVariant('Cosmic Indigo', Color(0xFF4338CA), 8),
    ColorVariant('Midnight Slate', Color(0xFF0F172A), 3),
    ColorVariant('Silver Mist', Color(0xFF94A3B8), 12),
  ];

  int _quantity = 1;
  bool _isLiked = false;
  int _selectedVariant = 0;

  ColorVariant get _variant => variants[_selectedVariant];
  bool get _isEven => _quantity % 2 == 0;

  void _showSnackBar() {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.slate900.withValues(alpha: 0.95),
        elevation: 6,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 40),
        duration: const Duration(milliseconds: 3500),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
              color: const Color(0xFF312E81).withValues(alpha: 0.4)),
        ),
        content: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: AppColors.indigo600.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check,
                  size: 16, color: Color(0xFF818CF8)),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Berhasil ditambahkan ke keranjang! '
                    '($_quantity item: ${formatIDR(_quantity * unitPrice)})',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 12, color: Color(0xFFF3F4F6)),
              ),
            ),
          ],
        ),
        action: SnackBarAction(
          label: 'TUTUP',
          textColor: const Color(0xFFFBBF24),
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header tag + stok
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const _WidgetTag(label: 'StatefulWidget', withDot: true),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.indigo50,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Stok: ${_variant.stock} pcs',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.indigo700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Gambar produk + tombol like
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.indigo50, AppColors.indigo100],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: AppColors.indigo100.withValues(alpha: 0.6)),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 136,
                  child: Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 112,
                          height: 112,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: const LinearGradient(
                              colors: [AppColors.indigo900, AppColors.indigo700],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.smartphone_outlined,
                                  size: 56, color: Color(0xFFC7D2FE)),
                              SizedBox(height: 4),
                              Text(
                                'PRO SERIES',
                                style: TextStyle(
                                  fontSize: 9,
                                  letterSpacing: 1.8,
                                  fontFamily: 'monospace',
                                  color: Color(0xFFC7D2FE),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: -8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.slate900,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 3,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child: const Text(
                              'ANC Edition',
                              style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'monospace',
                                color: Color(0xFFA5B4FC),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: -6,
                  right: -6,
                  child: _buildLikeButton(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Info produk
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ELEKTRONIK & TECH KIT',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                  color: AppColors.indigo600,
                ),
              ),
              Text(
                'SKU: TI-2024-MOD',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF9CA3AF),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Wireless Smart Audio Hub TI-24G',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              height: 1.3,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                formatIDR(unitPrice),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: AppColors.indigo900,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Rp 700.000',
                style: TextStyle(
                  fontSize: 12,
                  decoration: TextDecoration.lineThrough,
                  color: Color(0xFF9CA3AF),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1, thickness: 1, color: Color(0xFFF3F4F6)),
          ),

          // Pilihan warna
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Pilihan Warna:',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6B7280),
                ),
              ),
              Row(
                children: [
                  Text(
                    _variant.name,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.indigo50,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: AppColors.indigo100),
                    ),
                    child: Text(
                      'Sisa ${_variant.stock} pcs',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppColors.indigo700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(variants.length, (i) {
              final selected = i == _selectedVariant;
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: () => setState(() => _selectedVariant = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: variants[i].color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selected
                            ? AppColors.indigo600
                            : Colors.transparent,
                        width: 2,
                      ),
                      boxShadow: selected
                          ? [
                        BoxShadow(
                          color: AppColors.indigo600
                              .withValues(alpha: 0.30),
                          spreadRadius: 2,
                        ),
                      ]
                          : null,
                    ),
                    child: selected
                        ? const Icon(Icons.check,
                        size: 14, color: Colors.white)
                        : null,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 12),

          // Counter
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFF3F4F6)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Jumlah Pesanan:',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    const SizedBox(height: 2),
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _isEven
                            ? const Color(0xFF2563EB)
                            : const Color(0xFF059669),
                      ),
                      child: Text(_isEven ? 'Angka Genap' : 'Angka Ganjil'),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0D000000),
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      _stepButton(
                        icon: Icons.remove,
                        background: AppColors.indigo50,
                        foreground: AppColors.indigo700,
                        enabled: _quantity > 1,
                        onTap: () => setState(() => _quantity--),
                      ),
                      SizedBox(
                        width: 48,
                        child: Text(
                          '$_quantity',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                      ),
                      _stepButton(
                        icon: Icons.add,
                        background: AppColors.indigo600,
                        foreground: Colors.white,
                        enabled: true,
                        onTap: () => setState(() => _quantity++),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Subtotal
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 12, 4, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Subtotal Pembelian:',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF6B7280),
                  ),
                ),
                Text(
                  formatIDR(_quantity * unitPrice),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.indigo900,
                  ),
                ),
              ],
            ),
          ),

          // Reset
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: InkWell(
                borderRadius: BorderRadius.circular(4),
                onTap: () => setState(() => _quantity = 1),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.refresh,
                          size: 14, color: Color(0xFF6B7280)),
                      SizedBox(width: 4),
                      Text(
                        'Reset Jumlah',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Tombol keranjang
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [AppColors.indigo600, AppColors.indigo500],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.indigo600.withValues(alpha: 0.35),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: _showSnackBar,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 13, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_cart_outlined,
                          size: 20, color: Color(0xFFE0E7FF)),
                      SizedBox(width: 8),
                      Text(
                        'Tambah ke Keranjang',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLikeButton() {
    return GestureDetector(
      onTap: () => setState(() => _isLiked = !_isLiked),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _isLiked ? Icons.favorite : Icons.favorite_border,
              size: 22,
              color: _isLiked ? const Color(0xFFEF4444) : const Color(0xFF9CA3AF),
            ),
            const SizedBox(width: 4),
            Text(
              '${_isLiked ? initialLikes + 1 : initialLikes}',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: _isLiked
                    ? const Color(0xFFEF4444)
                    : const Color(0xFF4B5563),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stepButton({
    required IconData icon,
    required Color background,
    required Color foreground,
    required bool enabled,
    required VoidCallback onTap,
  }) {
    return Opacity(
      opacity: enabled ? 1 : 0.4,
      child: Material(
        color: background,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: enabled ? onTap : null,
          child: SizedBox(
            width: 32,
            height: 32,
            child: Icon(icon, size: 18, color: foreground),
          ),
        ),
      ),
    );
  }
}