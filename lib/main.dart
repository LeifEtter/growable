import 'package:flutter/material.dart';
import 'package:growable/pages/home.dart';
import 'package:growable/theme/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://ctmbhifeytqpoinrlfpz.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImN0bWJoaWZleXRxcG9pbnJsZnB6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDQ5OTMxNjEsImV4cCI6MjAyMDU2OTE2MX0.UVGB_ooFhKJtoFwKMOMpfSFbh5WKrLcebhze90hgzEc',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: CustomTheme().theme,
      home: const Home(),
    );
  }
}
