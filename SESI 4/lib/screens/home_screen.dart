
import 'package:flutter/material.dart';

import '../models/tour_package.dart';
import '../routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<TourPackage> packages = [
    TourPackage(
      id: 1,
      title: 'Pantai Kuta Bali',
      description:
      'Nikmati pasir putih, pemandangan laut, '
          'dan matahari terbenam yang indah di Bali.',
      price: 750000,
      imageUrl:
      'https://images.unsplash.com/photo-1537996194471-e657df975ab4?w=800',
    ),
    TourPackage(
      id: 2,
      title: 'Gunung Bromo',
      description:
      'Nikmati keindahan matahari terbit dan '
          'lautan pasir di kawasan Gunung Bromo.',
      price: 950000,
      imageUrl:
      'https://images.unsplash.com/photo-1519681393784-d120267933ba?w=800',
    ),
    TourPackage(
      id: 3,
      title: 'Raja Ampat',
      description:
      'Jelajahi pulau-pulau indah dan laut jernih '
          'di salah satu destinasi unggulan Indonesia.',
      price: 2500000,
      imageUrl:
      'https://images.unsplash.com/photo-1510414842594-a61c69b5ae57?w=800',
    ),
    TourPackage(
      id: 4,
      title: 'Candi Borobudur',
      description:
      'Kunjungi candi bersejarah dan nikmati '
          'keindahan budaya serta arsitektur Indonesia.',
      price: 500000,
      imageUrl:
      'https://images.unsplash.com/photo-1596402184320-417e7178b2cd?w=800',
    ),
  ];

  String formatPrice(double price) {
    return 'Rp ${price.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (match) => '.',
    )}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'NusaTravel',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Logout',
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.splash,
                    (route) => false,
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Jelajahi Indonesia',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Pilih destinasi wisata favoritmu.',
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 16),

          ...packages.map((tourPackage) {
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              clipBehavior: Clip.antiAlias,
              elevation: 3,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.detail,
                    arguments: tourPackage,
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      tourPackage.imageUrl,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 180,
                          color: Colors.teal.shade50,
                          child: const Center(
                            child: Icon(
                              Icons.landscape,
                              size: 60,
                              color: Colors.teal,
                            ),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            tourPackage.title,
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            formatPrice(tourPackage.price),
                            style: const TextStyle(
                              color: Colors.teal,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Row(
                            mainAxisAlignment:
                            MainAxisAlignment.end,
                            children: [
                              Text('Lihat Detail'),
                              SizedBox(width: 5),
                              Icon(
                                Icons.arrow_forward,
                                size: 18,
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
          }),
        ],
      ),
    );
  }
}
