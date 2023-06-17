import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kodeks/fetches/category_fetche.dart';
import 'package:kodeks/model/category_model.dart';

class TopicCategoryScreen extends StatefulWidget {
  const TopicCategoryScreen({Key? key}) : super(key: key);

  @override
  State<TopicCategoryScreen> createState() => _TopicCategoryScreenState();
}

class _TopicCategoryScreenState extends State<TopicCategoryScreen> {
  late Future<CategoryModel> categoryFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryFuture = fetchCategory();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Категории"),
      ),
      body: FutureBuilder(
        future: categoryFuture,
        builder: (context,snapshot){
          if(snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.data!.length,
              itemBuilder: (context, int index) {return Container(
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(12.0),
                child: InkWell(
                  child: Container(

                    padding: const EdgeInsets.all(10),
                    child: Text(
                        snapshot.data!.data!.elementAt(index).name ?? "",style: TextStyle(fontSize: 20),
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                        context, "/category/instructions",arguments:  [snapshot.data!.data!.elementAt(index).id,snapshot.data!.data!.elementAt(index).name]);
                  },
                ),
              );
              },
            );;
          }
          else if(snapshot.hasError){
            return Center(child: Text(
              "hasError"
            ));
          }
          else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
