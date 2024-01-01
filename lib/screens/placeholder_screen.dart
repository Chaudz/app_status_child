import 'package:flutter/material.dart';

class PlaceHolderScreen extends StatelessWidget {
  const PlaceHolderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Text(
            'ĐANG PHÁT TRIỂN ...',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Rất tiếc, chức năng đang được phát triển, vui lòng quay lại sau!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey,
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      shadowColor: Colors.black,
      titleTextStyle: TextStyle(color: Colors.red),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Đóng',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              )),
        )
      ],
    );
  }
}
