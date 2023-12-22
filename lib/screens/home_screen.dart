import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:myapp/screens/homepage_screen.dart';
import 'package:myapp/screens/layouts/header.dart';
import 'package:myapp/screens/record_screen.dart';
import 'package:myapp/screens/stats_screen.dart';
import 'package:myapp/themes/app_colors.dart';
import 'package:myapp/themes/app_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  String kidName = "";
  String? kidId;

  final List<Widget> _screens = [
    HomePageScreen(),
    RecordScreen(),
    StatsScreen(),
    // OverviewScreen(),
    // AccountScreen()
  ];

  Future<String?> _getKidName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? kidId = prefs.getString('kidId');

    if (kidId != null) {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance.collection('Kids').doc(kidId).get();
      String babyName = documentSnapshot.data()?['name'] ?? '';
      await prefs.setString('nameKid', babyName);
      return babyName;
    }

    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: _getKidName(),
              builder: (context, snapshot) {
                String name = snapshot.data ?? '';
                return Header(name: name);
              },
            ),
            _screens[_currentIndex],
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'Trang chủ',
            icon: Image(
                image: AssetImage('assets/images/icons8-home-24.png'),
                width: 20,
                height: 20,
                color: AppColor.grayColor),
          ),
          BottomNavigationBarItem(
            label: "Bản ghi",
            icon: Image(
                image: AssetImage('assets/images/icons8-in-inventory-50.png'),
                width: 20,
                height: 20,
                color: AppColor.grayColor),
          ),
          BottomNavigationBarItem(
            label: "Thống kê",
            icon: Image(
              image: AssetImage('assets/images/icons8-chart-50.png'),
              width: 20,
              height: 20,
            ),
          ),
          BottomNavigationBarItem(
            label: "Tổng quan",
            icon: Image(
              image: AssetImage('assets/images/icons8-doughnut-chart-64.png'),
              width: 20,
              height: 20,
            ),
          ),
          BottomNavigationBarItem(
            label: "Tài khoản",
            icon: Image(
              image: AssetImage('assets/images/icons8-user-30.png'),
              width: 20,
              height: 20,
            ),
          ),
        ],
        selectedItemColor: AppColor.secondColor,
        unselectedItemColor: Colors.blue,
        showSelectedLabels: true, // Ẩn label khi được chọn
        showUnselectedLabels: false, // Ẩn label khi không được chọn
      ),
    );
  }
}
