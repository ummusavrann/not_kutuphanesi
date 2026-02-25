import 'package:flutter/material.dart';
import 'giris_screen.dart';

void main() {
  runApp(const DersNotlariUygulamasi());
}

class DersNotlariUygulamasi extends StatelessWidget {
  const DersNotlariUygulamasi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NOT KÜTÜPHANESİ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GirisScreen(), // Giriş ekranını ana ekran olarak ayarla
    );
  }
}
