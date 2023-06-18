import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kodeks/fetches/select_category_fetche.dart';
import 'package:kodeks/model/category_model.dart';
import 'package:kodeks/model/instruction_model.dart';
import 'package:kodeks/service/api_service.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class InstructionScreen extends StatefulWidget {
  int id;

  InstructionScreen(this.id, {Key? key});

  @override
  State<InstructionScreen> createState() => _InstructionScreenState();
}

class _InstructionScreenState extends State<InstructionScreen> {
  late Future<dynamic> htmlData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    htmlData = ApiService().getInstructionDocument(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder(
          future: htmlData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return WebViewPlus(
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (controller) {
                  controller.loadString(snapshot.data);
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("hasError"));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
