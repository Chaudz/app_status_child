import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/themes/app_fonts.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/onboard1.gif')
                )
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Hãy tuỳ chỉnh ứng dụng của bạn', style: AppFont.primaryFont,),
            SizedBox(
              height: 45
            ),
            Text('Đây là lần đầu tôi sử dụng', style: AppFont.primaryFont.copyWith(
              fontWeight: FontWeight.normal,
              fontSize: 15
            ),),
           SizedBox(
             height: 5,
           ),
           ElevatedButton(
               onPressed: ()=>{},
               style: ElevatedButton.styleFrom(
                 padding: EdgeInsets.only(right: 30,left: 30,top: 10,bottom: 10),
                 backgroundColor: Colors.red,
               ),
               child: Text('Bắt đầu',style: AppFont.primaryFont.copyWith(
                 color: Colors.white,
                 fontSize: 15
               ),)),
            SizedBox(
              height: 20,
            ),
            Text('Tôi có một tài khoản hoặc lời mời'),
            TextButton(onPressed: ()=>{},
                child: Text('Đăng nhập', style: AppFont.primaryFont.copyWith(
                  color: Colors.red,
                  fontSize: 15
                ),))
          ],
        ),
      )
    );
  }
}
