import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 83, 74, 70), // Chọn màu .,
        title: Text(
          'Tài Khoản',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 83, 74, 70), // Chọn màu sắc bạn muốn ở đây

        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.pink.shade100,
                      border: Border.all(
                        color: Colors.pink.shade100, // Màu của border
                        width: 2.0, // Độ dày của border
                      ),
                      borderRadius:
                          BorderRadius.circular(14), // Độ cong của border
                    ),
                    height: 140,
                    width: screenWidth, // Sử dụng chiều rộng của màn hình
                    child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Không bao giờ mất dữ liệu của bạn!',
                              style: TextStyle(
                                color: Colors.brown.shade700, // Màu của văn bản
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Để đồng bộ hóa và khôi phục dữ liệu, bạn cần tạo tài khoản hoặc đăng nhập.',
                              style: TextStyle(
                                fontSize: 15,

                                color: Colors.black54,
                                // Màu của văn bản
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            GestureDetector(
                              child: InkWell(
                                onTap: () {
                                  // Xử lý khi nút được nhấn
                                },
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                      fixedSize: Size(150, 35)),
                                  child: Text(
                                    'Đăng Nhập',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.brown.shade700,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 70, 61, 56), // Chọn màu
                      border: Border.all(
                        color: Color.fromARGB(255, 70, 61, 56), // Chọn màu
                        width: 2.0, // Độ dày của border
                      ),
                      borderRadius:
                          BorderRadius.circular(14), // Độ cong của border
                    ),
                    height: 140,
                    width: screenWidth, // Sử dụng chiều rộng của màn hình
                    child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Không bao giờ mất dữ liệu của bạn!',
                              style: TextStyle(
                                color: Colors.black54, // Màu của văn bản
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Các tính năng tiên tiến',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white60,
                                // Màu của văn bản
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            GestureDetector(
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.pink.shade300,
                                    fixedSize: Size(190, 40)),
                                child: Text(
                                  'Nhận gói Premium',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white, // Màu của văn bản
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    'Hồ sơ',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  child: ElevatedButton(
                    onPressed: () {
                      // Xử lý sự kiện khi nút được nhấn
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              0), // Đặt giá trị này để không có góc bo
                          side: BorderSide.none, // Loại bỏ border
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 83, 74, 70),
                      ), // Màu sắc của button
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50, // Kích thước của hình tròn
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(
                                255, 206, 174, 160), // Màu sắc của hình tròn
                          ),
                        ),
                        SizedBox(
                            width:
                                8), // Khoảng cách giữa hình tròn và dòng text
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(
                                'Tu',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white, // Màu sắc của văn bản
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(
                                '5 Năm',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white, // Màu sắc của văn bản
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  child: ElevatedButton(
                    onPressed: () {
                      // Xử lý sự kiện khi nút được nhấn
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              0), // Đặt giá trị này để không có góc bo
                          side: BorderSide.none, // Loại bỏ border
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 83, 74, 70),
                      ), // Màu sắc của button
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50, // Kích thước của hình tròn
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(
                                255, 206, 174, 160), // Màu sắc của hình tròn
                          ),
                          child: Icon(
                            Icons.add, // Biểu tượng dấu cộng (+)
                            color: Colors.white70, // Biểu tượng dấu cộng (+)
                          ),
                        ),
                        SizedBox(
                            width:
                                8), // Khoảng cách giữa hình tròn và dòng text
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(
                                'Thêm em bé',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white, // Màu sắc của văn bản
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  child: ElevatedButton(
                    onPressed: () {
                      // Xử lý sự kiện khi nút được nhấn
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              0), // Đặt giá trị này để không có góc bo
                          side: BorderSide.none, // Loại bỏ border
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 83, 74, 70),
                      ), // Màu sắc của button
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50, // Kích thước của hình tròn
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(
                                255, 206, 174, 160), // Màu sắc của hình tròn
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white70, // Biểu tượng dấu cộng (+)
                          ),
                        ),
                        SizedBox(
                            width:
                                8), // Khoảng cách giữa hình tròn và dòng text
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(
                                'Thêm mẹ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white, // Màu sắc của văn bản
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  child: ElevatedButton(
                    onPressed: () {
                      // Xử lý sự kiện khi nút được nhấn
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              0), // Đặt giá trị này để không có góc bo
                          side: BorderSide.none, // Loại bỏ border
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 83, 74, 70),
                      ), // Màu sắc của button
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50, // Kích thước của hình tròn
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(
                                255, 206, 174, 160), // Màu sắc của hình tròn
                          ),
                          child: Theme(
                            data: ThemeData(
                              iconTheme: IconThemeData(
                                color: Colors.white70, // Màu sắc của biểu tượng
                              ),
                            ),
                            child: Icon(Icons.person_add),
                          ),
                        ),
                        SizedBox(
                            width:
                                8), // Khoảng cách giữa hình tròn và dòng text
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(
                                'Nhập mã mời',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white, // Màu sắc của văn bản
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Thêm các ElevatedButton khác tương tự tại đây
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.white10,
                    width: 1.0,
                  ),
                ),
              ),
              child: GestureDetector(
                child: TextButton(
                  onPressed: () {
                    // Xử lý sự kiện khi nút được nhấn
                  },
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(
                        Size.fromHeight(50.0)), // Tăng chiều cao
                    alignment: Alignment.centerLeft, // Căn chữ ra bên trái
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(8),
                          bottom: Radius.circular(0),
                        ),
                      ),
                    ),
                  ),
                  child: Text(
                    'Cài đặt',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.white10,
                    width: 1.0,
                  ),
                ),
              ),
              child: GestureDetector(
                child: TextButton(
                  onPressed: () {
                    // Xử lý sự kiện khi nút được nhấn
                  },
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(
                        Size.fromHeight(50.0)), // Tăng chiều cao
                    alignment: Alignment.centerLeft, // Căn chữ ra bên trái
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(8),
                          bottom: Radius.circular(0),
                        ),
                      ),
                    ),
                  ),
                  child: Text(
                    'Gửi cho chúng tôi',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.white10,
                    width: 1.0,
                  ),
                ),
              ),
              child: GestureDetector(
                child: TextButton(
                  onPressed: () {
                    // Xử lý sự kiện khi nút được nhấn
                  },
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(
                        Size.fromHeight(50.0)), // Tăng chiều cao
                    alignment: Alignment.centerLeft, // Căn chữ ra bên trái
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(8),
                          bottom: Radius.circular(0),
                        ),
                      ),
                    ),
                  ),
                  child: Text(
                    'Đánh giá ứng dụng',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.white10,
                    width: 1.0,
                  ),
                ),
              ),
              child: TextButton(
                onPressed: () {
                  // Xử lý sự kiện khi nút được nhấn
                },
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(
                      Size.fromHeight(50.0)), // Tăng chiều cao
                  alignment: Alignment.centerLeft, // Căn chữ ra bên trái
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(8),
                        bottom: Radius.circular(0),
                      ),
                    ),
                  ),
                ),
                child: Text(
                  'Nói với bạn bè',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            GestureDetector(
              child: TextButton(
                onPressed: () {
                  // Xử lý sự kiện khi nút được nhấn
                },
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(
                      Size.fromHeight(50.0)), // Tăng chiều cao

                  side: MaterialStateProperty.all(
                    BorderSide(
                      color: Colors.white10,
                      width: 1.0,
                    ),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(),
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                child: Text(
                  'Thông tin ứng dụng',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20),
                ),
              ),
            ),

            // Thêm các phần tử ListTile khác tương tự tại đây
          ],
        ),
      ),
    );
  }
}
