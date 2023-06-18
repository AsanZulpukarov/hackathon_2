import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kodeks/fetches/fetch_select_petition.dart';
import 'package:kodeks/model/petition_model.dart';
import 'package:kodeks/service/api_service.dart';

class SelectPetitionScreen extends StatefulWidget {
  int id;
  SelectPetitionScreen(this.id,{Key? key});

  @override
  State<SelectPetitionScreen> createState() => _SelectPetitionScreenState();
}

class _SelectPetitionScreenState extends State<SelectPetitionScreen> {

  late Future<PetitionModel> futurePetition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futurePetition = fetchSelectPetition(widget.id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: FutureBuilder(
            future: futurePetition,
            builder: (context,snapshot) {
              if(snapshot.hasData) {
                return Column(
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width*0.8,
                          height: MediaQuery.of(context).size.height*0.35,
                          child: Image.network("http://${ApiService.ip}:2323/storage/${snapshot.data?.oneData!.photo ?? ""}")),
                    ),

                    Text(snapshot.data!.oneData!.title ?? "title"),
                    SizedBox(height: 20.h,),
                    Text(snapshot.data!.oneData!.description ?? "description"),
                  ],
                );
              }
              else if(snapshot.hasError) return Center(child: Text('hasError'),);
              else{
                return Center(child: CircularProgressIndicator(),);
              }
            }
        ),
      ),
    );
  }
}
