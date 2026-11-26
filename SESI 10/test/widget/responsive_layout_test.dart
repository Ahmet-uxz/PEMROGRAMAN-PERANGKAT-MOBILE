import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:nusa_kantin/main.dart';
import 'package:nusa_kantin/ui/menu/menu_view_model.dart';

void main() {
  testWidgets(
    'Layout berjalan pada ukuran HP dan tablet',
        (tester) async {
      tester.view.devicePixelRatio = 1;

      // Pengujian HP
      tester.view.physicalSize = const Size(390, 844);

      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => MenuViewModel(),
          child: const NusaKantinApp(),
        ),
      );

      await tester.pumpAndSettle();

      expect(
        find.byType(NavigationBar),
        findsOneWidget,
      );

      expect(
        find.text('Lapar? Pilih yang kamu suka.'),
        findsOneWidget,
      );

      // Pengujian tablet
      tester.view.physicalSize = const Size(1024, 768);

      await tester.pumpAndSettle();

      expect(
        find.byType(NavigationRail),
        findsOneWidget,
      );

      expect(
        find.text('Lapar? Pilih yang kamu suka.'),
        findsOneWidget,
      );

      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
    },
  );
}