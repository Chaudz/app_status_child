import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../themes/app_fonts.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  String? urlAvt;

  Future<void> setUrlAvatar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      urlAvt = prefs.getString('avatar');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    setUrlAvatar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 30, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(999)),
                    ),
                    child: urlAvt != null ?
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: Image.network(
                        urlAvt!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,),
                    ) :
                    Text("D", style: AppFont.primaryFont.copyWith(
                        color: Colors.white
                    ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('D', style: AppFont.primaryFont.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w600
                      ),),
                      Text("1 ngày", style: AppFont.primaryFont.copyWith(
                          color: Colors.black12,
                          fontSize: 15,
                          fontWeight: FontWeight.w600
                      ),)
                    ],
                  )
                ],
              ),
              TextButton(
                onPressed: () {
                  // Handle button press
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                ),
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/icons8-no-reminders-50.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 20)
      ],
    );
  }
}