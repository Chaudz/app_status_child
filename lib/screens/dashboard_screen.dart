import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:myapp/utils/constants.dart';

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
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot = await firestore.collection('actives').get();

      setState(() {
        totalActives = querySnapshot.size.toInt();
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getSizeAllByName(String name) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot = await firestore
          .collection('actives')
          .where('name', isEqualTo: name)
          .get();

      setState(() {
        if (name == AppConstants.BOTTLE_FEEDING) {
          bottleFeedingActive =
              (querySnapshot.size.toDouble() / totalActives) * 100;
        } else if (name == AppConstants.BOWEL_MOVEMENT) {
          bowelMovementActive =
              (querySnapshot.size.toDouble() / totalActives) * 100;
        } else if (name == AppConstants.SLEEPING) {
          sleepingActive = (querySnapshot.size.toDouble() / totalActives) * 100;
        } else if (name == AppConstants.EATING) {
          eatingActive = (querySnapshot.size.toDouble() / totalActives) * 100;
        } else {
          urinationActive =
              (querySnapshot.size.toDouble() / totalActives) * 100;
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
      children: [
        Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/thiep-chuc-giang-sinh-online.gif'),
                fit: BoxFit.cover,
              ),
            )),
        Text(
          'Tổng quan',
          style: TextStyle(
            fontFamily: 'Rubik',
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Chọn khoảng thời gian",
                      style: AppFont.primaryFont
                          .copyWith(fontSize: 20, fontWeight: FontWeight.w600),
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
                                color: Colors.grey),
                          ),
                          onTap: () {
                            // Xử lý sự lựa chọn nếu cần
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
              borderRadius:
                  BorderRadius.circular(10), // Thiết lập border radius
            ),
            child: Container(
              padding: EdgeInsets.all(10), // Padding cho nút
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tất cả thời gian'),
                    ],
                  ),
                  Icon(Icons.keyboard_arrow_down_sharp,
                      size: 35, color: Colors.black),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
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
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
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
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Indicator(
                    color: Color(0xBD2096D5),
                    text: '${AppConstants.EATING}',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Indicator(
                    color: Color(0xE88DCCF5),
                    text: AppConstants.SLEEPING,
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Indicator(
                    color: Colors.pinkAccent,
                    text: '${AppConstants.BOWEL_MOVEMENT}',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Indicator(
                    color: Color(0x8EEF0592),
                    text: '${AppConstants.BOTTLE_FEEDING}',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Indicator(
                    color: Color(0xE8BFFFF8),
                    text: '${AppConstants.URINATION}',
                    isSquare: true,
                  ),
                ],
              ),
              const SizedBox(
                width: 28,
              ),
            ],
          ),
        ),
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
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.black),
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
