import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/models/active_model.dart';
import 'package:myapp/themes/app_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  int numberDay = 0; // mặc định là 0 nó sẽ render tất cả dữ liệu, 6: 6 ngày vừa qua,..
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  Future<dynamic> getAllDocumentsWithIdAndDate() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? kidId = prefs.getString('kidId');

    if (numberDay != 0) {
      startDate = DateTime.now().subtract(Duration(days: numberDay));
      QuerySnapshot querySnapshot = await firestore
          .collection('actives')
          .where('kidId', isEqualTo: kidId)
          .where('startTime', isGreaterThanOrEqualTo: startDate)
          .where('startTime', isLessThanOrEqualTo: endDate)
          .get();
      return querySnapshot.docs;
    } else {
      QuerySnapshot querySnapshot =
          await firestore.collection('actives').where('kidId', isEqualTo: kidId).get();
      return querySnapshot.docs;
    }
  }

  Future<void> _handleDeleteActive(String activeId) async {
    bool shouldDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Xác nhận xóa",
            textAlign: TextAlign.center,
          ),
          content: Text("Bạn có chắc muốn xóa dữ liệu này?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.orange),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: Colors.red, width: 1),
                  ),
                ),
              ),
              child: Text(
                "Đồng ý",
                style: AppFont.primaryFont.copyWith(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: Colors.green, width: 1),
                  ),
                ),
              ),
              child: Text(
                "Hủy",
                style: AppFont.primaryFont.copyWith(
                  fontSize: 15,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true) {
      await FirebaseFirestore.instance.collection('actives').doc(activeId).delete();
      setState(() {});
      Navigator.of(context).pop(true);
      print("Đã xóa dữ liệu với ID: $activeId");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bản ghi',
            style: AppFont.primaryFont,
          ),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Chọn khoảng thời gian",
                        style:
                            AppFont.primaryFont.copyWith(fontSize: 20, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center),
                    backgroundColor: Colors.white,
                    content: IntrinsicHeight(
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              'Tất cả thời gian',
                              style: AppFont.primaryFont.copyWith(
                                  fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey),
                            ),
                            onTap: () {
                              // Xử lý sự lựa chọn nếu cần
                              Navigator.of(context).pop();
                              setState(() {
                                numberDay = 0;
                                endDate = DateTime.now();
                              });
                            },
                          ),
                          ListTile(
                            title: Text(
                              '7 ngày qua',
                              style: AppFont.primaryFont.copyWith(
                                  fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey),
                            ),
                            onTap: () {
                              // Xử lý sự lựa chọn nếu cần
                              Navigator.of(context).pop();
                              setState(() {
                                numberDay = 7;
                                startDate = DateTime.now().subtract(Duration(days: numberDay));
                              });
                            },
                          ),
                          ListTile(
                            title: Text(
                              '14 ngày qua',
                              style: AppFont.primaryFont.copyWith(
                                  fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey),
                            ),
                            onTap: () {
                              // Xử lý sự lựa chọn nếu cần
                              Navigator.of(context).pop();
                              setState(() {
                                numberDay = 14;
                                startDate = DateTime.now().subtract(Duration(days: numberDay));
                              });
                            },
                          ),
                          ListTile(
                            title: Text(
                              '30 ngày qua',
                              style: AppFont.primaryFont.copyWith(
                                  fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey),
                            ),
                            onTap: () {
                              // Xử lý sự lựa chọn nếu cần
                              Navigator.of(context).pop();
                              setState(() {
                                numberDay = 30;
                                startDate = DateTime.now().subtract(Duration(days: numberDay));
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  );
                },
              );
            },
            splashColor: Colors.black12,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.transparent, // Đặt màu nền là màu trong suốt
                borderRadius: BorderRadius.circular(10), // Thiết lập border radius
              ),
              child: Container(
                padding: EdgeInsets.all(10), // Padding cho nút
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          numberDay == 0 ? 'Tất cả thời gian' : '${numberDay} ngày qua',
                          style: AppFont.primaryFont
                              .copyWith(fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          numberDay == 0
                              ? ''
                              : "${DateFormat('dd/MM/yyyy').format(startDate)} - ${DateFormat('dd/MM/yyyy').format(endDate)}",
                          style: AppFont.primaryFont.copyWith(fontSize: 15),
                        ),
                      ],
                    ),
                    Icon(Icons.keyboard_arrow_down_sharp, size: 35, color: Colors.black),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          FutureBuilder(
            key: UniqueKey(),
            future: getAllDocumentsWithIdAndDate(),
            builder: (context, activesSnapshot) {
              dynamic allActive = activesSnapshot.data ?? '';
              if (allActive != '') {
                // Danh sách chứa các widget RowActive
                List<Widget> rowActives = [];

                for (var snapshot in allActive) {
                  Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
                  // Lấy timestamp từ Firestore
                  Timestamp timestamp1 = data['startTime'] as Timestamp;
                  DateTime dateTime1 = timestamp1.toDate();
                  Timestamp timestamp2 = data['endTime'] as Timestamp;
                  DateTime dateTime2 = timestamp2.toDate();

                  int seconds = data['seconds'];
                  int hour1 = dateTime1.hour;
                  int minute1 = dateTime1.minute;
                  int hour2 = dateTime2.hour;
                  int minute2 = dateTime2.minute;
                  String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime1);
                  // Thêm widget RowActive vào danh sách
                  rowActives.add(
                    RowActive(
                      name: data['name'],
                      urlImg: data['urlImg'],
                      startTimeHour: hour1,
                      startTimeMinute: minute1,
                      endTimeHour: hour2,
                      endTimeMinute: minute2,
                      date: formattedDate,
                      activeId: snapshot.id,
                      seconds: seconds,
                      onDelete: () {
                        _handleDeleteActive(snapshot.id);
                      },
                    ),
                  );
                }

                // Trả về danh sách các widget RowActive
                return Column(
                  children: rowActives,
                );
              } else {
                return Text('');
              }
            },
          )
        ],
      ),
    );
  }
}

