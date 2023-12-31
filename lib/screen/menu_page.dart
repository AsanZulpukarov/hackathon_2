import 'package:flutter/material.dart';
import 'package:kodeks/screen/instruction/topic_category_screen.dart';
import 'package:kodeks/screen/petition_screen/list_petitions_screen.dart';
import 'package:kodeks/screen/profile_screen/lawyer_profile_screen.dart';
import 'package:kodeks/screen/profile_screen/user_profile_screen.dart';
import 'package:kodeks/screen/questions.dart';
import 'package:kodeks/screen/questions/questionsPage.dart';

import '../colors.dart';
import 'doc/select_document/select_doc.dart';

class MenuPage extends StatefulWidget {
  String role;

  MenuPage(this.role, {Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int index = 0;
  late List<Widget> screens;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    screens = [
      ChatScreenGPT(),
      SelectDoc(),
      TopicCategoryScreen(),
      QuestionsPage(),
      ListPetition(),
      widget.role == "ROLE_LAWYER"
          ? LawyerProfileScreen()
          : UserProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child: screens[index]),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            child: BottomNavigationBar(
              elevation: 20,
              currentIndex: index,
              selectedItemColor: kGreenColor,
              selectedIconTheme: IconThemeData(color: kGreenColor),
              unselectedIconTheme: IconThemeData(color: Colors.black),
              unselectedItemColor: Colors.black,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              onTap: (ind) {
                setState(() => index = ind);
              },
              type: BottomNavigationBarType.fixed,
              backgroundColor: Color(0xffF4F4F4),
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.chat,
                    ),
                    label: 'Чат'),
                BottomNavigationBarItem(

                    // icon: Icon(
                    // Icons.play_arrow_outlined,
                    icon: Icon(
                      Icons.edit_document,
                    ),
                    label: 'Документы'),
                BottomNavigationBarItem(

                    // icon: Icon(
                    // Icons.play_arrow_outlined,
                    icon: Icon(
                      Icons.menu,
                    ),
                    label: 'Категории'),
                BottomNavigationBarItem(

                    // icon: Icon(
                    // Icons.play_arrow_outlined,
                    icon: Icon(
                      Icons.question_mark,
                    ),
                    label: 'Вопросы'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.record_voice_over_outlined,
                    ),
                    label: 'Петиции'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.account_box,
                    ),
                    label: 'Профиль'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
