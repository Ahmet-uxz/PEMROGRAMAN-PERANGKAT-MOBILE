import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/core/window_size.dart';
import 'ui/menu/menu_view_model.dart';
import 'ui/menu/menu_screen.dart';
import 'ui/pesanan/pesanan_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => MenuViewModel(),
      child: const NusaKantinApp(),
    ),
  );
}

class NusaKantinApp extends StatelessWidget {
  const NusaKantinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NusaKantin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF087E6B),
        ),
        scaffoldBackgroundColor: const Color(0xFFF6F8F7),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),
      ),
      home: const HomeShell(),
    );
  }
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final size = windowSizeOf(context);
    final wide = size != WindowSize.compact;

    final pages = [
      const MenuScreen(),
      const PesananScreen(),
    ];

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            if (wide)
              NavigationRail(
                selectedIndex: index,
                onDestinationSelected: (v) {
                  setState(() => index = v);
                },
                labelType: NavigationRailLabelType.all,
                backgroundColor: Colors.white,
                leading: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: Color(0xFFE2F3EE),
                    child: Text(
                      '🥗',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.restaurant_menu_outlined),
                    selectedIcon: Icon(Icons.restaurant_menu),
                    label: Text('Menu'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.receipt_long_outlined),
                    selectedIcon: Icon(Icons.receipt_long),
                    label: Text('Pesanan'),
                  ),
                ],
              ),
            Expanded(
              child: IndexedStack(
                index: index,
                children: pages,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: wide
          ? null
          : NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (v) {
          setState(() => index = v);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.restaurant_menu_outlined),
            selectedIcon: Icon(Icons.restaurant_menu),
            label: 'Menu',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Pesanan',
          ),
        ],
      ),
    );
  }
}