import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/screens/placeholder_screen.dart';
import 'package:myapp/themes/app_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecordSettingScreen extends StatefulWidget {
  @override
  State<RecordSettingScreen> createState() => _RecordSettingScreenState();
}

class _RecordSettingScreenState extends State<RecordSettingScreen> {
  Future<String?> _getKidName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? kidId = prefs.getString('kidId');

    if (kidId != null) {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance.collection('Kids').doc(kidId).get();
      String babyName = documentSnapshot.data()?['name'] ?? '';
      await prefs.setString('nameKid', babyName);
      return babyName;
    }

    return null;
  }

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
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.pink.shade100,
                      border: Border.all(
                        color: Colors.pink.shade100, // Màu của border
                        width: 2.0, // Độ dày của border
                      ),
                      borderRadius: BorderRadius.circular(14), // Độ cong của border
                    ),
                    height: 140,
                    width: screenWidth, // Sử dụng chiều rộng của màn hình
                    child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Không bao giờ mất dữ liệu của bạn!',
                              style: TextStyle(
                                color: Colors.brown.shade700, // Màu của văn bản
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Để đồng bộ hóa và khôi phục dữ liệu, bạn cần tạo tài khoản hoặc đăng nhập.',
                              style: TextStyle(
                                fontSize: 15,

                                color: Colors.black54,
                                // Màu của văn bản
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            GestureDetector(
                              child: InkWell(
                                onTap: () {
                                  // Xử lý khi nút được nhấn
                                },
                                child: ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return PlaceHolderScreen();
                                      },
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.white, fixedSize: Size(150, 35)),
                                  child: Text(
                                    'Đăng Nhập',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.brown.shade700,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(14), // Độ cong của border
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade500,
                          offset: const Offset(4.0, 4.0),
                          blurRadius: 15,
                          spreadRadius: 1.0,
                        ),
                        BoxShadow(
                          color: Colors.white,
                          offset: const Offset(-4.0, -4.0),
                          blurRadius: 15,
                          spreadRadius: 1.0,
                        )
                      ],
                    ),
                    height: 140,
                    width: screenWidth, // Sử dụng chiều rộng của màn hình
                    child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Các tính năng tiên tiến',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            GestureDetector(
                              child: ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return PlaceHolderScreen();
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.pink.shade300, fixedSize: Size(190, 40)),
                                child: Text(
                                  'Nhận gói Premium',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white, // Màu của văn bản
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Hồ sơ',
                        style:
                            AppFont.primaryFont.copyWith(fontSize: 20, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return PlaceHolderScreen();
                        },
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                height: 50,
                                width: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
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
                                          : FutureBuilder(
                                              future: _getKidName(),
                                              builder: (context, snapshot) {
                                                String name = snapshot.data ?? '';
                                                return Text(
                                                  name,
                                                  style: AppFont.primaryFont
                                                      .copyWith(color: Colors.white),
                                                );
                                              },
                                            );
                                    })),
                            SizedBox(
                              width: 5,
                            ),
                            Column(
                              children: [
                                FutureBuilder(
                                  future: _getKidName(),
                                  builder: (context, snapshot) {
                                    String name = snapshot.data ?? '';
                                    return Text(
                                      name,
                                      style: AppFont.primaryFont.copyWith(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        Icon(
                          Icons.more_vert,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 3,
              color: Colors.black12,
            ),
            Container(
              height: 50,
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return PlaceHolderScreen();
                    },
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Cài đặt',
                      textAlign: TextAlign.start,
                      style:
                          AppFont.primaryFont.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 3,
              color: Colors.black12,
            ),
            Container(
              height: 50,
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/overview');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Thông tin ứng dụng',
                      textAlign: TextAlign.start,
                      style:
                          AppFont.primaryFont.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