class RowActive extends StatefulWidget {
  final String? name;
  final String? urlImg;
  final int? startTimeHour;
  final int? startTimeMinute;
  final int? endTimeHour;
  final int? endTimeMinute;
  final String? date;
  final String? activeId;
  final Function onDelete;
  final int? seconds;
  RowActive(
      {Key? key,
      this.name,
      this.urlImg,
      this.startTimeHour,
      this.startTimeMinute,
      this.date,
      this.activeId,
      required this.onDelete,
      this.endTimeHour,
      this.endTimeMinute,
      this.seconds})
      : super(key: key);

  @override
  State<RowActive> createState() => _RowActiveState();
}

class _RowActiveState extends State<RowActive> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/activeDetail',
              arguments: Active(
                widget.name,
                widget.urlImg,
                widget.date,
                widget.startTimeHour,
                widget.startTimeMinute,
                widget.activeId,
                widget.onDelete,
                widget.endTimeHour,
                widget.endTimeMinute,
                widget.seconds,
              ),
            );
          },
          splashColor: Colors.black12,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Ink(
            decoration: BoxDecoration(
              color: Colors.transparent, // Đặt màu nền là màu trong suốt
              borderRadius: BorderRadius.circular(10), // Thiết lập border radius
            ),
            child: Container(
              padding: EdgeInsets.all(10), // Padding cho nút
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image(
                        image: AssetImage(widget.urlImg!),
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.startTimeHour.toString().padLeft(2, '0')}:${widget.startTimeMinute.toString().padLeft(2, '0')}',
                            style: AppFont.primaryFont.copyWith(
                                fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey),
                          ),
                          Text(
                            '${widget.name}',
                            style: AppFont.primaryFont
                                .copyWith(fontSize: 15, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios_outlined)
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 2,
          width: double.infinity,
          color: Colors.black12,
        )
      ],
    );
  }
}

class ActiveDetail extends StatefulWidget {
  const ActiveDetail({
    Key? key,
  }) : super(key: key);

  @override
  State<ActiveDetail> createState() => _ActiveDetailState();
}

class _ActiveDetailState extends State<ActiveDetail> {
  @override
  Widget build(BuildContext context) {
    Active? active = ModalRoute.of(context)?.settings.arguments as Active?;

    return Scaffold(
        appBar: AppBar(title: Text('Bản ghi'), actions: [
          TextButton(
            onPressed: () {
              active?.onDelete();
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all(CircleBorder()),
            ),
            child: Icon(Icons.delete, color: Colors.black),
          ),
        ]),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('${active?.urlImg}'),
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${active?.name}',
                      style:
                          AppFont.primaryFont.copyWith(fontSize: 15, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              Container(
                height: 3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.black12),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Chi tiết',
                      style:
                          AppFont.primaryFont.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Bắt đầu',
                          style: AppFont.primaryFont.copyWith(
                            fontSize: 17,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '${active?.date}',
                              style: AppFont.primaryFont.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              '${active?.startHour.toString().padLeft(2, '0')}:${active?.startMinute.toString().padLeft(2, '0')}',
                              style: AppFont.primaryFont.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Kết thúc',
                          style: AppFont.primaryFont.copyWith(
                            fontSize: 17,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '${active?.date}',
                              style: AppFont.primaryFont.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              '${active?.endHour.toString().padLeft(2, '0')}:${active?.endMinute.toString().padLeft(2, '0')}',
                              style: AppFont.primaryFont.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Thời gian:',
                          style: AppFont.primaryFont.copyWith(
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          '${active?.seconds} giây',
                          style: AppFont.primaryFont.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
