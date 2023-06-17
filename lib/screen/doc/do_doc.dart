import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kodeks/screen/doc/statement.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:url_launcher/url_launcher.dart';

class Doc extends StatelessWidget {
  // ...

  Future<void> downloadDocument() async {
    final pdf = pw.Document();

    // ... Создайте и настройте документ PDF

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/statements.pdf');
    await file.writeAsBytes(await pdf.save());

    // Откройте URL-адрес файла
    launch(file.path);
  }

  Future<void> openURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Не удалось открыть URL: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Statements PDF',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Statements PDF'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: generateDocument,
                child: Text('Создать документ PDF'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: downloadDocument,
                child: Text('Скачать документ PDF'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => openURL(
                    'https://xn----8sbebn0dapeq.xn--p1acf/assets/files/pdffajl.pdf'),
                child: Text('Открыть URL'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final List<Statement> statements = [
    Statement(
      title: 'Заявление 1',
      content: 'Это содержимое заявления 1.',
    ),
    Statement(
      title: 'Заявление 2',
      content: 'Это содержимое заявления 2.',
    ),
  ];

  Future<void> generateDocument() async {
    final pdf = pw.Document();

    for (var statement in statements) {
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    statement.title,
                    style: pw.TextStyle(fontSize: 24),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    statement.content,
                    style: pw.TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
  }
}
