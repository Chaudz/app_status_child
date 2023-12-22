import 'package:flutter/material.dart';
import 'package:myapp/screens/proflie_screen.dart';
import 'package:myapp/themes/app_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1;
  PageController _pageController = PageController(initialPage: 1);

  // Danh sách các màn hình cần hiển thị
  final List<Widget> _screens = [
    Container(color: Colors.blue), // Trang chủ
    Container(color: Colors.green), // Thống kê
    Container(color: Colors.orange), // Tổng quan
    Container(color: const Color.fromARGB(255, 87, 78, 65)), // Tổng quan
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        onPageChanged: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
            _pageController.jumpToPage(newIndex);
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'Trang chủ',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Bản ghi',
            icon: Icon(Icons.notes),
          ),
          BottomNavigationBarItem(
            label: "Thống kê",
            icon: Icon(Icons.pivot_table_chart),
          ),
          BottomNavigationBarItem(
            label: "Tổng quan",
            icon: Image(
              image: AssetImage('assets/images/girl-icon.png'),
              width: 20,
              height: 20,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person),
          )
        ],
        selectedItemColor:
            Color.fromARGB(255, 186, 27, 168), // Màu sắc khi mục được chọn
        unselectedItemColor: Color.fromARGB(255, 205, 194, 194),
        selectedIconTheme:
            IconThemeData(color: Color.fromARGB(255, 186, 27, 168)),
        unselectedIconTheme: IconThemeData(
            color: const Color.fromARGB(
                255, 205, 194, 194)), // Màu sắc khi mục không được chọn

        showSelectedLabels: true, // Ẩn label khi được chọn
        showUnselectedLabels: false, // Ẩn label khi không được chọn
      ),
    );
  }
}
