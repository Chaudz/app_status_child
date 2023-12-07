import 'package:flutter/material.dart';
import 'package:myapp/themes/app_fonts.dart';

class NextButton extends StatelessWidget {
  final String nameRouter;
  final String? argumentValue;

  const NextButton({Key? key, required this.nameRouter,this.argumentValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
        onPressed: ()=>{
          Navigator.pushNamed(context, nameRouter,arguments: argumentValue)
        },
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.only(top: 15, bottom: 15, right: 30,left: 30),
            backgroundColor: Colors.pinkAccent
        ),
        child: Text('Tiếp',style: AppFont.primaryFont.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white
        ),));
  }
}
