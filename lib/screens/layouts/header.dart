import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../themes/app_fonts.dart';

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
        } else {
          // Xử lý khi không tìm thấy tài liệu
          print('Không tìm thấy tài liệu với ID $kidId trong collection "kids"');
        }
      } else {
        // Xử lý khi kidId là null
        print('Không có kidId trong SharedPreferences');
      }
    } catch (e) {
      // Xử lý lỗi
      print('Lỗi khi lấy URL avatar từ Firestore: $e');
    }

    // Trả về null nếu có lỗi hoặc không tìm thấy URL avatar
    return null;
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
                      builder: (context,snapshot){
                        String? urlAvt = snapshot.data;
                        return urlAvt != null ?
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
                        );
                      }
                    )
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(
                    widget.name,
                    style: AppFont.primaryFont.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                      Text("kid", style: AppFont.primaryFont.copyWith(
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