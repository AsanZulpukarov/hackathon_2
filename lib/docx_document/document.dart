import 'dart:io';

import 'package:docx_template/docx_template.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class DocumentGenerationPage extends StatefulWidget {
  @override
  _DocumentGenerationPageState createState() => _DocumentGenerationPageState();
}

class _DocumentGenerationPageState extends State<DocumentGenerationPage> {
  String _downloadedFilePath = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Document Generation Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: generateDocument,
              child: Text('Generate Document'),
            ),
            SizedBox(height: 16),
            if (_downloadedFilePath.isNotEmpty)
              ElevatedButton(
                onPressed: downloadDocument,
                child: Text('Download Document'),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> generateDocument() async {
    final f = File("template.docx");
    final docx = await DocxTemplate.fromBytes(await f.readAsBytes());

    /*
    Or in the case of Flutter, you can use rootBundle.load, then get bytes

    final data = await rootBundle.load('lib/assets/users.docx');
    final bytes = data.buffer.asUint8List();

    final docx = await DocxTemplate.fromBytes(bytes);
  */

    // Load test image for inserting in docx
    final testFileContent = await File('test.jpg').readAsBytes();

    final listNormal = ['Foo', 'Bar', 'Baz'];
    final listBold = ['ooF', 'raB', 'zaB'];

    final contentList = <Content>[];

    final b = listBold.iterator;
    for (var n in listNormal) {
      b.moveNext();

      final c = PlainContent("value")
        ..add(TextContent("normal", n))
        ..add(TextContent("bold", b.current));
      contentList.add(c);
    }

    Content c = Content();
    c
      ..add(TextContent("docname", "Simple docname"))
      ..add(TextContent("passport", "Passport NE0323 4456673"))
      ..add(TableContent("table", [
        RowContent()
          ..add(TextContent("key1", "Paul"))
          ..add(TextContent("key2", "Viberg"))
          ..add(TextContent("key3", "Engineer"))
          ..add(ImageContent('img', testFileContent)),
        RowContent()
          ..add(TextContent("key1", "Alex"))
          ..add(TextContent("key2", "Houser"))
          ..add(TextContent("key3", "CEO & Founder"))
          ..add(ListContent("tablelist", [
            TextContent("value", "Mercedes-Benz C-Class S205"),
            TextContent("value", "Lexus LX 570")
          ]))
          ..add(ImageContent('img', testFileContent))
      ]))
      ..add(ListContent("list", [
        TextContent("value", "Engine")
          ..add(ListContent("listnested", contentList)),
        TextContent("value", "Gearbox"),
        TextContent("value", "Chassis")
      ]))
      ..add(ListContent("plainlist", [
        PlainContent("plainview")
          ..add(TableContent("table", [
            RowContent()
              ..add(TextContent("key1", "Paul"))
              ..add(TextContent("key2", "Viberg"))
              ..add(TextContent("key3", "Engineer")),
            RowContent()
              ..add(TextContent("key1", "Alex"))
              ..add(TextContent("key2", "Houser"))
              ..add(TextContent("key3", "CEO & Founder"))
              ..add(ListContent("tablelist", [
                TextContent("value", "Mercedes-Benz C-Class S205"),
                TextContent("value", "Lexus LX 570")
              ]))
          ])),
        PlainContent("plainview")
          ..add(TableContent("table", [
            RowContent()
              ..add(TextContent("key1", "Nathan"))
              ..add(TextContent("key2", "Anceaux"))
              ..add(TextContent("key3", "Music artist"))
              ..add(ListContent(
                  "tablelist", [TextContent("value", "Peugeot 508")])),
            RowContent()
              ..add(TextContent("key1", "Louis"))
              ..add(TextContent("key2", "Houplain"))
              ..add(TextContent("key3", "Music artist"))
              ..add(ListContent("tablelist", [
                TextContent("value", "Range Rover Velar"),
                TextContent("value", "Lada Vesta SW Sport")
              ]))
          ])),
      ]))
      ..add(ListContent("multilineList", [
        PlainContent("multilinePlain")
          ..add(TextContent('multilineText', 'line 1')),
        PlainContent("multilinePlain")
          ..add(TextContent('multilineText', 'line 2')),
        PlainContent("multilinePlain")
          ..add(TextContent('multilineText', 'line 3'))
      ]))
      ..add(TextContent('multilineText2', 'line 1\nline 2\n line 3'))
      ..add(ImageContent('img', testFileContent));

    final d = await docx.generate(c);
    final of = File('generated.docx');
    if (d != null) await of.writeAsBytes(d);
  }

  Future<void> downloadDocument() async {
    if (_downloadedFilePath.isNotEmpty) {
      final originalFile = File(_downloadedFilePath);
      final documentsDir = await getExternalStorageDirectory();
      final destinationPath = '${documentsDir!.path}/заявление.docx';
      final newFile = await originalFile.copy(destinationPath);
      setState(() {
        _downloadedFilePath = '';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File downloaded successfully')),
      );
    }
  }

  String getCurrentDate() {
    final currentDate = DateTime.now();
    final formattedDate =
        '${currentDate.day}.${currentDate.month}.${currentDate.year}';
    return formattedDate;
  }
}
