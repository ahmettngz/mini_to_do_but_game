import 'package:flutter/material.dart';
import 'presentation/screens/main_layout.dart'; // Yeni dosyamızı içeri aktardık!

void main() {
  runApp(const MiniToDoApp());
}

class MiniToDoApp extends StatelessWidget {
  const MiniToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nightly Reflection',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      home: const MainLayout(), // Uygulama açılır açılmaz bizim Layout'u ekrana basacak
    );
  }
}