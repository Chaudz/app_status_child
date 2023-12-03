import 'package:flutter/material.dart';
import 'package:myapp/themes/app_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                  onPressed: ()=>{},
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
      )
    );
  }
}
