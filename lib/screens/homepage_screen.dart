import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/screens/placeholder_screen.dart';
import 'package:myapp/themes/app_colors.dart';
import 'package:myapp/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../themes/app_fonts.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Bảng điều khiển",
                style: AppFont.primaryFont.copyWith(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              Container(
                height: 40,
                width: 40,
                child: TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return PlaceHolderScreen();
                        },
                      );
                    },
                    child: Image(
                      image: AssetImage('assets/images/icons8-control-24.png'),
                      width: 20,
                      height: 20,
                      fit: BoxFit.cover,
                    )),
              )
            ],
          ),
        ),
        ButtonsActive(),
        Container(
          height: 5,
          width: double.infinity,
          color: Colors.black12,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hôm nay',
                    style: AppFont.primaryFont.copyWith(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    child: TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return PlaceHolderScreen();
                            },
                          );
                        },
                        child: Image(
                          image: AssetImage('assets/images/icons8-control-24.png'),
                          width: 20,
                          height: 20,
                          fit: BoxFit.cover,
                        )),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  StreamBuilder(
                      stream: firestore.collection('actives').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        return buildWidgetFromSnapshot(snapshot);
                      }),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildWidgetFromSnapshot(AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<int> countDocumentsWithId(String name, String kidId) async {
    DateTime now = DateTime.now();
    DateTime startOfDay = DateTime(now.year, now.month, now.day);
    DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59); // Kết thúc ngày

    QuerySnapshot querySnapshot = await firestore
        .collection('actives')
        .where('name', isEqualTo: name)
        .where('kidId', isEqualTo: kidId)
        .where('startTime', isGreaterThanOrEqualTo: startOfDay)
        .where('startTime', isLessThanOrEqualTo: endOfDay)
        .get();
    print(querySnapshot.size);
    return querySnapshot.size;
  }

  Future<String?> getKidId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('kidId');
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      FutureBuilder<String?>(
        future: getKidId(),
        builder: (context, userIdSnapshot) {
          String? userId = userIdSnapshot.data;
          return FutureBuilder<int>(
            future: countDocumentsWithId(AppConstants.SLEEPING, userId ?? ''),
            builder: (context, sleepSnapshot) {
              int sleepCount = sleepSnapshot.data ?? 0;
              return Container(
                width: 200,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image(
                          image: AssetImage(AppConstants.SLEEPING_IMG),
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          AppConstants.SLEEPING,
                          style: AppFont.fontActives,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Text(
                      '$sleepCount',
                      style: AppFont.fontActivesCount,
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
      SizedBox(height: 10),
      FutureBuilder<String?>(
        future: getKidId(),
        builder: (context, userIdSnapshot) {
          String? userId = userIdSnapshot.data;
          return FutureBuilder<int>(
            future: countDocumentsWithId(AppConstants.BOTTLE_FEEDING, userId ?? ''),
            builder: (context, drinkBollteMilkSnapshot) {
              int drinkBollteMilkCount = drinkBollteMilkSnapshot.data ?? 0;
              return Container(
                width: 200,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image(
                          image: AssetImage(AppConstants.BOTTLE_FEEDING_IMG),
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          AppConstants.BOTTLE_FEEDING,
                          style: AppFont.fontActives,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Text(
                      '$drinkBollteMilkCount',
                      style: AppFont.fontActivesCount,
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
      SizedBox(height: 10),
      FutureBuilder<String?>(
        future: getKidId(),
        builder: (context, userIdSnapshot) {
          String? userId = userIdSnapshot.data;
          return FutureBuilder<int>(
            future: countDocumentsWithId(AppConstants.URINATION, userId ?? ''),
            builder: (context, urinationSnapshot) {
              int urinationCount = urinationSnapshot.data ?? 0;
              return Container(
                width: 200,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image(
                          image: AssetImage(AppConstants.URINATION_IMG),
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          AppConstants.URINATION,
                          style: AppFont.fontActives,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Text(
                      '$urinationCount',
                      style: AppFont.fontActivesCount,
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
      SizedBox(height: 10),
      FutureBuilder<String?>(
        future: getKidId(),
        builder: (context, userIdSnapshot) {
          String? userId = userIdSnapshot.data;
          return FutureBuilder<int>(
            future: countDocumentsWithId(AppConstants.BOWEL_MOVEMENT, userId ?? ''),
            builder: (context, bowelMovementSnapshot) {
              int bowelMovementCount = bowelMovementSnapshot.data ?? 0;
              return Container(
                width: 200,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image(
                          image: AssetImage(AppConstants.BOWEL_MOVEMENT_IMG),
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          AppConstants.BOWEL_MOVEMENT,
                          style: AppFont.fontActives,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Text(
                      '$bowelMovementCount',
                      style: AppFont.fontActivesCount,
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
      SizedBox(height: 10),
      FutureBuilder<String?>(
        future: getKidId(),
        builder: (context, userIdSnapshot) {
          String? userId = userIdSnapshot.data;
          return FutureBuilder<int>(
            future: countDocumentsWithId(AppConstants.EATING, userId ?? ''),
            builder: (context, eatingSnapshot) {
              int eatingCount = eatingSnapshot.data ?? 0;
              return Container(
                width: 200,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image(
                          image: AssetImage(AppConstants.EATING_IMG),
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          AppConstants.EATING,
                          style: AppFont.fontActives,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Text(
                      '$eatingCount',
                      style: AppFont.fontActivesCount,
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
      SizedBox(height: 10),
    ],
  );
}

class ActiveTime extends StatefulWidget {
  const ActiveTime(
      {super.key,
      required this.urlImage,
      required this.activeName,
      required this.hiddenActiveTime});

  final String urlImage;
  final String activeName;
  final VoidCallback hiddenActiveTime;

  @override
  State<ActiveTime> createState() => _ActiveTimeState();
}

class _ActiveTimeState extends State<ActiveTime> {
  bool isRunning = true;
  Timer? timer;
  int elapsedTimeInSeconds = 0;
  DateTime startTime = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    stopTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        elapsedTimeInSeconds++;
      });
    });
  }

  String currentTimeToString() {
    var now = DateTime.now();
    var formatter = DateFormat('HH:mm');
    return formatter.format(now);
  }

  String elapsedTimeToString() {
    int hours = elapsedTimeInSeconds ~/ 3600;
    int minutes = (elapsedTimeInSeconds % 3600) ~/ 60;
    int seconds = elapsedTimeInSeconds % 60;

    String formattedTime =
        '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

    return formattedTime;
  }

  void stopTimer() {
    timer?.cancel();
  }

  void saveRecord() async {
    CollectionReference actives = FirebaseFirestore.instance.collection('actives');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? kidId = await prefs.getString('kidId');

    actives.add({
      'name': widget.activeName,
      'startTime': startTime,
      'endTime': DateTime.now(),
      'seconds': elapsedTimeInSeconds,
      'kidId': kidId ?? '',
      'urlImg': widget.urlImage
    }).then((value) {
      print("User Added==============================");
      widget.hiddenActiveTime();
    }).catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        children: [
          TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: null,
              ),
              child: Image(
                image: AssetImage(widget.urlImage),
                width: 30,
                height: 30,
                fit: BoxFit.cover,
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(currentTimeToString()),
              Text(widget.activeName),
            ],
          ),
          SizedBox(
            width: 30,
          ),
          Text(elapsedTimeToString()),
          isRunning
              ? TextButton(
                  onPressed: () {
                    setState(() {
                      stopTimer();
                      isRunning = false;
                    });
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(CircleBorder()),
                  ),
                  child: Image(
                    image: AssetImage('assets/images/icons8-pause-24.png'),
                    width: 25,
                    height: 25,
                  ),
                )
              : TextButton(
                  onPressed: () {
                    setState(() {
                      startTimer();
                      isRunning = true;
                    });
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(CircleBorder()),
                  ),
                  child: Image(
                    image: AssetImage('assets/images/icons8-right-30.png'),
                    width: 25,
                    height: 25,
                  ),
                ),
          TextButton(
              onPressed: () {
                saveRecord();
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(CircleBorder()),
              ),
              child: Image(
                image: AssetImage('assets/images/icons8-square-50.png'),
                width: 20,
                height: 20,
              ))
        ],
      ),
    );
  }
}

class ButtonsActive extends StatefulWidget {
  const ButtonsActive({super.key});
  @override
  State<ButtonsActive> createState() => _ButtonsActiveState();
}

class _ButtonsActiveState extends State<ButtonsActive> {
  bool showActiveTime = false;
  int id = 0;

  List<Map<String, dynamic>> listActive = [
    {'urlImage': AppConstants.EATING_IMG, 'activeName': AppConstants.EATING},
    {'urlImage': AppConstants.SLEEPING_IMG, 'activeName': AppConstants.SLEEPING},
    {'urlImage': AppConstants.URINATION_IMG, 'activeName': AppConstants.URINATION},
    {'urlImage': AppConstants.BOWEL_MOVEMENT_IMG, 'activeName': AppConstants.BOWEL_MOVEMENT},
    {'urlImage': AppConstants.BOTTLE_FEEDING_IMG, 'activeName': AppConstants.BOTTLE_FEEDING},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColor.background),
            child: Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                children: [
                  for (int i = 0; i < listActive.length; i++)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () async {
                            setState(() {
                              if (showActiveTime) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      title: Row(
                                        children: [
                                          Text("Lưu ý! ",
                                              style: AppFont.primaryFont.copyWith(
                                                  fontSize: 20, fontWeight: FontWeight.w600)),
                                          Image(
                                            image: AssetImage('assets/images/icons8-error-64.png'),
                                            width: 30,
                                            height: 30,
                                          )
                                        ],
                                      ),
                                      content: Text("Bạn cần lưu lại bản ghi trước đó"),
                                      actions: [
                                        TextButton(
                                          child: Text(
                                            "Đóng",
                                            style: AppFont.primaryFont.copyWith(fontSize: 15),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop(); // Đóng dialog
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                showActiveTime = true;
                                id = i;
                              }
                            });
                          },
                          style: ButtonStyle(
                            overlayColor: MaterialStateColor.resolveWith(
                              (states) {
                                if (states.contains(MaterialState.pressed)) {
                                  // Color when pressed
                                  return Colors.pinkAccent.withOpacity(0.5);
                                }
                                // Default color
                                return Colors.pinkAccent.withOpacity(0.3);
                              },
                            ),
                          ),
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.pinkAccent.withOpacity(0.3),
                            ),
                            child: Center(
                                child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Image(
                                image: AssetImage(listActive[i]['urlImage']),
                              ),
                            )),
                          ),
                        ),
                        SizedBox(height: 8),
                        // Khoảng cách giữa button và tiêu đề
                        Text(listActive[i]['activeName'], style: AppFont.fontActives),
                      ],
                    )
                ],
              ),
            ),
          ),
        ),
        showActiveTime
            ? ActiveTime(
                urlImage: listActive[id]['urlImage'],
                activeName: listActive[id]['activeName'],
                hiddenActiveTime: () {
                  setState(() {
                    showActiveTime = false;
                  });
                },
              )
            : Text('')
      ],
    );
  }
}
