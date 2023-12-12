import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/themes/app_fonts.dart';
import 'package:myapp/widgets/next_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myapp/themes/app_colors.dart';
class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
            Text('Hãy tuỳ chỉnh ứng dụng của bạn', style: AppFont.primaryFont,textAlign: TextAlign.center),
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
               onPressed: ()=>{
                    Navigator.pushNamed(context, '/gender')
               },
               style: ElevatedButton.styleFrom(
                 padding: EdgeInsets.only(right: 30,left: 30,top: 15,bottom: 15),
                 backgroundColor: Color.fromRGBO(255, 127, 135, 1.0)
               ),
               child: Text('Bắt đầu',style: AppFont.primaryFont.copyWith(
                 color: Colors.white,
                 fontSize: 15,fontWeight: FontWeight.w600
               ),)),
            SizedBox(
              height: 30,
            ),
            Text('Tôi có một tài khoản hoặc lời mời',style:AppFont.primaryFont.copyWith( fontSize: 15)),
            SizedBox(
              height: 5
            ),
            TextButton(onPressed: ()=>{
              Navigator.pushNamed(context, '/loginScreen')
            },
                child: Text('Đăng nhập', style: AppFont.primaryFont.copyWith(
                  color: Color.fromRGBO(255, 127, 135, 1.0),
                  fontSize: 15,
                  fontWeight: FontWeight.w600
                ),))
          ],
        ),
      )
    );
  }
}

class GenderBaby extends StatefulWidget {
  const GenderBaby({super.key});

  @override
  State<GenderBaby> createState() => _GenderBabyState();
}

class _GenderBabyState extends State<GenderBaby> {
  bool isGirl = true;
  String gender = 'gái';

  @override
  void initState() {
    super.initState();
  }

  void setGender(bool gender) {
    setState(() {
      isGirl = gender;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 100, left: 30, right: 30),
          child: Column(
            children: [
              Text('Em bé của bạn là gái hay trai?', style: AppFont.primaryFont.copyWith(
                fontWeight: FontWeight.w600,
              ),),
              SizedBox(
                height: 10
              ),
              Text('Nếu là sinh đôi, bạn có thể thêm hồ sơ em bé còn lại sau', style: AppFont.primaryFont.copyWith(
                fontSize: 16,
              ),),
              SizedBox(
                height: 100
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                       onPressed: ()async {
                         SharedPreferences prefs = await SharedPreferences.getInstance();
                         await prefs.setString('gender', 'girl');
                         setGender(true);
                         gender = 'gái';
                       },
                       style: ElevatedButton.styleFrom(
                         padding: EdgeInsets.all(15),
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(30.0),
                           side: BorderSide(
                             color: (isGirl? Colors.pinkAccent : Colors.white),
                             width: 4.0
                           )
                         ),
                         backgroundColor: Colors.white,
                       ),
                       child: Image(image: AssetImage('assets/images/girl-icon.png'),)
                   ),
                  ElevatedButton(
                      onPressed: ()async{
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.setString('gender', 'boy');
                        setGender(false);
                        gender = 'trai';
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(
                                color: (!isGirl? Colors.pinkAccent : Colors.white),
                                width: 4.0
                            )
                        ),
                        backgroundColor: Colors.white,
                      ),
                      child: Image(image:AssetImage('assets/images/boy-icon.png'),width: 100,)
                  ),
                ],
              ),
              SizedBox(
                height: 40
              ),
              NextButton(nameRouter: "/nameBaby",argumentValue: gender,)
            ],
          ),
        ),
      )
    );
  }
}

class NameBaby extends StatefulWidget {
  const NameBaby({super.key});

  @override
  State<NameBaby> createState() => _NameBabyState();
}

class _NameBabyState extends State<NameBaby> {
  TextEditingController nameController = TextEditingController();
  String nameBaby = '';

  @override
  Widget build(BuildContext context) {
    String? gender = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      backgroundColor: AppColor.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 50, left: 30, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Bé $gender của bạn tên gì?', style: AppFont.primaryFont.copyWith(
                  fontWeight: FontWeight.w600,
              ),),
              SizedBox(
                height: 10,
              ),
              Text('Bạn có thể thay đổi những dữ liệu này sau',style: AppFont.primaryFont.copyWith(
                  fontSize: 15,
              ),),
              Container(
                height: 200,
                width: 350,
                decoration: BoxDecoration(
                  // color: Colors.lightGreen,
                  image:  DecorationImage(
                    image: AssetImage('assets/images/onboard1.gif'),
                    // fit: BoxFit.cover,
                  ),
                ),
              ),
              Text('Tên em bé', style: AppFont.primaryFont.copyWith(
                  fontSize: 15,color: Colors.white
              ),),
              SizedBox(
                  height: 10
              ),
              TextField(
                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                controller: nameController,
                onChanged: (value)=>{
                  setState((){
                    nameBaby = value;
                  })
                },
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: 'Thêm tên',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white
                    ),
                    filled: true, // Bật chế độ filled
                    fillColor: Colors.pink[200],
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(40.0),borderSide: BorderSide.none)
                ),
              ),
              SizedBox(
                  height: 40
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: nameBaby.trim() != '' ? ()async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.setString('nameBaby',nameBaby);
                        Navigator.pushNamed(context, '/birthdayBaby');
                      }: null,
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.only(top: 15, bottom: 15, right: 30,left: 30),
                          backgroundColor: Colors.pinkAccent,
                      ),
                      child: Text('Tiếp', style:
                      nameBaby.trim() != '' ?
                      AppFont.primaryFont.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                      ):
                      AppFont.primaryFont.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                      )
                      )
                  )
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}

