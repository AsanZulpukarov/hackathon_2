import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kodeks/fetches/select_category_fetche.dart';
import 'package:kodeks/model/instruction_model.dart';

class SelectTopicCategoryScreen extends StatefulWidget {
  List<dynamic> idAndName;
  SelectTopicCategoryScreen(this.idAndName, {Key? key}) : super(key: key);

  @override
  State<SelectTopicCategoryScreen> createState() =>
      _SelectTopicCategoryScreenState();
}

class _SelectTopicCategoryScreenState extends State<SelectTopicCategoryScreen> {
  late Future<InstructionModel> futureInstructionModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureInstructionModel =
        fetchInstructionByIdCategory(widget.idAndName.first);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.idAndName.last),
      ),
      body: FutureBuilder(
        future: futureInstructionModel,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.data!.length,
              itemBuilder: (context, int index) {
                return Container(
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data!.data!.elementAt(index).title ?? "",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          /*Text(
                            snapshot.data!.data!.elementAt(index).instruction ??
                                "",
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                overflow: TextOverflow.ellipsis),
                          ),*/
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.calendar_month,
                                  color: Theme.of(context).primaryColor),
                              Text(snapshot.data!.data!
                                      .elementAt(index)
                                      .updatedAt ??
                                  snapshot.data!.data!
                                      .elementAt(index)
                                      .createdAt ??
                                  ""
                                      "Даты нет"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, "/category/instructions/id",
                          arguments: snapshot.data!.data!.elementAt(index).id);
                    },
                  ),
                );
              },
            );
            ;
          } else if (snapshot.hasError) {
            return Center(child: Text("hasError"));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
