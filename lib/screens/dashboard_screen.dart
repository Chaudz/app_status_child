import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:myapp/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../themes/app_fonts.dart';
import '../widgets/indicator.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => DashBoardScreenState();
}

class DashBoardScreenState extends State<DashBoardScreen> {
  int touchedIndex = -1;
  int totalActives = 0;
  double eatingActive = 0;
  double urinationActive = 0;
  double sleepingActive = 0;
  double bowelMovementActive = 0;
  double bottleFeedingActive = 0;

  Future<void> getAllActive() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String kidId = prefs.getString('kidId') ?? '';
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot =
          await firestore.collection('actives').where('kidId', isEqualTo: kidId).get();

      setState(() {
        totalActives = querySnapshot.size.toInt();
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getSizeAllByName(String name) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String kidId = await prefs.getString('kidId') ?? '';
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot = await firestore
          .collection('actives')
          .where('name', isEqualTo: name)
          .where('kidId', isEqualTo: kidId)
          .get();

      setState(() {
        if (name == AppConstants.BOTTLE_FEEDING) {
          bottleFeedingActive = (querySnapshot.size.toDouble() / totalActives) * 100;
        } else if (name == AppConstants.BOWEL_MOVEMENT) {
          bowelMovementActive = (querySnapshot.size.toDouble() / totalActives) * 100;
        } else if (name == AppConstants.SLEEPING) {
          sleepingActive = (querySnapshot.size.toDouble() / totalActives) * 100;
        } else if (name == AppConstants.EATING) {
          eatingActive = (querySnapshot.size.toDouble() / totalActives) * 100;
        } else {
          urinationActive = (querySnapshot.size.toDouble() / totalActives) * 100;
        }
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await getAllActive();
    await getSizeAllByName(AppConstants.EATING);
    await getSizeAllByName(AppConstants.URINATION);
    await getSizeAllByName(AppConstants.SLEEPING);
    await getSizeAllByName(AppConstants.BOWEL_MOVEMENT);
    await getSizeAllByName(AppConstants.BOTTLE_FEEDING);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tổng quan',
                style: AppFont.primaryFont.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 23,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Wrap(
                runSpacing: 10.0,
                children: [
                  Container(
                    width: 100,
                    child: Row(
                      children: [
                        Container(
                          height: 20,
                          width: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Color(0xBD2096D5),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('${AppConstants.EATING}'),
                      ],
                    ),
                  ),
                  Container(
                    width: 100,
                    child: Row(
                      children: [
                        Container(
                          height: 20,
                          width: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Color(0xE88DCCF5),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('${AppConstants.SLEEPING}'),
                      ],
                    ),
                  ),
                  Container(
                    width: 100,
                    child: Row(
                      children: [
                        Container(
                          height: 20,
                          width: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.pinkAccent,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('${AppConstants.BOWEL_MOVEMENT}'),
                      ],
                    ),
                  ),
                  Container(
                    width: 100,
                    child: Row(
                      children: [
                        Container(
                          height: 20,
                          width: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Color(0x8EEF0592),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('${AppConstants.BOTTLE_FEEDING}'),
                      ],
                    ),
                  ),
                  Container(
                    width: 100,
                    child: Row(
                      children: [
                        Container(
                          height: 20,
                          width: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Color(0xE8BFFFF8),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('${AppConstants.URINATION}'),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
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
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                          onTap: () {
                            // Xử lý sự lựa chọn nếu cần
                            Navigator.of(context).pop();
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
                        'Tất cả thời gian',
                        style: AppFont.primaryFont.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.keyboard_arrow_down_sharp, size: 35, color: Colors.black),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        if (totalActives > 0)
          AspectRatio(
            aspectRatio: 1.7,
            child: Row(
              children: <Widget>[
                const SizedBox(
                  height: 18,
                ),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback: (FlTouchEvent event, pieTouchResponse) {
                            setState(() {
                              if (!event.isInterestedForInteractions ||
                                  pieTouchResponse == null ||
                                  pieTouchResponse.touchedSection == null) {
                                touchedIndex = -1;
                                return;
                              }
                              touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                            });
                          },
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                        sections: showingSections(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 28,
                ),
              ],
            ),
          )
        else
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Không có hoạt động nào',
              )
            ],
          )
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(5, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 16.0 : 8.0;
      final radius = isTouched ? 60.0 : 50.0;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Color(0x8EEF0592),
            value: bottleFeedingActive,
            title: '${bottleFeedingActive.toStringAsFixed(2)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.pinkAccent,
            value: bowelMovementActive,
            title: '${bowelMovementActive.toStringAsFixed(2)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Color(0xBD2096D5),
            value: eatingActive,
            title: '${eatingActive.toStringAsFixed(2)}%',
            radius: radius,
            titleStyle:
                TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.black),
          );
        case 3:
          return PieChartSectionData(
            color: Color(0xE88DCCF5),
            value: sleepingActive,
            title: '${sleepingActive.toStringAsFixed(2)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          );
        case 4:
          return PieChartSectionData(
            color: Color(0xE8BFFFF8),
            value: urinationActive,
            title: '${urinationActive.toStringAsFixed(2)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
