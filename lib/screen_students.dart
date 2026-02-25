import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// not.dart dosyasını ekle

class OgrencilerEkrani extends StatefulWidget {
  final String bolum;

  const OgrencilerEkrani({super.key, required this.bolum, required String yil});

  @override
  _OgrencilerEkraniState createState() => _OgrencilerEkraniState();
}

class _OgrencilerEkraniState extends State<OgrencilerEkrani> {
  List<String> ogrenciIsimleri = [];

  void _ogrenciEkle(String isim) {
    setState(() {
      ogrenciIsimleri.add(isim);
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController isimController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.bolum} Bölümü Öğrencileri'),
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFFFAF3E0),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: isimController,
              decoration: const InputDecoration(
                labelText: 'Öğrenci İsmi',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _ogrenciEkle(isimController.text);
                isimController.clear();
              },
              child: const Text('Öğrenci İsmi Oluştur'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: ogrenciIsimleri.length,
                itemBuilder: (context, index) {
                  String ogrenci = ogrenciIsimleri[index];
                  return ListTile(
                    title: Text(ogrenci),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DerslerEkrani(
                            bolum: widget.bolum,
                            ogrenci: ogrenci,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DerslerEkrani extends StatefulWidget {
  final String bolum;
  final String ogrenci;

  const DerslerEkrani({super.key, required this.bolum, required this.ogrenci});

  @override
  _DerslerEkraniState createState() => _DerslerEkraniState();
}

class _DerslerEkraniState extends State<DerslerEkrani> {
  List<String> dersler = [];

  void _dersEkle(String ders) {
    setState(() {
      dersler.add(ders);
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController dersController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.ogrenci} İçin Dersler'),
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFFFAF3E0),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: dersController,
              decoration: const InputDecoration(
                labelText: 'Ders İsmi',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _dersEkle(dersController.text);
                dersController.clear();
              },
              child: const Text('Ders Ekle'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: dersler.length,
                itemBuilder: (context, index) {
                  String ders = dersler[index];
                  return ListTile(
                    title: Text(ders),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotlarEkrani(
                            ogrenci: widget.ogrenci,
                            ders: ders,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotlarEkrani extends StatefulWidget {
  final String ogrenci;
  final String ders;

  const NotlarEkrani({super.key, required this.ogrenci, required this.ders});

  @override
  _NotlarEkraniState createState() => _NotlarEkraniState();
}

class _NotlarEkraniState extends State<NotlarEkrani> {
  List<Map<String, dynamic>> notlar = [];

  Future<void> _pdfEkle() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        Uint8List? fileBytes = result.files.first.bytes;
        String fileName = result.files.first.name;

        setState(() {
          notlar
              .add({'ders': widget.ders, 'name': fileName, 'bytes': fileBytes});
        });
      } else {
        print('PDF dosyası seçilmedi.');
      }
    } catch (e) {
      print("PDF yüklenirken hata oluştu: $e");
    }
  }

  Future<void> _downloadFile(Uint8List fileBytes, String fileName) async {
    try {
      // Web platformunda dosya indirme işlemi için
      final base64Data = base64Encode(fileBytes);
      final url = 'data:application/pdf;base64,$base64Data';
      // ignore: unused_local_variable
      final anchor = AnchorElement(href: url)
        ..setAttribute('download', fileName)
        ..click();
    } catch (e) {
      print("Dosya indirilirken hata oluştu: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.ogrenci} - ${widget.ders} Notları'),
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFFFAF3E0),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _pdfEkle,
              child: const Text('PDF Ekle'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: notlar.length,
                itemBuilder: (context, index) {
                  String ders = notlar[index]['ders'];
                  String fileName = notlar[index]['name'];
                  return ListTile(
                    title: Text('PDF ${index + 1} - $ders'),
                    subtitle: Text(fileName),
                    trailing: IconButton(
                      icon: const Icon(Icons.download),
                      onPressed: () =>
                          _downloadFile(notlar[index]['bytes'], fileName),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
