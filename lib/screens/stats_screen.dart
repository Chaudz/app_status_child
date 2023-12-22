import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/themes/app_fonts.dart';
import 'package:myapp/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatefulWidget> createState() => StatsScreenState();
}

class StatsScreenState extends State<StatsScreen> {
  int selectedButtonIndex = 0;
  String nameCurrentActive = AppConstants.BOTTLE_FEEDING;
  DateTime selectedDate = DateTime.now();

  Future<double> getActiveSizeToday()async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    String? kidId = prefs.getString('kidId');

    QuerySnapshot querySnapshot = await firestore.
    collection('actives')
        .where('kidId', isEqualTo: kidId)
        .where('name', isEqualTo: nameCurrentActive)
        .where('startTime', isGreaterThanOrEqualTo: today)
        .where('startTime', isLessThan: today.add(Duration(days: 1)))
        .get();

    return querySnapshot.size.toDouble();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getActiveSizeToday();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Thống kê',
          style: TextStyle(
            fontFamily: 'Rubik',
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.red
          ),
        ),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ButtonActive(
                  isPressed: selectedButtonIndex == 0,
                  onPressed: () {
                    setState(() {
                      selectedButtonIndex = 0;
                    });
                  },
                  urlImg: AppConstants.BOTTLE_FEEDING_IMG,
                  name: AppConstants.BOTTLE_FEEDING,
                ),
                ButtonActive(
                  isPressed: selectedButtonIndex == 1,
                  onPressed: () {
                    setState(() {
                      selectedButtonIndex = 1;
                      nameCurrentActive =  AppConstants.EATING;
                    });
                  },
                  urlImg: AppConstants.EATING_IMG,
                  name: AppConstants.EATING,
                ),
                ButtonActive(
                  isPressed: selectedButtonIndex == 2,
                  onPressed: () {
                    setState(() {
                      selectedButtonIndex = 2;
                      nameCurrentActive =  AppConstants.BOWEL_MOVEMENT;
                    });
                  },
                  urlImg: AppConstants.BOWEL_MOVEMENT_IMG,
                  name: AppConstants.BOWEL_MOVEMENT,
                ),
                ButtonActive(
                  isPressed: selectedButtonIndex == 3,
                  onPressed: () {
                    setState(() {
                      selectedButtonIndex = 3;
                      nameCurrentActive =  AppConstants.SLEEPING;
                    });
                  },
                  name: AppConstants.SLEEPING,
                  urlImg: AppConstants.SLEEPING_IMG,
                ),
                ButtonActive(
                  isPressed: selectedButtonIndex == 4,
                  onPressed: () {
                    setState(() {
                      selectedButtonIndex = 4;
                      nameCurrentActive =  AppConstants.URINATION;
                    });
                  },
                  name: AppConstants.URINATION,
                  urlImg: AppConstants.URINATION_IMG,
                ),
              ],
            )
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child:   InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Chọn khoảng thời gian", style: AppFont.primaryFont.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                    ),textAlign: TextAlign.center),
                    backgroundColor: Colors.white,
                    content: IntrinsicHeight(
                      child: Column(
                        children: [
                          ListTile(
                            title: Text('Hôm nay', style: AppFont.primaryFont.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color:Colors.grey
                            ),),
                            onTap: () {
                              // Xử lý sự lựa chọn nếu cần
                              Navigator.of(context).pop();
                              setState(() {
                                selectedDate = DateTime.now();
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
                         'Hôm nay',
                          style: AppFont.primaryFont.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        Text(
                          "${DateFormat('dd/MM/yyyy').format(selectedDate)}",
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
        ),
        Container(
          height: 300,
          width: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: FutureBuilder(
              future: getActiveSizeToday(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.done){
                  return BarChart(
                    BarChartData(
                      barTouchData: barTouchData,
                      titlesData: titlesData,
                      borderData: borderData,
                      barGroups: [
                        BarChartGroupData(
                          x: 0,
                          barRods: [
                            BarChartRodData(
                              width: 70,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              toY: snapshot.data!,
                              gradient: _barsGradient,
                            ),
                          ],
                          showingTooltipIndicators: [0],
                        ),
                      ],
                      gridData: const FlGridData(show: false),
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 20,
                    ),
                  );
                }else{
                  return Container();
                };
              },
          )
        )
      ],
    );
  }

  BarTouchData get barTouchData => BarTouchData(
    enabled: false,
    touchTooltipData: BarTouchTooltipData(
      tooltipBgColor: Colors.transparent,
      tooltipPadding: EdgeInsets.zero,
      tooltipMargin: 8,
      getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
          ) {
        return BarTooltipItem(
          rod.toY.round().toString(),
          const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),
        );
      },
    ),
  );

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: Colors.orange,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 30,
        getTitlesWidget: getTitles,
      ),
    ),
    leftTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    rightTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
  );

  FlBorderData get borderData => FlBorderData(
    show: false,
  );

  LinearGradient get _barsGradient => LinearGradient(
    colors: [
      Colors.red,
      Colors.orange,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  List<BarChartGroupData> get barGroups => [

  ];
}


class ButtonActive extends StatefulWidget {
  final bool isPressed;
  final VoidCallback onPressed;
  final name;
  final urlImg;

  const ButtonActive({
    required this.isPressed,
    required this.onPressed,
    Key? key, this.name, this.urlImg,
  }) : super(key: key);

  @override
  ButtonActiveState createState() => ButtonActiveState();
}

class ButtonActiveState extends State<ButtonActive> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(5),
        backgroundColor: widget.isPressed ? Colors.lightBlueAccent : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(widget.urlImg),
            height: 20,
            width: 20,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 8.0),
          Text(
            widget.name,
            style: TextStyle(
              color:widget.isPressed ?Colors.white: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
