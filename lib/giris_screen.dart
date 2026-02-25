import 'package:flutter/material.dart';
import 'bolumler_screen.dart';

class GirisScreen extends StatelessWidget {
  const GirisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/kitap.jpg', // Kitaplık resmi (bu resmi assets klasörüne eklediğinizden emin olun)
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(
                0.5), // Opaklık ekleyerek yazıyı daha okunabilir hale getirin
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'NOT KÜTÜPHANESİ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => BolumlerScreen()),
                    );
                  },
                  child: const Text('Giriş'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
