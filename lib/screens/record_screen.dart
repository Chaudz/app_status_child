import 'package:flutter/material.dart';
import 'package:myapp/screens/layouts/header.dart';
import 'package:myapp/themes/app_fonts.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:  Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 20, right: 20),
        child: Column(
          children: [
            Text('Bản ghi', style: AppFont.primaryFont,),

          ],
        ),
      )
    );
  }
}
