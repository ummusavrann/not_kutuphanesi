import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:html' as html;

// Web platformunda dosya indirme işlemi için
// main.dart içindeki BolumlerEkrani'nden arka plan rengini kullan

class NotlarEkrani extends StatefulWidget {
  final String ogrenci;

  const NotlarEkrani({super.key, required this.ogrenci, required String ders});

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

        // Dosyanın seçildiğini ve baytlarının alındığını kontrol edin
        print("Dosya adı: $fileName");
        print("Dosya baytları: ${fileBytes?.length}");

        if (fileBytes != null) {
          setState(() {
            notlar.add({'name': fileName, 'bytes': fileBytes});
          });
        }
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
      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', fileName)
        ..click();
    } catch (e) {
      print("Dosya indirilirken hata oluştu: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    var BolumlerEkrani;
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.ogrenci} Notları'),
      ),
      backgroundColor: BolumlerEkrani
          .arkaPlanRengi, // BolumlerEkrani'den arka plan rengini kullan
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _pdfEkle,
            child: const Text('PDF Ekle'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: notlar.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('PDF ${index + 1}'),
                  subtitle: Text(notlar[index]['name']),
                  trailing: IconButton(
                    icon: const Icon(Icons.download),
                    onPressed: () => _downloadFile(
                        notlar[index]['bytes'], notlar[index]['name']),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
