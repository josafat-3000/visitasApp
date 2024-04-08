import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'pages/login_page.dart';


void main() async {
  await Supabase.initialize(
    url: 'https://udmtmyzexwnrnggeugit.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVkbXRteXpleHducm5nZ2V1Z2l0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTI1MzM3NTIsImV4cCI6MjAyODEwOTc1Mn0.UkflMXNLJugRiAAlpTqkV0gt_Ir2BOXKmGKTCtrosYQ',
  );
  runApp(const MyApp());
}
final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}