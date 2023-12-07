import 'package:flutter/material.dart';
import 'package:myapp/themes/app_colors.dart';
import 'package:myapp/themes/app_fonts.dart';

class AddBabyScreen extends StatefulWidget {
  const AddBabyScreen({super.key});

  @override
  State<AddBabyScreen> createState() => _AddBabyScreenState();
}

class _AddBabyScreenState extends State<AddBabyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child:Center(
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: ()=>{
                    Navigator.pushNamed(context, '/addBabyDetail')
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryColor
                  ),
                  child: Text("Thêm em bé",style: AppFont.primaryFont.copyWith(
                    fontSize: 20,
                    color: Colors.white
                  ),)
              ),
              SizedBox(
                  height: 10
              ),
              Text("Bạn có thể tạo một hồ sơ em bé mới",style: AppFont.primaryFont.copyWith(
                fontSize: 15
              ),)
            ],
          ),
        )
      )
    );
  }
}

class AddBabyDetail extends StatefulWidget {
  const AddBabyDetail({super.key});

  @override
  State<AddBabyDetail> createState() => _AddBabyDetailState();
}

class _AddBabyDetailState extends State<AddBabyDetail> {
  bool isBoy = false;
  DateTime selectedDate = DateTime.now();
  String nameBaby = "";

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Thêm em bé',style: AppFont.primaryFont.copyWith(),),),
      body:SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
          ),
          child:Padding(
            padding: EdgeInsets.all(10),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ElevatedButton(
                                onPressed: ()=>{

                                },
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(10),
                                    shape: CircleBorder(),
                                    backgroundColor: Colors.white
                                ),
                                  child: nameBaby != "" ?
                                  Text(nameBaby![0],style: AppFont.primaryFont.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 21,
                                      color: Colors.green
                                  ),):
                                  Image(image: AssetImage("assets/images/icons8-user-30.png"),),
                            ),
                            Positioned(
                                top: 0,
                                right: 0,
                                child:  Icon(Icons.camera_alt_rounded)
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                        height: 10
                    ),
                    Text("Tên em bé"),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      style: AppFont.primaryFont.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w600
                      ),
                      onChanged: (value) {
                        setState(() {
                          nameBaby = value;
                        });
                      },
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                            color: Colors.black,  // Màu đen cho đường viền
                            width: 2.0,            // Độ rộng của đường viền
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                            color: Colors.black,  // Màu đen cho đường viền
                            width: 1.0,            // Độ rộng của đường viền
                          ),
                        ),
                        label: Text("Thêm tên"),
                      ),
                      cursorColor: Colors.black12,
                    ),
                    SizedBox(
                        height: 20
                    ),
                    Row(
                      children: [
                        Expanded(child:   ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isBoy? Colors.white: Colors.pinkAccent,
                            ),
                            onPressed:  ()=>{
                              setState(() {
                                isBoy = false;
                              })
                            },
                            child: Row(
                              children: [
                                Image(image: AssetImage("assets/images/girl-icon.png"),width: 30),
                                Text('Gái',style: AppFont.primaryFont.copyWith(
                                    color: isBoy? Colors.black: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600
                                ),)
                              ],
                            )
                        ),
                        ),
                        SizedBox(width: 5,),
                        Expanded(child:   ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isBoy? Colors.pinkAccent:  Colors.white,
                            ),
                            onPressed: ()=>{
                              setState(() {
                                isBoy = true;
                              })
                            },
                            child: Row(
                              children: [
                                Image(image: AssetImage("assets/images/boy-icon.png"),width: 30),
                                Text('Trai',style: AppFont.primaryFont.copyWith(
                                    color: isBoy? Colors.white : Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600
                                ),)
                              ],
                            )
                        ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Sinh nhật"),
                        ElevatedButton(
                            onPressed: ()=> selectDate(context),
                            style: ElevatedButton.styleFrom(
                              elevation: 0.0,
                            ),
                            child: Text('${selectedDate.day} tháng ${selectedDate.month}, ${selectedDate.year} ',style: AppFont.primaryFont.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),))
                      ],
                    ),
                    SizedBox(
                        height: 30
                    ),
                    Text("Bình luận"),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      style: AppFont.primaryFont.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w600
                      ),
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                            color: Colors.black,  // Màu đen cho đường viền
                            width: 2.0,            // Độ rộng của đường viền
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                            color: Colors.black,  // Màu đen cho đường viền
                            width: 1.0,            // Độ rộng của đường viền
                          ),
                        ),
                        label: Text("Ví dụ dự ứng với..."),
                      ),
                      cursorColor: Colors.black12,
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 10,),
                    ElevatedButton(
                        onPressed: ()=>{},
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.only(top: 5,bottom: 5,left: 40,right: 40),
                            backgroundColor: AppColor.primaryColor
                        ),
                        child: Text("Lưu",style: AppFont.primaryFont.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),)
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

