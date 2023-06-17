import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kodeks/fetches/select_category_fetche.dart';
import 'package:kodeks/model/category_model.dart';
import 'package:kodeks/model/instruction_model.dart';

class InstructionScreen extends StatefulWidget {
  int id;
  InstructionScreen(this.id, {Key? key});

  @override
  State<InstructionScreen> createState() => _InstructionScreenState();
}

class _InstructionScreenState extends State<InstructionScreen> {
  late Future<InstructionModel> instructionByIdCategory;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    instructionByIdCategory = fetchInstructionByIdCategory(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: instructionByIdCategory,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: Column(
                  children: [
                    Text(snapshot.data!.data!.first.title ?? "title"),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(snapshot.data!.data!.first.instruction ??
                        "instruction"),
                  ],
                ),
              );
            } else if (snapshot.hasError)
              return Center(
                child: Text('hasError'),
              );
            else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
