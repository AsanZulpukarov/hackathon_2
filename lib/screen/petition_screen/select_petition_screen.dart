import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kodeks/fetches/fetch_select_petition.dart';
import 'package:kodeks/model/likesQuestionModel.dart';
import 'package:kodeks/model/petition_model.dart';
import 'package:kodeks/service/api_service.dart';
import 'package:provider/provider.dart';

import '../../fetches/fetchLikesQuestion.dart';
import '../doc/select_document/select_doc_provider.dart';

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
                        width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height*0.4,
                          child: Image.network("http://${ApiService.ip}:2323/storage/${snapshot.data?.oneData!.photo ?? ""}")),
                    ),
                    FutureBuilder<LikesQuestionModel>(
                      future: fetchLikesQuestion(
                        widget.id.toString(),
                        Provider.of<SelectCatProvider>(context, listen: false)
                            .userId,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasData) {
                          var path = snapshot.data!.data!;
                          return Container(
                            child: Column(
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    if (!path.isLiked!)
                                      await ApiService().postLikeQuestion(
                                        questionId: widget.id.toString(),
                                        userId: Provider.of<SelectCatProvider>(
                                          context,
                                          listen: false,
                                        ).userId,
                                      );

                                    if (path.isLiked!)
                                      await ApiService().deleteLikesQuestion(
                                        widget.id.toString(),
                                        Provider.of<SelectCatProvider>(context,
                                          listen: false,
                                        ).userId,
                                      );
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    Icons.thumb_up,
                                    color: path.isLiked! ? Colors.red : Colors.grey,
                                  ),
                                ),
                                Text(
                                  path.count.toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                    SizedBox(height: 20.h,),
                    Text(snapshot.data!.oneData!.title ?? "title",style: TextStyle(fontSize: 24),),
                    SizedBox(height: 20.h,),
                    Text(snapshot.data!.oneData!.description ?? "description",style: TextStyle(fontSize: 20),),
                    SizedBox(height: 25.h,),

                    SizedBox(height: 25.h,),


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
