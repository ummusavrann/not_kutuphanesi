import 'package:flutter/material.dart';
import 'yillar_ekrani.dart';

class BolumlerScreen extends StatelessWidget {
  static const Color arkaPlanRengi = Color(0xFFFAF3E0);
  final List<String> bolumler = [
    'İstatistik',
    'Matematik',
    'Biyoloji',
    'Fizik',
    'Kimya',
    'Mühendislik',
  ];

  BolumlerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BÖLÜMLER'),
        centerTitle: true,
        shadowColor: const Color.fromARGB(85, 255, 161, 89),
      ),
      body: Container(
        color: arkaPlanRengi,
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ListView.builder(
            itemCount: bolumler.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF8B4513),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ListTile(
                    title: Text(
                      bolumler[index],
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              YillarEkrani(bolum: bolumler[index]),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
