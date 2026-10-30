import 'package:flutter/material.dart';

class VenueMapViewer extends StatelessWidget {
  const VenueMapViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Denah Venue',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Cubit untuk memperbesar dan geser untuk melihat area lainnya.',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: InteractiveViewer(
                minScale: .7,
                maxScale: 4,
                boundaryMargin: const EdgeInsets.all(40),
                child: Container(
                  width: 650,
                  height: 390,
                  color: const Color(0xFFF0F3F8),
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      _room(
                        'PINTU MASUK',
                        const Color(0xFFB9D8FF),
                        42,
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  _room(
                                    'REGISTRASI',
                                    const Color(0xFFFFE0B2),
                                    65,
                                  ),
                                  const SizedBox(height: 12),
                                  Expanded(
                                    child: _room(
                                      'AREA ISTIRAHAT',
                                      const Color(0xFFC8E6C9),
                                      double.infinity,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              flex: 2,
                              child: _room(
                                'AUDITORIUM UTAMA',
                                const Color(0xFFD1C4E9),
                                double.infinity,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                children: [
                                  _room(
                                    'TOILET',
                                    const Color(0xFFB2DFDB),
                                    65,
                                  ),
                                  const SizedBox(height: 12),
                                  Expanded(
                                    child: _room(
                                      'RUANG SEMINAR',
                                      const Color(0xFFFFCDD2),
                                      double.infinity,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      _room(
                        'PINTU KELUAR',
                        const Color(0xFFB9D8FF),
                        42,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _room(String label, Color color, double height) {
    return Container(
      height: height.isInfinite ? null : height,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}