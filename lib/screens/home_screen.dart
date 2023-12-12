import 'package:flutter/material.dart';
import 'package:myapp/themes/app_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1;
  String? urlAvt;

  Future<void> setUrlAvatar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      urlAvt = prefs.getString('avatar');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUrlAvatar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(999)),
                      ),
                      child: urlAvt != null ?
                      ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: Image.network(
                              urlAvt!,
                              width: 50,
                             height: 50,
                              fit: BoxFit.cover,),
                      ) :
                      Text("D", style: AppFont.primaryFont.copyWith(
                          color: Colors.white
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('D', style: AppFont.primaryFont.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w600
                        ),),
                        Text("1 ngày", style: AppFont.primaryFont.copyWith(
                          color: Colors.black12,
                          fontSize: 15,
                          fontWeight: FontWeight.w600
                        ),)
                      ],
                    )
                  ],
                ),
                TextButton(
                  onPressed: () {
                    // Handle button press
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                  ),
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/icons8-no-reminders-50.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )

              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int newIndex){
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'Trang chủ',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Thống kê",
            icon: Icon(Icons.pivot_table_chart),
          ),
          BottomNavigationBarItem(
            label: "Tổng quan",
            icon: Image(image: AssetImage('assets/images/girl-icon.png'),width: 20, height: 20,),
          ),
        ],
        showSelectedLabels: true, // Ẩn label khi được chọn
        showUnselectedLabels: false, // Ẩn label khi không được chọn
      ),
    );
  }
}
