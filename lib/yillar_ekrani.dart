import 'package:flutter/material.dart';
import 'package:not_kutuphanesi/screen_students.dart'; // Öğrenciler ekranı dosyasını ekle

class YillarEkrani extends StatelessWidget {
  final String bolum;

  const YillarEkrani({super.key, required this.bolum});

  @override
  Widget build(BuildContext context) {
    List<String> yillar = [
      '2020',
      '2021',
      '2022',
      '2023',
      '2024'
    ]; // Örnek yıl listesi

    return Scaffold(
      appBar: AppBar(
        title: Text('$bolum Bölümü Yıllar'),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFFAF3E0),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: yillar
                .map((yil) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OgrencilerEkrani(
                              bolum: bolum,
                              yil: yil,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(
                                0xFF8B4513), // Kahverengi çerçeve rengi
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          yil,
                          style: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color:
                                Color(0xFF8B4513), // Kahverengi yıl yazı rengi
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