class BirthdayBaby extends StatefulWidget {
  const BirthdayBaby({super.key});

  @override
  State<BirthdayBaby> createState() => _BirthdayBabyState();
}

class _BirthdayBabyState extends State<BirthdayBaby> {
  DateTime date = DateTime(2016, 10, 26);
  DateTime time = DateTime(2016, 5, 10, 22, 35);
  DateTime dateTime = DateTime(2016, 8, 3, 17, 45);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Padding(
        padding: EdgeInsets.only(top: 50, left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text('Bé được sinh ra vào khi nào?', style: AppFont.primaryFont.copyWith(
               fontWeight: FontWeight.w600
           ),),
           SizedBox(
             height: 10,
           ),
           Text('Bạn có thể thay đổi những dữ liệu này sau',style: AppFont.primaryFont.copyWith(
               fontSize: 15
           ),),
           Container(
             height: 200,
             width: 350,
             decoration: BoxDecoration(
               // color: Colors.lightGreen,
               image:  DecorationImage(
                 image: AssetImage('assets/images/onboard1.gif'),
                 // fit: BoxFit.cover,
               ),
             ),
           ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 100,
            child:  CupertinoDatePicker(

              mode: CupertinoDatePickerMode.date,
              initialDateTime: date,
              use24hFormat: true,

              onDateTimeChanged: (DateTime newTime) {
                setState(() => date = newTime);
              },
            ),
          ),
           SizedBox(
             height: 20,
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               ElevatedButton(
                   onPressed: ()=>{
                     Navigator.pushNamed(context, '/avatarBaby')
                   },
                   style: ElevatedButton.styleFrom(
                       padding: EdgeInsets.only(top: 15, bottom: 15, right: 30,left: 30),
                       backgroundColor: Colors.pinkAccent
                   ),
                   child: Text('Tiếp',style: AppFont.primaryFont.copyWith(
                       fontSize: 18,
                       fontWeight: FontWeight.w600,
                       color: Colors.white
                   ),))
             ],
           ),

         ],
        ),
      ),
    );
  }
}

class AvatarBaby extends StatefulWidget {
  const AvatarBaby({super.key});

  @override
  State<AvatarBaby> createState() => _AvatarBabyState();
}

class _AvatarBabyState extends State<AvatarBaby> {
  String nameBaby = '';
  PlatformFile? pickedFile;
  // UploadTask? uploadTask;

  Future uploadFile() async {
    print("1111111111111111111111111111");
    final path = 'file/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    await  ref.putFile(file);

    final urlDowload = await ref.getDownloadURL();
    print('Download Link: $urlDowload');
  }

  Future selectFile()async{
    final result = await FilePicker.platform.pickFiles();
    print(result);
    if(result == null) return;

    setState(() {
      pickedFile = result.files.first;
      print("2222222222222222222222222222");
      print(pickedFile);
    });

    // if (pickedFile != null) {
    //   await uploadFile();
    // }
    // else{
    //   print("00000000000000000000000000000000000000000000000000000000000000000000000");
    // }
  }


  void getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nameBaby = prefs.getString('nameBaby') ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    getName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Padding(
        padding: EdgeInsets.only(top: 50, left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text('Bạn có muốn thêm một bức ảnh?', style: AppFont.primaryFont.copyWith(
               fontWeight: FontWeight.w600
             ),),
          SizedBox(
          height: 10,
            ),
          Text('Chọn ảnh yêu thích của bạn hoặc thêm ảnh sau',style: AppFont.primaryFont.copyWith(
          fontSize: 15
           ),),
            SizedBox(
              height: 50
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    ElevatedButton(
                      onPressed: selectFile,
                      style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          minimumSize: Size(150, 150),
                          backgroundColor: Colors.pinkAccent
                      ),
                      child: pickedFile != null ?
                     Container(
                       child: ClipRRect(
                         borderRadius: BorderRadius.circular(999),
                         child: Image.file(
                             File(pickedFile!.path!),
                             width: 150,
                             height: 150,
                             fit: BoxFit.cover
                         ),
                       ),
                     )
                       :
                      nameBaby.isNotEmpty? Text(nameBaby[0].toUpperCase(),style: AppFont.primaryFont.copyWith(
                          fontSize: 90,
                          fontWeight: FontWeight.bold,
                          color: Colors.white ),) : Text("")
                    ),
                    ElevatedButton(onPressed: uploadFile, child: Text('Upload')),
                    Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.black45,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.camera_alt_sharp,size: 40,color: Colors.white,)
                        )
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: ()=>{
                      Navigator.pushNamedAndRemoveUntil(context,"/createInfo",(route) => false )
                    },
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.only(top: 15, bottom: 15, right: 30,left: 30),
                        backgroundColor: Colors.pinkAccent
                    ),
                    child: Text('Tiếp',style: AppFont.primaryFont.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white
                    ),))
              ],
            ),
        ],
      ),
      )
    );
  }
}

