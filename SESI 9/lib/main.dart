import 'package:flutter/material.dart';

import 'ui/kas/home_screen.dart';
import 'ui/kas/kas_view_model.dart';

void main() => runApp(const NusaKasApp());

class NusaKasApp extends StatefulWidget {
  const NusaKasApp({super.key, this.viewModel});

  final KasViewModel? viewModel;

  @override
  State<NusaKasApp> createState() => _NusaKasAppState();
}

class _NusaKasAppState extends State<NusaKasApp> {
  late final KasViewModel _viewModel = widget.viewModel ?? KasViewModel();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NusaKas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0F766E)),
      ),
      home: HomeScreen(viewModel: _viewModel),
    );
  }
}