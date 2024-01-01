import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../themes/app_fonts.dart';
import '../placeholder_screen.dart';

class Header extends StatefulWidget {
  final String name;
  const Header({super.key, required this.name});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  Future<String?> setUrlAvatar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      String? kidId = prefs.getString('kidId');

      if (kidId != null) {
        // Thực hiện truy vấn để lấy URL avatar từ Firestore
        DocumentSnapshot kidSnapshot = await firestore.collection('Kids').doc(kidId).get();

        // Kiểm tra xem tài liệu có tồn tại không
        if (kidSnapshot.exists) {
          String? urlAvatar = kidSnapshot['urlAvatar'];
          return urlAvatar;
        }
      }
    } catch (e) {
      // Xử lý lỗi
      print('Lỗi khi lấy URL avatar từ Firestore: $e');
    }

    // Trả về null nếu có lỗi hoặc không tìm thấy URL avatar
    return '';
  }

  @override
  void initState() {
    // TODO: implement initState
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
                      child: FutureBuilder(
                          future: setUrlAvatar(),
                          builder: (context, snapshot) {
                            String urlAvt = snapshot.data ?? '';
                            return urlAvt != ''
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(999),
                                    child: Image.network(
                                      urlAvt!,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Text(
                                    widget.name != '' ? widget.name[0] : '',
                                    style: AppFont.primaryFont.copyWith(color: Colors.white),
                                  );
                          })),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.name,
                        style: AppFont.primaryFont.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Container(
                height: 40,
                width: 40,
                child: TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return PlaceHolderScreen();
                      },
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: Image(
                    image: AssetImage("assets/images/icons8-no-reminders-50.png"),
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
