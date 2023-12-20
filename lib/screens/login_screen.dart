import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/services/auth_service.dart';
import 'package:myapp/themes/app_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 30, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                    onPressed: ()=>{
                      Navigator.pop(context)
                    },
                    style: TextButton.styleFrom(
                        shape: CircleBorder()
                    ),
                    child: Icon(Icons.close,color: Colors.black,)
                ),
                Container(
                  width: double.infinity,
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Đăng nhập', style: AppFont.primaryFont.copyWith(
                          fontWeight: FontWeight.w600
                      ),),
                      Text('Đăng nhập vô tài khoản bạn hoặc đăng ký',
                        style:  AppFont.primaryFont.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w600
                        ),),
                    ],
                  ),
                ),

                SizedBox(
                    height: 80
                ),
                Text('Ứng dụng của chúng tôi hoàn toàn ẩn danh khi sử dụng và không yêu cầu đăng '
                    'ký bằng tên thật của bạn. Tất cả dữ liệu của bạn trong ứng dụng sẽ không và'
                    ' không thể được sử dụng để nhận dạng danh tính',style: AppFont.primaryFont.copyWith(
                    fontSize: 15
                ),),
                SizedBox(
                    height: 60
                ),
                ElevatedButton(
                    onPressed: ()async {
                      print('dddddddddddddddd');
                      var connectivityResult = await Connectivity().checkConnectivity();

                      print('ccccccccccccccccccccccccccc');
                      if (connectivityResult == ConnectivityResult.none) {
                        // Không có kết nối mạng
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                "Lỗi",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red, // Màu sắc của tiêu đề
                                ),
                              ),
                              content: Text(
                                "Không có kết nối mạng. Vui lòng kiểm tra kết nối của bạn.",
                                style: TextStyle(
                                  color: Colors.black, // Màu sắc của nội dung
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: Text(
                                    "Đóng",
                                    style: TextStyle(
                                      color: Colors.blue, // Màu sắc của nút
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Đóng dialog
                                  },
                                ),
                              ],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0), // Độ cong của các góc
                              ),
                              backgroundColor: Colors.white, // Màu nền của dialog
                              elevation: 5, // Độ nâng của dialog
                            );
                          },
                        );
                        return;
                      }

                      User? user = await AuthService().signInWithGoogle();
                      if (user != null) {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        try {
                          var users = FirebaseFirestore.instance.collection('Users');
                          QuerySnapshot querySnapshot = await users.where('email', isEqualTo: user.email).get();

                          if (querySnapshot.docs.isNotEmpty) {
                            String existingUserId = querySnapshot.docs.first.id;
                            prefs.setString('userId', existingUserId);
                          } else {
                            // Email chưa tồn tại, thêm mới dữ liệu
                            DocumentReference userRef = await users.add({
                              'name': user.displayName,
                              'email': user.email,
                            });
                            // Lấy ID của tài liệu vừa được thêm
                            String documentId = userRef.id;
                            prefs.setString('userId', documentId);
                          }
                        } catch (e) {
                          print("Lỗi: $e");
                        }
                        Navigator.pushNamedAndRemoveUntil(context,'/addBaby', (route)=> false );
                      } else {
                        print("Google sign-in failed.");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(15),
                      backgroundColor: Color(0xFFFFFFFF),
                      side: BorderSide(width: 1,color: Colors.black12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/google-icon.png'),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text('Tiếp tục với Google',style: AppFont.primaryFont.copyWith(
                            fontSize: 15
                        )),
                      ],
                    )),
                SizedBox(
                    height: 15
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Bằng cách đăng nhập, bạn đồng ý với:',style: AppFont.primaryFont.copyWith(
                        fontSize: 15
                    ),textAlign: TextAlign.start),
                    GestureDetector(
                      onTap:  () async {

                      },
                      child: Text('Điều khoản dịch vụ',style: AppFont.primaryFont.copyWith(
                          fontSize: 15,
                          decoration: TextDecoration.underline
                      ),),
                    ),
                    GestureDetector(
                      onTap: ()=>{},
                      child: Text('Chính sách bảo mật',style: AppFont.primaryFont.copyWith(
                          fontSize: 15,
                          decoration: TextDecoration.underline
                      ),),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}
